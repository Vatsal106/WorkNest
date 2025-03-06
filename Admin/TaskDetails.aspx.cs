using System;
using System.Data;
using System.Data.SqlClient;

namespace WorkNest.Admin
{
    public partial class TaskDetails : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["TaskID"] == null)
            {
                Response.Redirect("Projects.aspx");
            }
            else
            {
                string taskId = Request.QueryString["TaskID"];
                LoadTaskHistory(taskId);
            }
        }

        private void LoadTaskHistory(string taskId)
        {
            dbConn.dbConnect();
            string query = @"
        SELECT 
            TRH.TRH_ID,
            TRH.UPDATED_AT, 
            TRH.DESCRIPTION, 
            TRH.TASK_FILE
        FROM TASK_REPORT_HISTORY TRH
        WHERE TRH.TASK_ID = @TaskID";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskID", taskId);

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            // Add a new column for the download link
            dt.Columns.Add("TaskHistoryURL", typeof(string));

            foreach (DataRow row in dt.Rows)
            {
                if (row["TASK_FILE"] != DBNull.Value)
                {
                    row["TaskHistoryURL"] = "DownloadTaskHistory.aspx?TaskHistoryID=" + row["TRH_ID"].ToString();
                }
            }

            gvTaskReportHistory.DataSource = dt;
            gvTaskReportHistory.DataBind();
        }
    }
}