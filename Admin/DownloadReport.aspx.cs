using System;
using System.Data.SqlClient;

namespace WorkNest.Admin
{
    public partial class DownloadReport : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["TaskID"] != null)
            {
                string taskId = Request.QueryString["TaskID"];
                DownloadTaskReport(taskId);
            }
            else if (Request.QueryString["TaskHistoryID"] != null)
            {
                string taskHistoryId = Request.QueryString["TaskHistoryID"];
                DownloadHistoryReport(taskHistoryId);
            }
            else
            {
                Response.Write("Invalid Request.");
            }
        }

        private void DownloadTaskReport(string taskId)
        {
            dbConn.dbConnect();
            string query = "SELECT FILE_NAME, FILE_EXTENSION, TASK_FILE FROM TASK_REPORT WHERE TASK_ID = @TaskID";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskID", taskId);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                string fileName = dr["FILE_NAME"].ToString();
                string fileExt = dr["FILE_EXTENSION"].ToString();
                byte[] fileData = (byte[])dr["TASK_FILE"];

                dr.Close();
                cmd.Dispose();

                ServeFile(fileName, fileExt, fileData);
            }
            else
            {
                dr.Close();
                cmd.Dispose();
                Response.Write("File not found.");
            }
        }

        private void DownloadHistoryReport(string taskHistoryId)
        {
            dbConn.dbConnect();
            string query = "SELECT FILE_NAME, FILE_EXTENSION, TASK_FILE FROM TASK_REPORT_HISTORY WHERE TRH_ID = @TaskHistoryID";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskHistoryID", taskHistoryId);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read() && dr["TASK_FILE"] != DBNull.Value)
            {
                string fileName = dr["FILE_NAME"].ToString();
                string fileExt = dr["FILE_EXTENSION"].ToString();
                byte[] fileData = (byte[])dr["TASK_FILE"];

                dr.Close();
                cmd.Dispose();

                ServeFile(fileName, fileExt, fileData);
            }
            else
            {
                dr.Close();
                cmd.Dispose();
                Response.Write("No report found for this task history.");
            }
        }

        private void ServeFile(string fileName, string fileExt, byte[] fileData)
        {
            string contentType = GetContentType(fileExt);
            fileName = fileName.Split('.')[0];
            Response.Clear();
            Response.ContentType = contentType;
            Response.AddHeader("Content-Disposition", $"attachment; filename={fileName}{fileExt}");
            Response.BinaryWrite(fileData);
            Response.End();
        }

        private string GetContentType(string extension)
        {
            switch (extension.ToLower())
            {
                case ".pdf": return "application/pdf";
                case ".doc": return "application/msword";
                case ".docx": return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                case ".xls": return "application/vnd.ms-excel";
                case ".xlsx": return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                case ".jpg":
                case ".jpeg": return "image/jpeg";
                case ".png": return "image/png";
                case ".gif": return "image/gif";
                case ".zip": return "application/zip";
                case ".txt": return "text/plain";
                default: return "application/pdf";
            }
        }
    }
}

