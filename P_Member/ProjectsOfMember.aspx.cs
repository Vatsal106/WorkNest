using System;
using System.Data;
using System.Data.SqlClient;

namespace WorkNest.P_Member
{
    public partial class ProjectsOfMember : System.Web.UI.Page
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
                int employeeId = Convert.ToInt32(Session["EmployeeID"]);

                string query = @"
                    SELECT DISTINCT P.PROJECT_ID, P.PROJECT_NAME, P.DESCRIPTION, P.START_DATE, P.END_DATE, P.STATUS, C.CLIENT_NAME 
                    FROM PROJECT P
                    JOIN CLIENTS C ON P.CLIENT_ID = C.CLIENT_ID
                    JOIN TASK T ON P.PROJECT_ID = T.PROJECT_ID
                    WHERE T.ASSIGNED_TO = @EmployeeID
                    AND (P.PROJECT_NAME LIKE @Search OR C.CLIENT_NAME LIKE @Search)";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
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

        protected string GetStatuscss(string status)
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
