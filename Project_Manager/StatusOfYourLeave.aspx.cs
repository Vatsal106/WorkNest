using System;
using System.Data;
using System.Data.SqlClient;

namespace WorkNest.Project_Manager
{
    public partial class StatusOfYourLeave : System.Web.UI.Page
    {
        dbConnection dbconn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLeaveStatus();
            }
        }

        private void LoadLeaveStatus()
        {
            dbconn.dbConnect();
            int employeeID = GetLoggedInEmployeeID(); // Retrieve the logged-in Employee ID


            SqlCommand cmd = new SqlCommand(@"SELECT LEAVE_ID, START_DATE, END_DATE, LEAVE_TYPE, REASON, STATUS,
                        FILE_NAME, FILE_EXTANSION FROM LEAVES WHERE EMPLOYEE_ID = @EmployeeID", dbconn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvLeaves.DataSource = dt;
            gvLeaves.DataBind();
        }

        private int GetLoggedInEmployeeID()
        {
            if (Session["EmployeeID"] != null)
            {
                return Convert.ToInt32(Session["EmployeeID"]);
            }
            else
            {
                Response.Redirect("~/Login.aspx");
                return 0;
            }
        }

        // Method to apply CSS class to Status column
        protected string GetStatusClass(string status)
        {
            switch (status.ToUpper())
            {
                case "APPROVED": return "status-badge status-approved";
                case "PENDING": return "status-badge status-pending";
                case "REJECTED": return "status-badge status-rejected";
                default: return "";
            }
        }
    }
}
