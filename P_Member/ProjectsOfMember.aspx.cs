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
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProjects("");
            }
        }

        private void LoadProjects(string searchKeyword)
        {
            dbConn.dbConnect();

            try
            {
                int employeeId = Convert.ToInt32(Session["EmployeeID"]);
                string query = @"
                    SELECT DISTINCT P.PROJECT_ID, P.PROJECT_NAME, P.DESCRIPTION, P.START_DATE, P.END_DATE, 
                                    P.STATUS, C.CLIENT_NAME, E.FULL_NAME AS PROJECT_MANAGER
                    FROM PROJECT P
                    JOIN CLIENTS C ON P.CLIENT_ID = C.CLIENT_ID
                    JOIN TASK T ON P.PROJECT_ID = T.PROJECT_ID
                    JOIN EMPLOYEE E ON P.PROJECT_MANAGER_ID = E.EMPLOYEE_ID
                    WHERE T.ASSIGN_TO = @EmployeeID
                    AND (P.PROJECT_NAME LIKE @Search OR C.CLIENT_NAME LIKE @Search)";

                using (SqlCommand cmd = new SqlCommand(query, dbConn.con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                    cmd.Parameters.AddWithValue("@Search", "%" + searchKeyword + "%");

                    using (SqlDataAdapter adpt = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adpt.Fill(dt);
                        rptProjects.DataSource = dt;
                        rptProjects.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error loading projects: " + ex.Message;  // Assuming you have a Label control for error messages
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadProjects(txtSearch.Text.Trim());
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

