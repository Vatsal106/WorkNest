using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class AllTasks : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjectTasks("");
            }
        }

        private void LoadProjectTasks(string searchKeyword)
        {
            dbConn.dbConnect();

            // Get all projects with tasks
            string projectQuery = @"
                SELECT DISTINCT P.PROJECT_ID, P.PROJECT_NAME 
                FROM PROJECT P
                INNER JOIN TASK T ON P.PROJECT_ID = T.PROJECT_ID
                WHERE P.PROJECT_NAME LIKE @Search OR T.TASK_NAME LIKE @Search";

            SqlDataAdapter da = new SqlDataAdapter(projectQuery, dbConn.con);
            da.SelectCommand.Parameters.AddWithValue("@Search", "%" + searchKeyword + "%");
            DataTable dtProjects = new DataTable();
            da.Fill(dtProjects);

            rptProjects.DataSource = dtProjects;
            rptProjects.DataBind();

            // Get projects without tasks
            string noTaskProjectQuery = @"
                SELECT PROJECT_NAME FROM PROJECT 
                WHERE PROJECT_ID NOT IN (SELECT DISTINCT PROJECT_ID FROM TASK)";

            SqlDataAdapter daNoTasks = new SqlDataAdapter(noTaskProjectQuery, dbConn.con);
            DataTable dtNoTasks = new DataTable();
            daNoTasks.Fill(dtNoTasks);

            if (dtNoTasks.Rows.Count > 0)
            {
                lblNoProjectTasks.Text = string.Join(", ", dtNoTasks.AsEnumerable().Select(row => row["PROJECT_NAME"].ToString()));
            }
            else
            {
                lblNoProjectTasks.Text = "All projects have tasks.";
            }
        }

        protected void rptProjects_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string projectId = DataBinder.Eval(e.Item.DataItem, "PROJECT_ID").ToString();
                GridView gv = (GridView)e.Item.FindControl("gvTaskReports");
                Label lblNoTasks = (Label)e.Item.FindControl("lblNoTasks");

                string taskQuery = @"
                    SELECT T.TASK_ID, T.TASK_NAME, T.DESCRIPTION AS TASK_DESC, 
                           T.START_DATE, T.DUE_DATE, T.STATUS, 
                           E.FULL_NAME AS ASSIGNED_TO, 
                           ISNULL(TR.LAST_UPDATE, T.START_DATE) AS LAST_UPDATE
                    FROM TASK T
                    LEFT JOIN TASK_REPORT TR ON T.TASK_ID = TR.TASK_ID
                    INNER JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
                    WHERE T.PROJECT_ID = @ProjectID";

                SqlDataAdapter da = new SqlDataAdapter(taskQuery, dbConn.con);
                da.SelectCommand.Parameters.AddWithValue("@ProjectID", projectId);
                DataTable dtTasks = new DataTable();
                da.Fill(dtTasks);

                gv.DataSource = dtTasks;
                gv.DataBind();
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadProjectTasks(txtSearch.Text.Trim());
        }
    }
}
