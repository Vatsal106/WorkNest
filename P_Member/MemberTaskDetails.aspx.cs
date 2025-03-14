using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.P_Member
{
    public partial class MemberTaskDetails : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString["TaskID"] == null)
                    {
                        Response.Redirect("Projects.aspx");
                    }
                    else
                    {
                        string taskId = Request.QueryString["TaskID"];
                        LoadTaskDetails(taskId);
                        LoadLatestTaskReport(taskId);
                        LoadTaskHistory(taskId);
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading page: " + ex.Message + "');</script>");
            }
        }

        private void LoadTaskDetails(string taskId)
        {
            dbConn.dbConnect();
            try
            {
                string query = @"
            SELECT 
                T.TASK_NAME, 
                T.STATUS, 
                E.FULL_NAME AS ASSIGN_TO, 
                T.DUE_DATE, 
                T.DESCRIPTION, 
                P.PROJECT_NAME,
                TR.TASK_FILE,
                TR.DESCRIPTION AS REPORT_DESCRIPTION,
                TR.LAST_UPDATE AS LAST_UPDATE
            FROM TASK T
            JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
            JOIN PROJECT P ON T.PROJECT_ID = P.PROJECT_ID
            LEFT JOIN TASK_REPORT TR ON T.TASK_ID = TR.TASK_ID
            WHERE T.TASK_ID = @TaskID
            ORDER BY TR.LAST_UPDATE DESC";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@TaskID", taskId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblTaskName.Text = reader["TASK_NAME"].ToString();
                    lblStatus.Text = reader["STATUS"].ToString();
                    lblAssignedTo.Text = reader["ASSIGN_TO"].ToString();
                    lblDueDate.Text = Convert.ToDateTime(reader["DUE_DATE"]).ToString("yyyy-MM-dd");
                    lblDescription.Text = reader["DESCRIPTION"].ToString();
                    lblProjectName.Text = reader["PROJECT_NAME"].ToString();

                    if (reader["TASK_FILE"] != DBNull.Value)
                    {
                        lnkLatestReport.NavigateUrl = "../DownloadReport.aspx?TaskID=" + taskId;
                        lnkLatestReport.Visible = true;
                    }
                    else
                    {
                        lnkLatestReport.Visible = false;
                    }

                    if (reader["LAST_UPDATE"] != DBNull.Value)
                    {
                        lblReportDate.Text = Convert.ToDateTime(reader["LAST_UPDATE"]).ToString("yyyy-MM-dd HH:mm:ss");
                    }
                    else
                    {
                        lblReportDate.Text = "N/A";
                    }

                    lblReportDescription.Text = reader["REPORT_DESCRIPTION"] != DBNull.Value ? reader["REPORT_DESCRIPTION"].ToString() : "No description available.";
                }
                reader.Close();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading task details: " + ex.Message + "');</script>");
            }
        }

        private void LoadLatestTaskReport(string taskId)
        {
            dbConn.dbConnect();
            try
            {
                string query = @"
        SELECT  TR.DESCRIPTION, TR.TASK_FILE
        FROM TASK_REPORT TR
        WHERE TR.TASK_ID = @TaskID";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@TaskID", taskId);

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adpt.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    if (row["TASK_FILE"] != DBNull.Value)
                    {
                        lnkLatestReport.NavigateUrl = "../DownloadReport.aspx?TaskID=" + taskId;
                        lnkLatestReport.Visible = true;
                    }
                }
                cmd.Dispose();
                adpt.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading latest task report: " + ex.Message + "');</script>");
            }
        }
        protected void btnSubmitReport_Click(object sender, EventArgs e)
        {
            string taskId = Request.QueryString["TaskID"];

            if (!string.IsNullOrEmpty(taskId))
            {
                Response.Redirect("SubmitReportOfTask.aspx?TaskID=" + taskId);
            }
            else
            {
                Response.Write("<script>alert('Invalid Task ID.');</script>");
            }
        }

        private void LoadTaskHistory(string taskId)
        {
            dbConn.dbConnect();
            try
            {
                string query = @"
                    SELECT 
                        TRH.TRH_ID,
                        TRH.UPDATED_AT, 
                        TRH.DESCRIPTION, 
                        TRH.TASK_FILE
                    FROM TASK_REPORT_HISTORY TRH
                    WHERE TRH.TASK_ID = @TaskID
                    ORDER BY TRH.UPDATED_AT DESC";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@TaskID", taskId);

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adpt.Fill(dt);

                dt.Columns.Add("TaskHistoryURL", typeof(string));

                foreach (DataRow row in dt.Rows)
                {
                    if (row["TASK_FILE"] != DBNull.Value)
                    {
                        row["TaskHistoryURL"] = "../DownloadReport.aspx?TaskHistoryID=" + row["TRH_ID"].ToString();
                    }
                }

                gvTaskReportHistory.DataSource = dt;
                gvTaskReportHistory.DataBind();

                cmd.Dispose();
                adpt.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading task history: " + ex.Message + "');</script>");
            }
        }
        protected void btnDeleteHistory_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                string historyId = btn.CommandArgument;

                if (string.IsNullOrEmpty(historyId)) return;

                dbConn.dbConnect();
                string query = "DELETE FROM TASK_REPORT_HISTORY WHERE TRH_ID = @HistoryID";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@HistoryID", historyId);
                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Response.Write("<script>alert('Task report history deleted successfully.');</script>");
                    LoadTaskHistory(Request.QueryString["TaskID"]); // Refresh history after deletion
                }
                else
                {
                    Response.Write("<script>alert('Failed to delete task report history.');</script>");
                }

                cmd.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error deleting task report history: " + ex.Message + "');</script>");
            }
        }

    }
}
