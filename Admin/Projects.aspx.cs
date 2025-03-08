using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class Projects : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    LoadProjects("");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading page: " + ex.Message + "');</script>");
            }
        }

        public void LoadProjects(string searchKeyword)
        {
            dbConn.dbConnect();
            try
            {
                string query = @"
                    SELECT 
                        p.PROJECT_ID, 
                        p.PROJECT_NAME, 
                        p.DESCRIPTION, 
                        p.START_DATE, 
                        p.END_DATE, 
                        p.STATUS, 
                        e.FULL_NAME AS PROJECT_MANAGER,
                        c.CLIENT_NAME
                    FROM PROJECT p
                    LEFT JOIN EMPLOYEE e ON p.PROJECT_MANAGER_ID = e.EMPLOYEE_ID
                    JOIN CLIENTS c ON p.CLIENT_ID = c.CLIENT_ID
                    WHERE 
                        p.PROJECT_MANAGER_ID IS NULL or
                        (p.PROJECT_NAME LIKE @Search OR 
                        e.FULL_NAME LIKE @Search OR 
                        c.CLIENT_NAME LIKE @Search)";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
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

        public void rptProjects_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteProject")
                {
                    int projectId = Convert.ToInt32(e.CommandArgument);
                    DeleteProject(projectId);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error processing project command: " + ex.Message + "');</script>");
            }
        }

        public void DeleteProject(int projectId)
        {
            dbConn.dbConnect();
            try
            {
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
    }
}
