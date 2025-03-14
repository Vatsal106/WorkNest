using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.Project_Manager
{
    public partial class EmployeesUnderYou : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        public void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    LoadEmployees();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading page: " + ex.Message + "');</script>");
            }
        }

        public void LoadEmployees(string searchQuery = "")
        {
            dbConn.dbConnect();
            try
            {
                int manager_id = Convert.ToInt32(Session["EmployeeID"]);
                string query = @"
            SELECT DISTINCT
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
            JOIN EMPLOYEE_ROLES er ON e.EMPLOYEE_ID = er.EMPLOYEE_ID
            JOIN ROLES r ON er.ROLE_ID = r.ROLE_ID
            JOIN TASK t ON e.EMPLOYEE_ID = t.ASSIGN_TO
            JOIN PROJECT p ON t.PROJECT_ID = p.PROJECT_ID
            WHERE p.PROJECT_MANAGER_ID = @ManagerId
            AND r.ROLE_ID <> 1";

                if (!string.IsNullOrEmpty(searchQuery))
                {
                    query += " AND (e.FULL_NAME LIKE @Search OR e.EMAIL LIKE @Search)";
                }

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@ManagerId", manager_id);
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + searchQuery + "%");
                }

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adpt.Fill(dt);

                dt.Columns.Add("IMAGE_BASE64", typeof(string));

                foreach (DataRow row in dt.Rows)
                {
                    if (row["IMAGE"] != DBNull.Value)
                    {
                        byte[] imageBytes = (byte[])row["IMAGE"];
                        string base64String = Convert.ToBase64String(imageBytes);
                        row["IMAGE_BASE64"] = "data:image/png;base64," + base64String;
                    }
                    else
                    {
                        row["IMAGE_BASE64"] = "~/Images/employee photo.jpg";
                    }
                }

                rptEmployees.DataSource = dt;
                rptEmployees.DataBind();

                cmd.Dispose();
                adpt.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading employees: " + ex.Message + "');</script>");
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string searchText = txtSearch.Text.Trim();
                LoadEmployees(searchText);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error searching employees: " + ex.Message + "');</script>");
            }
        }

        public void rptEmployees_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteEmployee")
                {
                    string employeeId = e.CommandArgument.ToString();
                    DeleteEmployee(employeeId);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error processing employee command: " + ex.Message + "');</script>");
            }
        }

        public void DeleteEmployee(string employeeId)
        {
            try
            {
                if (dbConn == null)
                {
                    dbConn = new dbConnection();
                }

                if (dbConn.con == null || dbConn.con.State == ConnectionState.Closed)
                {
                    dbConn.dbConnect();
                }

                SqlTransaction transaction = dbConn.con.BeginTransaction();
                try
                {
                    // Set assigned tasks to NULL instead of deleting them
                    string updateTaskQuery = "UPDATE TASK SET ASSIGN_TO = NULL WHERE ASSIGN_TO = @EmployeeId";
                    SqlCommand cmd = new SqlCommand(updateTaskQuery, dbConn.con, transaction);
                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();

                    string[] queries = {
                "DELETE FROM LEAVES WHERE EMPLOYEE_ID = @EmployeeId",
                "DELETE FROM USER_CREDENTIALS WHERE EMPLOYEE_ID = @EmployeeId",
                "DELETE FROM EMPLOYEE_ROLES WHERE EMPLOYEE_ID = @EmployeeId",
                "DELETE FROM ATTENDANCE WHERE EMPLOYEE_ID = @EmployeeId",
                "DELETE FROM EMPLOYEE WHERE EMPLOYEE_ID = @EmployeeId"
            };

                    cmd = new SqlCommand();
                    cmd.Connection = dbConn.con;
                    cmd.Transaction = transaction;

                    foreach (string query in queries)
                    {
                        cmd.CommandText = query;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@EmployeeId", employeeId);
                        cmd.ExecuteNonQuery();
                    }

                    cmd.Dispose();
                    transaction.Commit();
                    Response.Write("<script>alert('Employee deleted successfully'); window.location='EmployeesUnderYou.aspx';</script>");
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    Response.Write("<script>alert('Transaction Error: " + ex.Message + "');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error deleting employee: " + ex.Message + "');</script>");
            }
        }

    }
}
