using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class Employees : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        public void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees();
            }
        }

        public void LoadEmployees(string searchQuery = "")
        {
            dbConn.dbConnect();

            string query = @"
            SELECT 
                e.EMPLOYEE_ID,
                e.FULL_NAME, 
                e.EMAIL, 
                e.PHONE_NUMBER, 
                e.HIRE_DATE, 
                e.IMAGE, 
                d.DEPARTMENT_NAME 
            FROM EMPLOYEE e
            JOIN DEPARTMENT d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID";

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " WHERE e.FULL_NAME LIKE @Search OR e.EMAIL LIKE @Search";
            }

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            if (!string.IsNullOrEmpty(searchQuery))
            {
                cmd.Parameters.AddWithValue("@Search", "%" + searchQuery + "%");
            }

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            // Add a new column for the Base64 string
            dt.Columns.Add("IMAGE_BASE64", typeof(string));

            // Convert image to Base64
            foreach (DataRow row in dt.Rows)
            {
                if (row["IMAGE"] != DBNull.Value)
                {
                    byte[] imageBytes = (byte[])row["IMAGE"];
                    string base64String = Convert.ToBase64String(imageBytes);
                    row["IMAGE_BASE64"] = "data:image/png;base64," + base64String;  // Change "png" based on stored format
                }
                else
                {
                    row["IMAGE_BASE64"] = "path/to/default/image.jpg";  // Default image path if no photo
                }
            }

            rptEmployees.DataSource = dt;
            rptEmployees.DataBind();
        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim();
            LoadEmployees(searchText);
        }

        public void rptEmployees_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteEmployee")
            {
                string employeeId = e.CommandArgument.ToString();
                DeleteEmployee(employeeId);
            }
        }
        //Response.Write("<script>if(!confirm('Are you sure you want to delete this employee?')) {windows.location='Employees.aspx';}</script>");


        public void DeleteEmployee(string employeeId)
        {
            try
            {
                dbConn.dbConnect();
                using (SqlTransaction transaction = dbConn.con.BeginTransaction())
                {
                    try
                    {
                        // Delete related records
                        string[] queries = {
                    "DELETE FROM TASK WHERE ASSIGN_TO = @EmployeeId",
                    "DELETE FROM LEAVES WHERE EMPLOYEE_ID = @EmployeeId",
                    "DELETE FROM USER_CREDENTIALS WHERE EMPLOYEE_ID = @EmployeeId",
                    "DELETE FROM EMPLOYEE_ROLES WHERE EMPLOYEE_ID = @EmployeeId",
                    "DELETE FROM ATTENDANCE WHERE EMPLOYEE_ID = @EmployeeId",
                    "DELETE FROM EMPLOYEE WHERE EMPLOYEE_ID = @EmployeeId"
                };

                        using (SqlCommand cmd = new SqlCommand())
                        {
                            cmd.Connection = dbConn.con;
                            cmd.Transaction = transaction;

                            foreach (string query in queries)
                            {
                                cmd.CommandText = query;
                                cmd.Parameters.Clear();
                                cmd.Parameters.AddWithValue("@EmployeeId", employeeId);
                                cmd.ExecuteNonQuery();
                            }
                        }

                        transaction.Commit();
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Employee deleted successfully'); window.location='Employees.aspx';", true);
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }



    }
}
