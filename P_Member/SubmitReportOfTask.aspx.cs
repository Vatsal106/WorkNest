using System;
using System.Data;
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
                LoadTasks();
                if (Request.QueryString["TaskID"] != null)
                {
                    hfTaskID.Value = Request.QueryString["TaskID"];
                    ddlTasks.SelectedValue = hfTaskID.Value;

                    loadTaskDetails(hfTaskID.Value);
                    loadLastUpdate(hfTaskID.Value);
                }
            }
        }

        private void LoadTasks()
        {
            string employeeID = Session["EmployeeID"]?.ToString();
            if (string.IsNullOrEmpty(employeeID)) return;

            dbConn.dbConnect();

            string query = "SELECT TASK_ID, TASK_NAME FROM TASK WHERE ASSIGN_TO = @EmployeeID";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", employeeID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            dbConn.con.Close();

            ddlTasks.DataSource = dt;
            ddlTasks.DataTextField = "TASK_NAME";
            ddlTasks.DataValueField = "TASK_ID";
            ddlTasks.DataBind();

            ddlTasks.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select a Task", ""));
        }

        public void loadTaskDetails(string taskID)
        {
            dbConn.dbConnect();
            string query = "SELECT TASK_NAME, DESCRIPTION, STATUS FROM TASK WHERE TASK_ID = @TaskID";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@TaskID", taskID);

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtTaskName.Text = dr["TASK_NAME"].ToString();
                txttaskDescription.Text = dr["DESCRIPTION"].ToString();
                ddlStatus.SelectedValue = dr["STATUS"].ToString();
            }
            dr.Close();
            dbConn.con.Close();
        }

        protected void ddlTasks_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlTasks.SelectedValue))
            {
                hfTaskID.Value = ddlTasks.SelectedValue;
                loadTaskDetails(ddlTasks.SelectedValue);
                loadLastUpdate(ddlTasks.SelectedValue);
            }
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
            dbConn.con.Close();
        }

        public void btnSubmit_Click(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            SqlTransaction transaction = dbConn.con.BeginTransaction(); // Start transaction
            try
            {
                byte[] fileBytes = null;
                bool fileUploaded = false;
                string fileExtension = "", fileName = "";
                if (fuReport.HasFile)
                {
                    fileUploaded = true;
                    int maxFileSize = 10 * 1024 * 1024; // 10MB file size limit
                    fileName = Path.GetFileName(fuReport.FileName).Trim();
                    fileExtension = Path.GetExtension(fuReport.FileName).ToLower();
                    if (fuReport.FileContent.Length > maxFileSize)
                    {
                        lblMessage.Text = "File size must be less than 10MB.";
                        lblMessage.ForeColor = Color.Red;
                        return;
                    }

                    fileBytes = fuReport.FileBytes;
                }

                int taskID = Convert.ToInt32(hfTaskID.Value);

                // Check if a report already exists for the task
                string checkExistingQuery = "SELECT TR_ID, TASK_FILE, FILE_NAME, FILE_EXTENSION, DESCRIPTION, LAST_UPDATE FROM TASK_REPORT WHERE TASK_ID = @TaskID";
                SqlCommand checkCmd = new SqlCommand(checkExistingQuery, dbConn.con, transaction);
                checkCmd.Parameters.AddWithValue("@TaskID", taskID);
                SqlDataReader reader = checkCmd.ExecuteReader();

                bool reportExists = reader.Read();
                int existingTRID = 0;
                byte[] existingFile = null;
                string existingFileName = "", existingFileExtension = "", existingDescription = "";
                DateTime lastUpdate = DateTime.Now;

                if (reportExists)
                {
                    existingTRID = Convert.ToInt32(reader["TR_ID"]);
                    existingFile = reader["TASK_FILE"] as byte[];
                    existingFileName = reader["FILE_NAME"].ToString();
                    existingFileExtension = reader["FILE_EXTENSION"].ToString();
                    existingDescription = reader["DESCRIPTION"].ToString();
                    lastUpdate = Convert.ToDateTime(reader["LAST_UPDATE"]);
                }
                reader.Close();

                if (reportExists)
                {
                    // Move existing report to TASK_REPORT_HISTORY
                    string insertHistoryQuery = "INSERT INTO TASK_REPORT_HISTORY (TASK_ID, TASK_FILE, FILE_NAME, FILE_EXTENSION, DESCRIPTION, UPDATED_AT) " +
                                                "VALUES (@TaskID, @TASK_FILE, @FILE_NAME, @FILE_EXTENSION, @DESCRIPTION, @UPDATED_AT)";
                    SqlCommand historyCmd = new SqlCommand(insertHistoryQuery, dbConn.con, transaction);
                    historyCmd.Parameters.AddWithValue("@TaskID", taskID);
                    historyCmd.Parameters.AddWithValue("@TASK_FILE", existingFile ?? (object)DBNull.Value);
                    historyCmd.Parameters.AddWithValue("@FILE_NAME", existingFileName ?? (object)DBNull.Value);
                    historyCmd.Parameters.AddWithValue("@FILE_EXTENSION", existingFileExtension ?? (object)DBNull.Value);
                    historyCmd.Parameters.AddWithValue("@DESCRIPTION", existingDescription ?? (object)DBNull.Value);
                    historyCmd.Parameters.AddWithValue("@UPDATED_AT", lastUpdate);
                    historyCmd.ExecuteNonQuery();

                    // Update existing report in TASK_REPORT
                    string updateReportQuery = "UPDATE TASK_REPORT SET TASK_FILE = @TASK_FILE, FILE_NAME = @FILE_NAME, FILE_EXTENSION = @FILE_EXTENSION, " +
                                               "DESCRIPTION = @DESCRIPTION, LAST_UPDATE = @LAST_UPDATE WHERE TR_ID = @TR_ID";
                    SqlCommand updateReportCmd = new SqlCommand(updateReportQuery, dbConn.con, transaction);
                    updateReportCmd.Parameters.AddWithValue("@TASK_FILE", fileBytes ?? (object)DBNull.Value);
                    updateReportCmd.Parameters.AddWithValue("@FILE_NAME", fileName.Trim());
                    updateReportCmd.Parameters.AddWithValue("@FILE_EXTENSION", fileExtension.Trim());
                    updateReportCmd.Parameters.AddWithValue("@DESCRIPTION", txtDescription.Text.Trim());
                    updateReportCmd.Parameters.AddWithValue("@LAST_UPDATE", DateTime.Now);
                    updateReportCmd.Parameters.AddWithValue("@TR_ID", existingTRID);
                    updateReportCmd.ExecuteNonQuery();
                }
                else
                {
                    // Insert new report into TASK_REPORT
                    string insertReportQuery = "INSERT INTO TASK_REPORT (TASK_ID, TASK_FILE, FILE_NAME, FILE_EXTENSION, DESCRIPTION, LAST_UPDATE) " +
                                               "VALUES (@TaskID, @TASK_FILE, @FILE_NAME, @FILE_EXTENSION, @DESCRIPTION, @LAST_UPDATE)";
                    SqlCommand reportCmd = new SqlCommand(insertReportQuery, dbConn.con, transaction);
                    reportCmd.Parameters.AddWithValue("@TaskID", taskID);
                    reportCmd.Parameters.AddWithValue("@TASK_FILE", fileBytes ?? (object)DBNull.Value);
                    reportCmd.Parameters.AddWithValue("@FILE_NAME", fileName.Trim());
                    reportCmd.Parameters.AddWithValue("@FILE_EXTENSION", fileExtension.Trim());
                    reportCmd.Parameters.AddWithValue("@DESCRIPTION", txtDescription.Text.Trim());
                    reportCmd.Parameters.AddWithValue("@LAST_UPDATE", DateTime.Now);
                    reportCmd.ExecuteNonQuery();
                }

                // Update Task Status
                string updateTaskQuery = "UPDATE TASK SET STATUS = @Status WHERE TASK_ID = @TaskID";
                SqlCommand updateCmd = new SqlCommand(updateTaskQuery, dbConn.con, transaction);
                updateCmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                updateCmd.Parameters.AddWithValue("@TaskID", taskID);
                updateCmd.ExecuteNonQuery();


                // Commit transaction if everything is successful
                transaction.Commit();
                btnClear_Click(sender, e);
                loadLastUpdate(hfTaskID.Value);
                lblMessage.Text = "Report submitted successfully!";
                lblMessage.ForeColor = Color.Green;
            }
            catch (Exception ex)
            {
                // Rollback transaction in case of failure
                transaction.Rollback();
                lblMessage.Text = "Error submitting report: " + ex.Message;
                lblMessage.ForeColor = Color.Red;
            }
        }
        public void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            ddlTasks.SelectedIndex = 0;
            txttaskDescription.Text = "";
            txtDescription.Text = "";
            fuReport.Attributes.Clear();
            lblLastUpdate.Text = "Never Updated!";
            lblMessage.Text = "";
            txtTaskName.Text = "";
        }
    }
}
