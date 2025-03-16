using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class AttendanceTracking : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDepartments();
                LoadAttendance(DateTime.Today, null);
            }
        }

        protected void LoadDepartments()
        {
            dbConn.dbConnect();
            string query = "SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENT";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            SqlDataReader reader = cmd.ExecuteReader();

            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add(new ListItem("All Departments", "0"));

            while (reader.Read())
            {
                ddlDepartment.Items.Add(new ListItem(reader["DEPARTMENT_NAME"].ToString(), reader["DEPARTMENT_ID"].ToString()));
            }

            reader.Close();
            dbConn.con.Close();
        }

        protected void LoadAttendance(DateTime selectedDate, int? departmentId)
        {
            if (selectedDate < new DateTime(1753, 1, 1))
            {
                throw new ArgumentOutOfRangeException(nameof(selectedDate), "Selected date must be between 1/1/1753 and 12/31/9999.");
            }

            dbConn.dbConnect();

            string query = @"
                WITH AttendanceCTE AS (
                    SELECT 
                        EMPLOYEE_ID, 
                        MIN(LOGIN_TIME) AS LOGIN_TIME,
                        MAX(LOGOUT_TIME) AS LOGOUT_TIME,
                        SUM(DATEDIFF(MINUTE, LOGIN_TIME, LOGOUT_TIME)) / 60.0 AS TOTAL_HOURS
                    FROM TIME_TRACKING
                    WHERE WORK_DATE = @WorkDate
                    GROUP BY EMPLOYEE_ID
                )
                SELECT 
                    E.FULL_NAME, 
                    D.DEPARTMENT_NAME, 
                    A.LOGIN_TIME, 
                    A.LOGOUT_TIME, 
                    ISNULL(A.TOTAL_HOURS, 0) AS TOTAL_HOURS,
                    CASE 
                        WHEN A.LOGIN_TIME IS NULL THEN 'Absent' 
                        ELSE 'Present' 
                    END AS STATUS
                FROM EMPLOYEE E
                LEFT JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                LEFT JOIN AttendanceCTE A ON E.EMPLOYEE_ID = A.EMPLOYEE_ID
                WHERE (@DeptId IS NULL OR E.DEPARTMENT_ID = @DeptId)
                ORDER BY D.DEPARTMENT_NAME, E.FULL_NAME";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@WorkDate", selectedDate);
            cmd.Parameters.AddWithValue("@DeptId", (object)departmentId ?? DBNull.Value);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();

            dbConn.con.Close();
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            int? departmentId = ddlDepartment.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlDepartment.SelectedValue);
            LoadAttendance(Calendar1.SelectedDate, departmentId);
        }

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            int? departmentId = ddlDepartment.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlDepartment.SelectedValue);
            DateTime selectedDate = Calendar1.SelectedDate;

            if (selectedDate < new DateTime(1753, 1, 1) || selectedDate > new DateTime(9999, 12, 31))
            {
                // Handle the invalid date scenario, e.g., show an error message to the user
                lblError.Text = "Please select a valid date.";
                return;
            }

            LoadAttendance(selectedDate, departmentId);
        }
    }
}
