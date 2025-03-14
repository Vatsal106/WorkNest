using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System;

namespace WorkNest.Project_Manager
{
    public partial class P_ManagerHome : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardStats();
                LoadProjectOverview();
                LoadTaskManagement();
                LoadTeamMembers();
                LoadLeaveRequests();
                LoadActivityLog();
            }
        }

        private void LoadDashboardStats()
        {
            dbConn.dbConnect();

            try
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM EMPLOYEE", dbConn.con);
                lblTotalEmployees.Text = cmd.ExecuteScalar().ToString();

                cmd.CommandText = "SELECT COUNT(*) FROM PROJECT WHERE STATUS = 'Active' AND PROJECT_MANAGER_ID = @ManagerId";
                cmd.Parameters.AddWithValue("@ManagerId", Session["EmployeeID"]);
                lblTotalProjects.Text = cmd.ExecuteScalar().ToString();

                cmd.CommandText = "SELECT COUNT(*) FROM TASK WHERE DUE_DATE > GETDATE() AND PROJECT_ID IN (SELECT PROJECT_ID FROM PROJECT WHERE PROJECT_MANAGER_ID = @ManagerId)";
                lblTotalTasks.Text = cmd.ExecuteScalar().ToString();

                cmd.CommandText = "SELECT COUNT(*) FROM LEAVES WHERE STATUS = 'Pending' AND EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM PROJECT WHERE PROJECT_MANAGER_ID = @ManagerId))";
                lblPendingLeaves.Text = cmd.ExecuteScalar().ToString();
            }
            catch (Exception ex)
            {
                lblTotalEmployees.Text = "Error";
                lblTotalProjects.Text = "Error";
                lblTotalTasks.Text = "Error";
                lblPendingLeaves.Text = "Error";
                System.Diagnostics.Debug.WriteLine("Error in LoadDashboardStats: " + ex.Message);
            }
        }

        private void LoadProjectOverview()
        {
            string query = @"SELECT p.PROJECT_NAME, c.CLIENT_NAME, p.START_DATE, p.END_DATE, p.STATUS, 
                             (SELECT COUNT(*) FROM EMPLOYEE e WHERE e.EMPLOYEE_ID IN (SELECT t.ASSIGN_TO FROM TASK t WHERE t.PROJECT_ID = p.PROJECT_ID)) AS EMPLOYEE_COUNT
                             FROM PROJECT p
                             INNER JOIN CLIENTS c ON p.CLIENT_ID = c.CLIENT_ID
                             WHERE p.PROJECT_MANAGER_ID = @ManagerId";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ManagerId", Session["EmployeeID"]);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvProjectOverview.DataSource = dt;
            gvProjectOverview.DataBind();
        }

        private void LoadTaskManagement()
        {
            string query = @"SELECT t.TASK_NAME, t.START_DATE, t.DUE_DATE, t.STATUS, e.FULL_NAME AS ASSIGNED_EMPLOYEE
                             FROM TASK t
                             INNER JOIN EMPLOYEE e ON t.ASSIGN_TO = e.EMPLOYEE_ID
                             WHERE t.PROJECT_ID IN (SELECT p.PROJECT_ID FROM PROJECT p WHERE p.PROJECT_MANAGER_ID = @ManagerId)";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ManagerId", Session["EmployeeID"]);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvTaskManagement.DataSource = dt;
            gvTaskManagement.DataBind();
        }

        private void LoadTeamMembers()
        {
            string query = @"
    SELECT e.FULL_NAME, 
           e.EMAIL, 
           r.ROLE_NAME AS ROLE, 
           (SELECT COUNT(*) FROM TASK t WHERE t.ASSIGN_TO = e.EMPLOYEE_ID) AS ASSIGNED_TASK_COUNT
    FROM EMPLOYEE e
    INNER JOIN EMPLOYEE_ROLES er ON e.EMPLOYEE_ID = er.EMPLOYEE_ID
    INNER JOIN ROLES r ON er.ROLE_ID = r.ROLE_ID
    WHERE e.EMPLOYEE_ID IN (SELECT DISTINCT t.ASSIGN_TO 
        FROM TASK t
        INNER JOIN PROJECT p ON t.PROJECT_ID = p.PROJECT_ID
        WHERE p.PROJECT_MANAGER_ID = @ManagerId)";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ManagerId", Session["EmployeeID"]);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvTeamMembers.DataSource = dt;
            gvTeamMembers.DataBind();
        }

        private void LoadLeaveRequests()
        {
            string query = @"
    SELECT L.LEAVE_ID,  
           E.FULL_NAME AS EMPLOYEE_NAME, 
           L.START_DATE, 
           L.END_DATE, 
           L.REASON, 
           L.STATUS 
    FROM LEAVES L 
    JOIN EMPLOYEE E ON L.EMPLOYEE_ID = E.EMPLOYEE_ID
    JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID
    JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID
    WHERE R.ROLE_NAME = 'Project_Member' 
          AND E.EMPLOYEE_ID IN (
              SELECT DISTINCT T.ASSIGN_TO 
              FROM TASK T
              INNER JOIN PROJECT P ON T.PROJECT_ID = P.PROJECT_ID
              WHERE P.PROJECT_MANAGER_ID = @ManagerId
          )";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ManagerId", Session["EmployeeID"]);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvLeaveRequests.DataSource = dt;
            gvLeaveRequests.DataBind();
        }

        private void LoadActivityLog()
        {
            string query = @"SELECT t.TASK_NAME, trh.UPDATED_AT AS UPDATE_TIME, trh.DESCRIPTION, trh.TASK_FILE AS FILE_ATTACHMENT
                     FROM TASK_REPORT_HISTORY trh
                     INNER JOIN TASK t ON trh.TASK_ID = t.TASK_ID
                     WHERE t.PROJECT_ID IN (SELECT p.PROJECT_ID FROM PROJECT p WHERE p.PROJECT_MANAGER_ID = @ManagerId)";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ManagerId", Session["EmployeeID"]);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvActivityLog.DataSource = dt;
            gvActivityLog.DataBind();
        }

    }
}
