using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class Projects : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection(); // Database connection instance

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjects(""); // Load all projects initially
            }
        }

        // Load projects with optional search filter
        public void LoadProjects(string searchKeyword)
        {
            dbConn.dbConnect(); // Open database connection

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
                JOIN EMPLOYEE e ON p.PROJECT_MANAGER_ID = e.EMPLOYEE_ID
                JOIN CLIENTS c ON p.CLIENT_ID = c.CLIENT_ID
                WHERE 
                    p.PROJECT_NAME LIKE @Search OR 
                    e.FULL_NAME LIKE @Search OR 
                    c.CLIENT_NAME LIKE @Search";

            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@Search", "%" + searchKeyword + "%");

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            rptProjects.DataSource = dt;
            rptProjects.DataBind();
        }

        // Search button click event
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim();
            LoadProjects(searchText);
        }

        // Handle delete action from the repeater
        public void rptProjects_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProject")
            {
                int projectId = Convert.ToInt32(e.CommandArgument);
                DeleteProject(projectId);
            }
        }

        // Delete a project by ID
        private void DeleteProject(int projectId)
        {
            dbConn.dbConnect(); // Open database connection

            string query = "DELETE FROM PROJECT WHERE PROJECT_ID = @ProjectID";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@ProjectID", projectId);

            try
            {
                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Response.Write("<script>alert('Project deleted successfully');</script>");
                    LoadProjects(""); // Refresh list after deletion
                }
                else
                {
                    Response.Write("<script>alert('Failed to delete project');</script>");
                }
            }
            catch (SqlException ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}
