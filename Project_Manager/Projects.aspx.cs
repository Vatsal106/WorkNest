using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Project_Manager
{
    public partial class Projects : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjects("");
            }
        }

        public void LoadProjects(string searchKeyword)
        {
            dbConn.dbConnect();

            if (Session["EmployeeID"] == null)
            {
                Response.Write("<script>alert('Session Expired. Please log in again.');</script>");
                return;
            }

            try
            {
                int managerId = Convert.ToInt32(Session["EmployeeID"]);

                string query = @"
                    SELECT P.PROJECT_ID, P.PROJECT_NAME, P.DESCRIPTION, P.START_DATE, P.END_DATE, P.STATUS, C.CLIENT_NAME 
                    FROM PROJECT P
                    JOIN CLIENTS C ON P.CLIENT_ID = C.CLIENT_ID
                    WHERE P.PROJECT_MANAGER_ID = @ManagerID
                    AND (P.PROJECT_NAME LIKE @Search OR C.CLIENT_NAME LIKE @Search)";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@ManagerID", managerId);
                cmd.Parameters.AddWithValue("@Search", "%" + searchKeyword + "%");

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adpt.Fill(dt);

                rptProjects.DataSource = dt;
                rptProjects.DataBind();

                cmd.Dispose();
                adpt.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading projects: " + ex.Message + "');</script>");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string searchText = txtSearch.Text.Trim();
                LoadProjects(searchText);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error searching projects: " + ex.Message + "');</script>");
            }
        }
        protected void rptProjects_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProject")
            {
                int projectId = Convert.ToInt32(e.CommandArgument);
                DeleteProject(projectId);
            }
        }
        private void DeleteProject(int projectId)
        {
            dbConn.dbConnect();
            try
            {
                string deleteTaskReportHistoryQuery = "DELETE FROM TASK_REPORT_HISTORY WHERE TASK_ID IN (SELECT TASK_ID FROM TASK WHERE PROJECT_ID = @ProjectId)";
                SqlCommand cmdDeleteTaskReportHistory = new SqlCommand(deleteTaskReportHistoryQuery, dbConn.con);
                cmdDeleteTaskReportHistory.Parameters.AddWithValue("@ProjectId", projectId);
                cmdDeleteTaskReportHistory.ExecuteNonQuery();
                cmdDeleteTaskReportHistory.Dispose();

               
                string deleteTaskReportQuery = "DELETE FROM TASK_REPORT WHERE TASK_ID IN (SELECT TASK_ID FROM TASK WHERE PROJECT_ID = @ProjectId)";
                SqlCommand cmdDeleteTaskReport = new SqlCommand(deleteTaskReportQuery, dbConn.con);
                cmdDeleteTaskReport.Parameters.AddWithValue("@ProjectId", projectId);
                cmdDeleteTaskReport.ExecuteNonQuery();
                cmdDeleteTaskReport.Dispose();

                string deleteTasksQuery = "DELETE FROM TASK WHERE PROJECT_ID = @ProjectId";
                SqlCommand cmdDeleteTasks = new SqlCommand(deleteTasksQuery, dbConn.con);
                cmdDeleteTasks.Parameters.AddWithValue("@ProjectId", projectId);
                cmdDeleteTasks.ExecuteNonQuery();
                cmdDeleteTasks.Dispose();

               
                string deleteProjectQuery = "DELETE FROM PROJECT WHERE PROJECT_ID = @ProjectId";
                SqlCommand cmdDeleteProject = new SqlCommand(deleteProjectQuery, dbConn.con);
                cmdDeleteProject.Parameters.AddWithValue("@ProjectId", projectId);

                int rowsAffected = cmdDeleteProject.ExecuteNonQuery();
                cmdDeleteProject.Dispose();

                if (rowsAffected > 0)
                {
                    Response.Write("<script>alert('Project deleted successfully');</script>");
                    LoadProjects(""); 
                }
                else
                {
                    Response.Write("<script>alert('Failed to delete project');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error deleting project: " + ex.Message + "');</script>");
            }
        }
        protected string GetStatusClass(string status)
        {
            switch (status)
            {
                case "IN PROGRESS":
                    return "status-in-progress";
                case "COMPLETED":
                    return "status-completed";
                case "ON HOLD":
                    return "status-on-hold";
                case "IN TESTING":
                    return "status-in-testing";
                default:
                    return "";
            }
        }
    }
}
