using System;
using System.Data.SqlClient;

namespace WorkNest.Admin
{
    public partial class DownloadTaskHistory : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["TaskHistoryID"] == null)
            {
                Response.Write("Invalid Task History ID.");
                return;
            }

            string taskHistoryId = Request.QueryString["TaskHistoryID"];
            DownloadHistoryReport(taskHistoryId);
        }

        private void DownloadHistoryReport(string taskHistoryId)
        {
            dbConn.dbConnect();
            string query = "SELECT TASK_FILE FROM TASK_REPORT_HISTORY WHERE TRH_ID = @TaskHistoryID";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskHistoryID", taskHistoryId);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read() && dr["TASK_FILE"] != DBNull.Value)
            {
                byte[] fileData = (byte[])dr["TASK_FILE"];
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment; filename=TaskHistory_" + taskHistoryId + ".pdf");
                Response.BinaryWrite(fileData);
                Response.End();
            }
            else
            {
                Response.Write("No report found for this task history.");
            }

            dr.Close();
        }
    }
}