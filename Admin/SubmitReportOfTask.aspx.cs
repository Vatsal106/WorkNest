using System;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;

namespace WorkNest.P_Member
{
    public partial class SubmitReportOfTask : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfTaskID.Value = "17";
                loadTask(hfTaskID.Value);
                loadLastUpdate(hfTaskID.Value);

                //if (Request.QueryString["TaskID"] != null)
                //{
                //    hfTaskID.Value = Request.QueryString["TaskID"];
                //    loadTask(hfTaskID.Value);
                // loadLastUpdate(hfTaskID.Value);

                //}
                //else
                //{
                //    Response.Redirect("Tasks.aspx");
                //}
            }
        }
        public void loadTask(string taskID)
        {
            dbConn.dbConnect();
            string query = "SELECT TASK_NAME, DESCRIPTION, STATUS, PROJECT_ID FROM TASK WHERE TASK_ID = @TaskID";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskID", taskID);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txtTaskName.Text = dr["TASK_NAME"].ToString();
                txttaskDescription.Text = dr["DESCRIPTION"].ToString();
                ddlStatus.SelectedValue = dr["STATUS"].ToString();
            }
            dr.Close();
        }
        public void loadLastUpdate(string taskID)
        {
            dbConn.dbConnect();
            string query = "SELECT LAST_UPDATE FROM TASK_REPORT WHERE TASK_ID = @TaskID";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskID", taskID);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read() && dr["LAST_UPDATE"] != DBNull.Value)
            {
                lblLastUpdate.Text = Convert.ToDateTime(dr["LAST_UPDATE"]).ToString("yyyy-MM-dd HH:mm:ss");
            }
            else
            {
                lblLastUpdate.Text = "Never Updated";
            }
            dr.Close();
        }
        public void btnSubmit_Click(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            SqlTransaction transaction = dbConn.con.BeginTransaction(); 
            try
            {
                byte[] fileBytes = null;
                string fileExtension = "", fileName = "";

                if (fuReport.HasFile)
                {
                    int maxFileSize = 10 * 1024 * 1024; 
                    if (fuReport.FileContent.Length > maxFileSize)
                    {
                        lblMessage.Text = "File size must be less than 10MB.";
                        lblMessage.ForeColor = Color.Red;
                        return;
                    }

                    fileName = Path.GetFileName(fuReport.FileName);
                    fileExtension = Path.GetExtension(fuReport.FileName).ToLower();
                    fileBytes = fuReport.FileBytes;
                }

                int taskID = Convert.ToInt32(hfTaskID.Value);
                bool reportExists = false;
                int existingTRID = 0;
                byte[] existingFile = null;
                string existingDescription = "", existingFileName = "", existingFileExtension = "";
                DateTime lastUpdate = DateTime.Now;

               
                string checkExistingQuery = "SELECT TR_ID, TASK_FILE, FILE_NAME, FILE_EXTENSION, DESCRIPTION, LAST_UPDATE FROM TASK_REPORT WHERE TASK_ID = @TaskID";
                SqlCommand checkCmd = new SqlCommand(checkExistingQuery, dbConn.con, transaction);
                checkCmd.Parameters.AddWithValue("@TaskID", taskID);
                SqlDataReader reader = checkCmd.ExecuteReader();

                if (reader.Read())
                {
                    reportExists = true;
                    existingTRID = Convert.ToInt32(reader["TR_ID"]);
                    existingFile = reader["TASK_FILE"] as byte[];
                    existingFileName = reader["FILE_NAME"].ToString();
                    existingFileExtension = reader["FILE_EXTENSION"].ToString();
                    existingDescription = reader["DESCRIPTION"].ToString();
                    lastUpdate = Convert.ToDateTime(reader["LAST_UPDATE"]);
                }

                if (reader != null && !reader.IsClosed)
                    reader.Close();

                if (reportExists)
                {
                    
                    string insertHistoryQuery = "INSERT INTO TASK_REPORT_HISTORY (TASK_ID, TASK_FILE, FILE_NAME, FILE_EXTENSION, DESCRIPTION, UPDATED_AT) VALUES (@TaskID, @TASK_FILE, @FILE_NAME, @FILE_EXTENSION, @DESCRIPTION, @UPDATED_AT)";
                    SqlCommand historyCmd = new SqlCommand(insertHistoryQuery, dbConn.con, transaction);
                    historyCmd.Parameters.AddWithValue("@TaskID", taskID);
                    historyCmd.Parameters.AddWithValue("@TASK_FILE", existingFile);
                    historyCmd.Parameters.AddWithValue("@FILE_NAME", existingFileName);
                    historyCmd.Parameters.AddWithValue("@FILE_EXTENSION", existingFileExtension);
                    historyCmd.Parameters.AddWithValue("@DESCRIPTION", existingDescription);
                    historyCmd.Parameters.AddWithValue("@UPDATED_AT", lastUpdate);
                    historyCmd.ExecuteNonQuery();

                    
                    string updateReportQuery = "UPDATE TASK_REPORT SET TASK_FILE = @TASK_FILE, FILE_NAME = @FILE_NAME, FILE_EXTENSION = @FILE_EXTENSION, DESCRIPTION = @DESCRIPTION, LAST_UPDATE = @LAST_UPDATE WHERE TASK_ID = @T_ID";
                    SqlCommand updateReportCmd = new SqlCommand(updateReportQuery, dbConn.con, transaction);
                    updateReportCmd.Parameters.AddWithValue("@TASK_FILE", fileBytes);
                    updateReportCmd.Parameters.AddWithValue("@FILE_NAME", fileName.Trim());
                    updateReportCmd.Parameters.AddWithValue("@FILE_EXTENSION", fileExtension.Trim());
                    updateReportCmd.Parameters.AddWithValue("@DESCRIPTION", txtDescription.Text);
                    updateReportCmd.Parameters.AddWithValue("@LAST_UPDATE", DateTime.Now);
                    updateReportCmd.Parameters.AddWithValue("@T_ID", taskID);
                    updateReportCmd.ExecuteNonQuery();
                }
                else
                {
                    
                    string insertReportQuery = "INSERT INTO TASK_REPORT (TASK_ID, TASK_FILE, FILE_NAME, FILE_EXTENSION, DESCRIPTION, LAST_UPDATE) VALUES (@TaskID, @TASK_FILE, @FILE_NAME, @FILE_EXTENSION, @DESCRIPTION, @LAST_UPDATE)";
                    SqlCommand reportCmd = new SqlCommand(insertReportQuery, dbConn.con, transaction);
                    reportCmd.Parameters.AddWithValue("@TaskID", taskID);
                    reportCmd.Parameters.AddWithValue("@TASK_FILE", fileBytes);
                    reportCmd.Parameters.AddWithValue("@FILE_NAME", fileName.Trim());
                    reportCmd.Parameters.AddWithValue("@FILE_EXTENSION", fileExtension.Trim());
                    reportCmd.Parameters.AddWithValue("@DESCRIPTION", txtDescription.Text);
                    reportCmd.Parameters.AddWithValue("@LAST_UPDATE", DateTime.Now);
                    reportCmd.ExecuteNonQuery();
                }

               
                string updateTaskQuery = "UPDATE TASK SET STATUS = @Status WHERE TASK_ID = @TaskID";
                SqlCommand updateCmd = new SqlCommand(updateTaskQuery, dbConn.con, transaction);
                updateCmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                updateCmd.Parameters.AddWithValue("@TaskID", taskID);
                updateCmd.ExecuteNonQuery();

                
                transaction.Commit();
                btnClear_Click(sender, e);
                loadLastUpdate(hfTaskID.Value);
                lblMessage.Text = "Report submitted successfully!";
                lblMessage.ForeColor = Color.Green;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                lblMessage.Text = "Error submitting report: " + ex.Message;
                lblMessage.ForeColor = Color.Red;
            }
        }

        public void btnClear_Click(object sender, EventArgs e)
        {
            txtDescription.Text = "";
            fuReport.Attributes.Clear();
            ddlStatus.SelectedIndex = 0;
            lblMessage.Text = "";
            lblLastUpdate.Text = "Never Updated";
        }

    }
}
