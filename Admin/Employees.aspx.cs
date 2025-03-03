using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
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

        public void LoadEmployees()
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

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            adpt.Fill(dt);
            rptEmployees.DataSource = dt;
            rptEmployees.DataBind();
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
            dbConn.dbConnect();
            string deleteLeavesQuery = "DELETE FROM LEAVES WHERE EMPLOYEE_ID = @EmployeeId";
            SqlCommand deleteLeavesCmd = new SqlCommand(deleteLeavesQuery, dbConn.con);
            deleteLeavesCmd.Parameters.AddWithValue("@EmployeeId", employeeId);
            deleteLeavesCmd.ExecuteNonQuery();

            string deleteUserCredentialsQuery = "DELETE FROM USER_CREDENTIALS WHERE EMPLOYEE_ID = @EmployeeId";
            SqlCommand deleteUserCredentialsCmd = new SqlCommand(deleteUserCredentialsQuery, dbConn.con);
            deleteUserCredentialsCmd.Parameters.AddWithValue("@EmployeeId", employeeId);
            deleteUserCredentialsCmd.ExecuteNonQuery();
            
            string deleteRolesQuery = "DELETE FROM EMPLOYEE_ROLES WHERE EMPLOYEE_ID = @EmployeeId";
            SqlCommand deleteRolesCmd = new SqlCommand(deleteRolesQuery, dbConn.con);
            deleteRolesCmd.Parameters.AddWithValue("@EmployeeId", employeeId);
            deleteRolesCmd.ExecuteNonQuery();

            string deleteAttendanceQuery = "DELETE FROM ATTENDANCE WHERE EMPLOYEE_ID = @EmployeeId";
            SqlCommand deleteAttendanceCmd = new SqlCommand(deleteAttendanceQuery, dbConn.con);
            deleteAttendanceCmd.Parameters.AddWithValue("@EmployeeId", employeeId);
            deleteAttendanceCmd.ExecuteNonQuery();

            string deleteEmployeeQuery = "DELETE FROM EMPLOYEE WHERE EMPLOYEE_ID = @EmployeeId";
            SqlCommand deleteEmployeeCmd = new SqlCommand(deleteEmployeeQuery, dbConn.con);
            deleteEmployeeCmd.Parameters.AddWithValue("@EmployeeId", employeeId);
            int rowsAffected = deleteEmployeeCmd.ExecuteNonQuery();

            dbConn.con.Close();

            if (rowsAffected > 0)
            {
                Response.Write("<script>alert('Employee deleted successfully'); window.location='Employees.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Failed to delete employee');</script>");
            }
        }
    }
}
