using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                if (Session["TimeLogs"] == null)
                {
                    LoadTimeLogs();
                }
                LoadEmployeeDetails();
            }
        }

        public void LoadTimeLogs()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            dbConn.dbConnect();

            string query = @"
        SELECT 
            FORMAT(CONVERT(DATE, START_TIME), 'dd-MM-yyyy') AS LogDate, 
            SUM(TOTAL_WORK_HOURS) AS TotalWorkHours, 
            SUM(TOTAL_BREAK_HOURS) AS TotalBreakHours
        FROM TIME_TRACKING
        WHERE EMPLOYEE_ID = @EmployeeID AND START_TIME >= DATEADD(DAY, -6, GETDATE())
        GROUP BY CONVERT(DATE, START_TIME)
        ORDER BY LogDate";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dbConn.con.Close();
            Session["TimeLogs"] = dt;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow row in dt.Rows)
            {
                Dictionary<string, object> rowData = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    rowData[col.ColumnName] = row[col];
                }
                rows.Add(rowData);
            }

            string jsonData = serializer.Serialize(rows);
            ScriptManager.RegisterStartupScript(this, GetType(), "LoadChart", "loadChart(" + jsonData + ");", true);
        }

        protected void AttendanceCalendar_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {
            LoadTimeLogs();
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
        protected void AttendanceCalendar_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.IsOtherMonth) return;

            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            DateTime date = e.Day.Date;
            string formattedDate = date.ToString("yyyy-MM-dd");

            dbConn.dbConnect();

            string query = "SELECT STATUS FROM ATTENDANCE WHERE EMPLOYEE_ID = @EmployeeID AND ATTENDANCE_DATE = @AttendanceDate";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
            cmd.Parameters.AddWithValue("@AttendanceDate", formattedDate);

            SqlDataReader reader = cmd.ExecuteReader();

            string status = "Absent";
            string statusClass = "absent-dot";
            string tooltipText = "Absent";

            if (reader.Read())
            {
                status = reader["STATUS"].ToString();
                if (status == "Present")
                {
                    statusClass = "present-dot";
                    tooltipText = "Present";
                }
            }

            reader.Close();
            dbConn.con.Close();

            e.Cell.Controls.Add(new LiteralControl($"<div class='{statusClass}' title='{tooltipText}'></div>"));
        }




        protected void btnClockIn_Click(object sender, EventArgs e)
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            DateTime startTime = DateTime.Now;
            string currentDate = startTime.ToString("yyyy-MM-dd");

            try
            {
                dbConn.dbConnect(); // Ensure connection is open

                if (dbConn.con.State == ConnectionState.Closed)
                {
                    dbConn.con.Open();
                }

                // Insert Time Tracking Entry
                string query = "INSERT INTO TIME_TRACKING (EMPLOYEE_ID, START_TIME) VALUES (@EmployeeID, @StartTime)";
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                cmd.Parameters.AddWithValue("@StartTime", startTime);
                cmd.ExecuteNonQuery();

                // Insert Attendance Entry if not exists
                string attendanceQuery = @"
        IF NOT EXISTS (SELECT 1 FROM ATTENDANCE WHERE EMPLOYEE_ID = @EmployeeID AND ATTENDANCE_DATE = @AttendanceDate)
        BEGIN
            INSERT INTO ATTENDANCE (EMPLOYEE_ID, ATTENDANCE_DATE, STATUS) 
            VALUES (@EmployeeID, @AttendanceDate, 'Present')
        END";

                SqlCommand attendanceCmd = new SqlCommand(attendanceQuery, dbConn.con);
                attendanceCmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                attendanceCmd.Parameters.AddWithValue("@AttendanceDate", currentDate);
                attendanceCmd.ExecuteNonQuery();

                // Update UI and reload logs
                LoadTimeLogs();
                ScriptManager.RegisterStartupScript(this, GetType(), "StartWorkTimer", "startWorkTimer();", true);
                btnClockIn.CssClass = "btn btn-success d-none";
                btnBreakTime.CssClass = "btn btn-warning";
                btnClockOut.CssClass = "btn btn-danger";
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                if (dbConn.con.State == ConnectionState.Open)
                {
                    dbConn.con.Close(); // Always close connection after execution
                }
            }
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
            LoadTimeLogs();

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
            LoadTimeLogs();

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
            LoadTimeLogs();

            ScriptManager.RegisterStartupScript(this, GetType(), "StopAllTimers", "resetTimers();", true);
            btnClockIn.CssClass = "btn btn-success";
            btnBreakTime.CssClass = "btn btn-warning d-none";
            btnStopBreak.CssClass = "btn btn-danger d-none";
            btnClockOut.CssClass = "btn btn-danger d-none";
        }


    }
}
