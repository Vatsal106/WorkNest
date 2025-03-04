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
                d.DEPARTMENT_NAME,
                r.ROLE_NAME,
                r.ROLE_ID
                FROM EMPLOYEE e
                JOIN DEPARTMENT d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
                JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID
                JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID
                Where r.ROLE_ID <> 1";

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND (e.FULL_NAME LIKE @Search OR e.EMAIL LIKE @Search)";
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

        public void DeleteEmployee(string employeeId)
        {
            try
            {
                // Ensure dbConn is initialized
                if (dbConn == null)
                {
                    dbConn = new dbConnection();
                }

                // Ensure database connection is open
                if (dbConn.con == null || dbConn.con.State == ConnectionState.Closed)
                {
                    dbConn.dbConnect();
                }

                using (SqlTransaction transaction = dbConn.con.BeginTransaction())
                {
                    try
                    {
                        // 1️⃣ Update PROJECT to remove the reference to the Employee
                        string updateProjectQuery = "UPDATE PROJECT SET PROJECT_MANAGER_ID = NULL WHERE PROJECT_MANAGER_ID = @EmployeeId";
                        using (SqlCommand cmd = new SqlCommand(updateProjectQuery, dbConn.con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@EmployeeId", employeeId);
                            cmd.ExecuteNonQuery();
                        }

                        // 2️⃣ Delete dependent records first
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
                        Response.Write("<script>alert('Employee deleted successfully'); window.location='Employees.aspx';</script>");
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        Response.Write("<script>alert('Transaction Error: " + ex.Message + "');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

    }
}

