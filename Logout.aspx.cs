using System;
using System.Data.SqlClient;

namespace WorkNest
{
    public partial class Logout : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                dbConn.dbConnect();
                if (Session["EmployeeID"] != null)

                {
                    SqlCommand updateCmd = new SqlCommand(@"
                           UPDATE TIME_TRACKING 
                           SET LOGOUT_TIME = GETDATE(), 
                           TOTAL_HOURS = DATEDIFF(MINUTE, LOGIN_TIME, GETDATE()) / 60.0
                           WHERE EMPLOYEE_ID = @empId AND LOGOUT_TIME IS NULL", dbConn.con);

                    updateCmd.Parameters.AddWithValue("@empId", Session["EmployeeID"].ToString());
                    updateCmd.ExecuteNonQuery();
                    Session.Clear();
                    Session.Abandon();
                    Response.Redirect("~/Login.aspx");
                }
                else
                {
                    Response.Redirect("~/Login.aspx");

                }
            }
        }
    }
}