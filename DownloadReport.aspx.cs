﻿using System;
using System.Data.SqlClient;

namespace WorkNest.Admin
{
    public partial class DownloadReport : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int loggedInEmployeeId = Convert.ToInt32(Session["EmployeeID"]);
                if (Request.QueryString["TaskID"] != null)
                {
                    string taskId = Request.QueryString["TaskID"];
                    //if (Session["UserRole"].ToString() == "Project_Member")
                    //{
                    //    if (IsUserAssignedToTask(loggedInEmployeeId, taskId))
                    DownloadTaskReport(taskId);
                    //else
                    //    Response.Redirect("AccessDenied.aspx");
                    //}
                    //else
                    //{
                    //    DownloadTaskReport(taskId);
                    //}
                }
                else if (Request.QueryString["TaskHistoryID"] != null)
                {
                    string taskHistoryId = Request.QueryString["TaskHistoryID"];
                    DownloadHistoryReport(taskHistoryId);
                }
                else if (Request.QueryString["LeaveID"] != null)
                {
                    string leaveid = Request.QueryString["LeaveID"];
                    DownloadLeaveReport(leaveid);
                }
                else
                {
                    Response.Write("Invalid Request.");
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error processing request: " + ex.Message);
            }
        }
        //private bool IsUserAssignedToTask(int employeeId, string taskId)
        //{
        //    dbConn.dbConnect();
        //    string query = "SELECT COUNT(*) FROM TASK WHERE TASK_ID = @TaskID AND ASSIGN_TO = @EmployeeID";
        //    SqlCommand cmd = new SqlCommand(query, dbConn.con);
        //    cmd.Parameters.AddWithValue("@TaskID", taskId);
        //    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
        //    int count = Convert.ToInt32(cmd.ExecuteScalar());
        //    return count > 0;
        //}

        private void DownloadTaskReport(string taskId)
        {
            dbConn.dbConnect();
            try
            {
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
            catch (Exception ex)
            {
                Response.Write("Error downloading task report: " + ex.Message);
            }
        }

        private void DownloadHistoryReport(string taskHistoryId)
        {
            dbConn.dbConnect();
            try
            {
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
            catch (Exception ex)
            {
                Response.Write("Error downloading task history report: " + ex.Message);
            }
        }

        public void DownloadLeaveReport(string leaveid)
        {
            dbConn.dbConnect();
            try
            {
                string query = "SELECT FILE_NAME, FILE_EXTANSION, ATTACHMENT FROM LEAVES WHERE LEAVE_ID = @LeaveID";
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@LeaveID", leaveid);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string fileName = dr["FILE_NAME"].ToString();
                    string fileExt = dr["FILE_EXTANSION"].ToString();
                    byte[] fileData = (byte[])dr["ATTACHMENT"];
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
            catch (Exception ex)
            {
                Response.Write("Error downloading leave report: " + ex.Message);
            }
        }
        private void ServeFile(string fileName, string fileExt, byte[] fileData)
        {
            try
            {
                string contentType = GetContentType(fileExt);
                fileName = fileName.Split('.')[0];
                Response.Clear();
                Response.ContentType = contentType;
                Response.AddHeader("Content-Disposition", $"attachment; filename={fileName}{fileExt}");
                Response.BinaryWrite(fileData);
                Response.End();
            }
            catch (Exception ex)
            {
                Response.Write("Error serving file: " + ex.Message);
            }
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
