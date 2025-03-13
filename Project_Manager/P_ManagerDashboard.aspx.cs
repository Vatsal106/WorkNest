using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WorkNest.Project_Manager
{
    public partial class P_ManagerDashboard : Page
    {
    dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("~/login.aspx");
            }
            if (!IsPostBack)
            {
                LoadEmployeeDetails();
                
            }
        }

        public void LoadEmployeeDetails()
        {
            dbConn.dbConnect();
            SqlCommand cmd = new SqlCommand(@"
        SELECT E.FULL_NAME, R.ROLE_NAME 
        FROM EMPLOYEE E
        INNER JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID
        INNER JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID
        WHERE E.EMPLOYEE_ID = @EmployeeID", dbConn.con);

            try
            {
                cmd.Parameters.AddWithValue("@EmployeeID", Session["EmployeeID"]);

                
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string fullName = reader["FULL_NAME"].ToString();
                    lblEmployeeName.Text = fullName;
                    lblEmployeeRole.Text = reader["ROLE_NAME"].ToString();

                    // Generate initials from the full name
                    string[] nameParts = fullName.Split(' ');
                    string initials = nameParts[0][0].ToString().ToUpper();
                    if (nameParts.Length > 1)
                        initials += nameParts[1][0].ToString().ToUpper();

                    lblInitials.Text = initials;
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                lblEmployeeName.Text = "Error loading data";
                lblEmployeeRole.Text = "";
            }
           
        
        }
        protected void btnClockIn_Click(object sender, EventArgs e)
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            DateTime startTime = DateTime.Now;

            string query = "INSERT INTO TIME_TRACKING (EMPLOYEE_ID, START_TIME) VALUES (@EmployeeID, @StartTime)";
            
            dbConn.dbConnect();

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
            cmd.Parameters.AddWithValue("@StartTime", startTime);
            cmd.ExecuteNonQuery();
            dbConn.con.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "StartWorkTimer", "startWorkTimer();", true);
            btnClockIn.CssClass = "btn btn-success d-none";
            btnBreakTime.CssClass = "btn btn-warning";
            btnClockOut.CssClass = "btn btn-danger";
        }

        protected void btnBreakTime_Click(object sender, EventArgs e)
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            DateTime breakStart = DateTime.Now;

            string query = "UPDATE TIME_TRACKING SET BREAK_START = @BreakStart WHERE EMPLOYEE_ID = @EmployeeID AND END_TIME IS NULL";
           
            dbConn.dbConnect();

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
            cmd.Parameters.AddWithValue("@BreakStart", breakStart);
            cmd.ExecuteNonQuery();
            dbConn.con.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "StartBreakTimer", "stopWorkTimer(); startBreakTimer();", true);
            btnBreakTime.CssClass = "btn btn-warning d-none";
            btnStopBreak.CssClass = "btn btn-danger";
        }

        protected void btnStopBreak_Click(object sender, EventArgs e)
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            DateTime breakEnd = DateTime.Now;

            string query = "UPDATE TIME_TRACKING SET BREAK_END = @BreakEnd WHERE EMPLOYEE_ID = @EmployeeID AND BREAK_END IS NULL";
           
            dbConn.dbConnect();

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
            cmd.Parameters.AddWithValue("@BreakEnd", breakEnd);
            cmd.ExecuteNonQuery();
            dbConn.con.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "StopBreakTimer", "stopBreakTimer(); startWorkTimer();", true);
            btnStopBreak.CssClass = "btn btn-danger d-none";
            btnBreakTime.CssClass = "btn btn-warning";
        }

        protected void btnClockOut_Click(object sender, EventArgs e)
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            DateTime endTime = DateTime.Now;

            string query = @"
                UPDATE TIME_TRACKING 
                SET END_TIME = @EndTime, 
                    TOTAL_WORK_HOURS = DATEDIFF(SECOND, START_TIME, @EndTime) / 3600.0, 
                    TOTAL_BREAK_HOURS = DATEDIFF(SECOND, BREAK_START, BREAK_END) / 3600.0 
                WHERE EMPLOYEE_ID = @EmployeeID AND END_TIME IS NULL";

            
            dbConn.dbConnect();

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
            cmd.Parameters.AddWithValue("@EndTime", endTime);
            cmd.ExecuteNonQuery();
            dbConn.con.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "StopAllTimers", "resetTimers();", true);
            btnClockIn.CssClass = "btn btn-success";
            btnBreakTime.CssClass = "btn btn-warning d-none";
            btnStopBreak.CssClass = "btn btn-danger d-none";
            btnClockOut.CssClass = "btn btn-danger d-none";
        }

       
    }
}
