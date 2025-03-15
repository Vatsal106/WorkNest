using System;
using System.Data.SqlClient;
using System.Data;
using System.Text;

namespace WorkNest.P_Member
{
    public partial class MemberHome : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfile();
                LoadProjectDetails();
                LoadLeaveHistory();
                LoadTasks();
                LoadActivityLog();
            }
        }

        private void LoadProfile()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            dbConn.dbConnect();
            SqlCommand cmd = new SqlCommand("SELECT FULL_NAME, EMAIL, PHONE_NUMBER FROM EMPLOYEE WHERE EMPLOYEE_ID = @EmpID", dbConn.con);
            cmd.Parameters.AddWithValue("@EmpID", employeeId);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblFullName.InnerText = reader["FULL_NAME"].ToString();
                lblEmail.InnerText = reader["EMAIL"].ToString();
                lblPhone.InnerText = reader["PHONE_NUMBER"].ToString();
            }
            reader.Close();
        }

        private void LoadProjectDetails()
        {
            string query = "SELECT PROJECT_NAME, DESCRIPTION, STATUS FROM PROJECT";
            projectDetails.InnerHtml = GenerateTableRows(query);
        }

        private void LoadLeaveHistory()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            string query = "SELECT START_DATE, END_DATE, LEAVE_TYPE, STATUS FROM LEAVES WHERE EMPLOYEE_ID = @EmpID";
            leaveHistory.InnerHtml = GenerateTableRows(query, employeeId);
        }

        private void LoadTasks()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            string query = "SELECT TASK_NAME, DESCRIPTION, START_DATE, DUE_DATE, STATUS FROM TASK WHERE ASSIGN_TO = @EmpID";
            tasksList.InnerHtml = GenerateTableRows(query, employeeId);
        }

        private void LoadActivityLog()
        {
            string query = @"
                SELECT T.TASK_NAME, TRH.DESCRIPTION, TRH.UPDATED_AT 
                FROM TASK_REPORT_HISTORY TRH 
                JOIN TASK T ON TRH.TASK_ID = T.TASK_ID";
            activityLog.InnerHtml = GenerateTableRows(query);
        }

        private string GenerateTableRows(string query, int empId = 0)
        {
            dbConn.dbConnect();
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            if (empId > 0) cmd.Parameters.AddWithValue("@EmpID", empId);
            SqlDataReader reader = cmd.ExecuteReader();
            StringBuilder html = new StringBuilder();
            while (reader.Read())
            {
                html.Append("<tr>");
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    html.Append($"<td>{reader[i]}</td>");
                }
                html.Append("</tr>");
            }
            reader.Close();
            return html.ToString();
        }
    }
}
