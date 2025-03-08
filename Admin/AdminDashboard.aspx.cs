using System;
using System.Data;
using System.Data.SqlClient;

namespace WorkNest.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        dbConnection db = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjects();
            }
        }

        private void LoadProjects()
        {
            FetchProjectsByStatus("IN PROGRESS", rptInProgress);
            FetchProjectsByStatus("COMPLETED", rptCompleted);
            FetchProjectsByStatus("ON HOLD", rptHold);
            FetchProjectsByStatus("IN TESTING", rptTesting);
        }

        private void FetchProjectsByStatus(string status, System.Web.UI.WebControls.Repeater repeater)
        {
            try
            {
                db.dbConnect();

                SqlCommand cmd = new SqlCommand("SELECT PROJECT_ID, PROJECT_NAME, DESCRIPTION, START_DATE, END_DATE FROM PROJECT WHERE STATUS = @Status", db.con);
                cmd.Parameters.AddWithValue("@Status", status);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                repeater.DataSource = dt;
                repeater.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error fetching projects: " + ex.Message);
            }
        }
    }
}
