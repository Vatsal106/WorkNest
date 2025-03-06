using System;
using System.Data;
using System.Data.SqlClient;

namespace WorkNest.Admin
{
    public partial class SelectedProject : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["ProjectID"] == null)
                {
                    Response.Redirect("Projects.aspx");
                }
                else
                {
                    string projectId = Request.QueryString["ProjectID"];
                    hfProjectID.Value = projectId;
                    LoadProjectDetails(projectId);
                    LoadProjectTasks(projectId);
                }
            }
        }
        private void LoadProjectDetails(string projectId)
        {
            dbConn.dbConnect();
            string query = @"SELECT P.PROJECT_NAME, P.DESCRIPTION, P.START_DATE, P.END_DATE, 
                                    P.STATUS, E.FULL_NAME AS PROJECT_MANAGER, C.CLIENT_NAME 
                             FROM PROJECT P
                             JOIN EMPLOYEE E ON P.PROJECT_MANAGER_ID = E.EMPLOYEE_ID
                             JOIN CLIENTS C ON P.CLIENT_ID = C.CLIENT_ID
                             WHERE PROJECT_ID = @ProjectID";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ProjectID", projectId);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblProjectName.Text = dr["PROJECT_NAME"].ToString();
                lblDescription.Text = dr["DESCRIPTION"].ToString();
                lblStartDate.Text = Convert.ToDateTime(dr["START_DATE"]).ToString("yyyy-MM-dd");
                lblEndDate.Text = Convert.ToDateTime(dr["END_DATE"]).ToString("yyyy-MM-dd");
                lblStatus.Text = dr["STATUS"].ToString();
                lblProjectManager.Text = dr["PROJECT_MANAGER"].ToString();
                lblClient.Text = dr["CLIENT_NAME"].ToString();
            }
            dr.Close();
        }

        private void LoadProjectTasks(string projectId)
        {
            dbConn.dbConnect();
            string query = @"
        SELECT 
            T.TASK_ID, 
            T.TASK_NAME, 
            T.STATUS, 
            E.FULL_NAME AS ASSIGN_TO, 
            T.DUE_DATE, 
            TR.TASK_FILE
        FROM TASK T
        JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
        LEFT JOIN TASK_REPORT TR ON T.TASK_ID = TR.TASK_ID
        WHERE T.PROJECT_ID = @ProjectID";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ProjectID", projectId);

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            dt.Columns.Add("DownloadLink", typeof(string));

            foreach (DataRow row in dt.Rows)
            {
                if (row["TASK_FILE"] != DBNull.Value)
                {
                    row["DownloadLink"] = "DownloadReport.aspx?TaskID=" + row["TASK_ID"].ToString();
                }
            }

            gvTasks.DataSource = dt;
            gvTasks.DataBind();
        }


    }
}