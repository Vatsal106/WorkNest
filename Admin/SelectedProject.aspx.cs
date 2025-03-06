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
            string query = @"SELECT T.TASK_NAME, T.STATUS, E.FULL_NAME AS ASSIGN_TO, T.END_DATE 
                             FROM TASK T
                             JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
                             WHERE T.PROJECT_ID = '" + projectId + "'";

            SqlDataAdapter adpt = new SqlDataAdapter(query, dbConn.con);
            DataSet ds = new DataSet();
            adpt.Fill(ds);
            gvTasks.DataSource = ds;
            gvTasks.DataBind();
        }

    }
}