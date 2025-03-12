using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Project_Manager
{
    public partial class Tasks : Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTasks();
            }
        }

        private void LoadTasks()
        {
            // Get the logged-in Project Manager's Employee ID from session
            string managerId = Session["EmployeeID"]?.ToString();

            if (string.IsNullOrEmpty(managerId))
            {
                gvTasks.DataSource = null;
                gvTasks.DataBind();
                return;
            }

            dbConn.dbConnect();

            // Query to fetch tasks assigned by Admin to the logged-in Project Manager
            string query = @"
            SELECT T.TASK_ID, 
                   T.TASK_NAME, 
                   T.DESCRIPTION, 
                   T.START_DATE, 
                   T.DUE_DATE, 
                   T.STATUS, 
                   P.PROJECT_NAME
            FROM TASK T
            JOIN PROJECT P ON T.PROJECT_ID = P.PROJECT_ID
            JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
            WHERE T.ASSIGN_TO = @ManagerId";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ManagerId", managerId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvTasks.DataSource = dt;
            gvTasks.DataBind();

            cmd.Dispose();
            da.Dispose();
        }
    }
}

