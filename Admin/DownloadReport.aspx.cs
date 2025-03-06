using System;
using System.Data.SqlClient;

namespace WorkNest.Admin
{
    public partial class DownloadReport : System.Web.UI.Page
    {

        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["TaskID"] == null)
            {
                Response.Write("Invalid Task ID.");
                return;
            }

            string taskId = Request.QueryString["TaskID"];
            DownloadTaskReport(taskId);
        }

        private void DownloadTaskReport(string taskId)
        {
            dbConn.dbConnect();
            string query = "SELECT TASK_FILE FROM TASK_REPORT WHERE TASK_ID = @TaskID";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskID", taskId);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read() && dr["TASK_FILE"] != DBNull.Value)
            {
                byte[] fileData = (byte[])dr["TASK_FILE"];
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment; filename=TaskReport_" + taskId + ".pdf");
                Response.BinaryWrite(fileData);
                Response.End();
            }
            else
            {
                Response.Write("No report found for this task.");
            }

            dr.Close();
        }
    }
}
