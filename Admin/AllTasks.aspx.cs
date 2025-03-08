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
                LoadProjectTasks();
            }
        }

        private void LoadProjectTasks()
        {
            dbConn.dbConnect();
            string query = @"
            SELECT 
                P.PROJECT_ID, 
                P.PROJECT_NAME, 
                T.TASK_ID, 
                T.TASK_NAME, 
                T.DESCRIPTION AS TASK_DESC, 
                T.START_DATE, 
                T.DUE_DATE, 
                T.STATUS, 
                E.FULL_NAME AS ASSIGNED_TO, 
                TR.LAST_UPDATE
            FROM PROJECT P
            INNER JOIN TASK T ON P.PROJECT_ID = T.PROJECT_ID
            LEFT JOIN TASK_REPORT TR ON T.TASK_ID = TR.TASK_ID
            INNER JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
            ORDER BY P.PROJECT_NAME, T.START_DATE";

            SqlDataAdapter da = new SqlDataAdapter(query, dbConn.con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            DataView view = new DataView(dt);
            DataTable distinctProjects = view.ToTable(true, "PROJECT_ID", "PROJECT_NAME");

            rptProjects.DataSource = distinctProjects;
            rptProjects.DataBind();
        }

        protected void rptProjects_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            dbConn.dbConnect();
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string projectId = DataBinder.Eval(e.Item.DataItem, "PROJECT_ID").ToString();
                GridView gv = (GridView)e.Item.FindControl("gvTaskReports");

                string query = @"
                SELECT 
                    T.TASK_ID, 
                    T.TASK_NAME, 
                    T.DESCRIPTION AS TASK_DESC, 
                    T.START_DATE, 
                    T.DUE_DATE, 
                    T.STATUS, 
                    E.FULL_NAME AS ASSIGNED_TO, 
                    TR.LAST_UPDATE
                FROM TASK T
                LEFT JOIN TASK_REPORT TR ON T.TASK_ID = TR.TASK_ID
                INNER JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
                WHERE T.PROJECT_ID = @ProjectID
                ORDER BY T.START_DATE";

                SqlDataAdapter da = new SqlDataAdapter(query, dbConn.con);
                da.SelectCommand.Parameters.AddWithValue("@ProjectID", projectId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gv.DataSource = dt;
                gv.DataBind();
            }
        }
    }
}