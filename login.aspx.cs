using System;
using System.Data.SqlClient;

namespace WorkNest
{
    public partial class login : System.Web.UI.Page
    {
        // SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            dbConnection dbConn = new dbConnection();
            dbConn.dbConnect();

            string loginQuery = "SELECT EMPLOYEE_ID FROM USER_CREDENTIALS WHERE USER_NAME = @Username AND PASSWORD = @Password";
            // string imageQuery = "SELECT IMAGE FROM EMPLOYEES WHERE USER_NAME = @Username AND PASSWORD = @Password";

            try
            {
                // Check user credentials
                SqlCommand loginCmd = new SqlCommand(loginQuery, dbConn.con);
                loginCmd.Parameters.AddWithValue("@Username", username);
                loginCmd.Parameters.AddWithValue("@Password", password);
                object empIdObj = loginCmd.ExecuteScalar();

                if (empIdObj == null)
                {
                    lblMessage.Text = "Invalid Username or Password!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                int empId = Convert.ToInt32(empIdObj);

                string roleQuery = "SELECT R.ROLE_NAME FROM ROLES R JOIN EMPLOYEE_ROLES E ON R.ROLE_ID=E.ROLE_ID WHERE EMPLOYEE_ID = @empId";

                SqlCommand roleCmd = new SqlCommand(roleQuery, dbConn.con);
                roleCmd.Parameters.AddWithValue("@empId", empId);
                object roleObj = roleCmd.ExecuteScalar();

                if (roleObj == null)
                {
                    lblMessage.Text = "Role not assigned!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string roleName = roleObj.ToString();

                

                Session["Username"] = username;
                Session["EmployeeID"] = empId;
                Session["UserRole"] = roleName;

                if (roleName == "Admin")
                {
                    Response.Redirect("Admin/AdminHome.aspx");
                }
                else if (roleName == "Project_Manager")
                {
                    Response.Redirect("Project_Manager/P_ManagerHome.aspx");
                }
                else
                {
                    Response.Redirect("P_Member/MemberHome.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Write($"Error: {ex.Message}");
            }
            finally
            {
                dbConn.con.Close();
            }
        }
    }
}