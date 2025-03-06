using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WorkNest.Project_Manager
{
    public partial class Projects : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAssignedProjects();
            }
        }

        private void LoadAssignedProjects()
        {
            dbConn.dbConnect(); 

            
            if (Session["EmployeeID"] == null)
            {
                Response.Write("<script>alert('Session Expired. Please log in again.');</script>");
                return;
            }

            int managerId = Convert.ToInt32(Session["EmployeeID"]);

            
            string query = @"
                SELECT P.PROJECT_NAME, P.DESCRIPTION, P.START_DATE, P.END_DATE, P.STATUS, C.CLIENT_NAME 
                FROM PROJECT P
                JOIN CLIENTS C ON P.CLIENT_ID = C.CLIENT_ID
                WHERE P.PROJECT_MANAGER_ID = @ManagerID";

            using (SqlCommand cmd = new SqlCommand(query, dbConn.con))
            {
                cmd.Parameters.AddWithValue("@ManagerID", managerId);

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adpt.Fill(dt);

                rptProjects.DataSource = dt;
                rptProjects.DataBind();
            }

            
        }
    }
}
