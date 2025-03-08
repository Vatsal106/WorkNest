using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class SearchTasks : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjects();
                LoadTasksWithReports();
            }
        }

        private void LoadProjects()
        {
            dbConn.dbConnect();
            string query = "SELECT PROJECT_ID, PROJECT_NAME FROM PROJECT";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlProjects.DataSource = dt;
            ddlProjects.DataTextField = "PROJECT_NAME";
            ddlProjects.DataValueField = "PROJECT_ID";
            ddlProjects.DataBind();
            ddlProjects.Items.Insert(0, new ListItem("All Projects", "0"));
        }

        private void LoadTasksWithReports()
        {
            dbConn.dbConnect();
            string query = @"
        SELECT 
            T.TASK_ID, 
            T.TASK_NAME, 
            T.DESCRIPTION AS TASK_DESC, 
            T.START_DATE, 
            T.DUE_DATE, 
            T.STATUS, 
            E.FULL_NAME AS ASSIGNED_TO,
            TR.LAST_UPDATE, 
            TR.TR_ID 
        FROM TASK_REPORT TR
        INNER JOIN TASK T ON TR.TASK_ID = T.TASK_ID
        INNER JOIN PROJECT P ON T.PROJECT_ID = P.PROJECT_ID
        INNER JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID";

            if (ddlProjects.SelectedValue != "0")
            {
                query += " WHERE P.PROJECT_ID = @ProjectID";
            }

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            if (ddlProjects.SelectedValue != "0")
            {
                cmd.Parameters.AddWithValue("@ProjectID", ddlProjects.SelectedValue);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvTaskReports.DataSource = dt;
            gvTaskReports.DataBind();
        }


        protected void ddlProjects_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTasksWithReports();
        }
    }
}