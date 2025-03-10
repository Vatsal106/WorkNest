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
                LoadProjectSummary();
                LoadTaskStats();
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
                System.Diagnostics.Debug.WriteLine("Error fetching projects: " + ex.Message);
            }
        }

        private void LoadProjectSummary()
        {
            try
            {
                db.dbConnect();
                string query = @"SELECT STATUS, COUNT(*) AS ProjectCount FROM PROJECT GROUP BY STATUS";
                SqlCommand cmd = new SqlCommand(query, db.con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                int Total = 0;
                foreach (DataRow row in dt.Rows)
                {
                    string status = row["STATUS"].ToString();
                    int count = Convert.ToInt32(row["ProjectCount"]);
                    Total += count;
                    switch (status.ToUpper())
                    {
                        case "IN PROGRESS":
                            lblInProgressProjects.Text = count.ToString();
                            break;
                        case "COMPLETED":
                            lblCompletedProjects.Text = count.ToString();
                            break;
                        case "ON HOLD":
                            lblOnHoldProjects.Text = count.ToString();
                            break;
                        case "IN TESTING":
                            lblTestingProjects.Text = count.ToString();
                            break;
                    }
                }
                lblTotalProjects.Text = Total.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error fetching project summary: " + ex.Message);
            }
        }

        private void LoadTaskStats()
        {
            try
            {
                db.dbConnect();
                string query = @"SELECT STATUS, COUNT(*) AS TaskCount FROM TASK GROUP BY STATUS";
                SqlCommand cmd = new SqlCommand(query, db.con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                int TotalTask = 0;
                foreach (DataRow row in dt.Rows)
                {
                    string status = row["STATUS"].ToString();
                    int count = Convert.ToInt32(row["TaskCount"]);
                    TotalTask += count;
                    switch (status.ToUpper())
                    {
                        case "COMPLETED":
                            lblCompletedTasks.Text = count.ToString();
                            break;
                        case "IN PROGRESS":
                            lblInProgressTasks.Text = count.ToString();
                            break;
                        case "NOT STARTED":
                            lblNotStartedTasks.Text = count.ToString();
                            break;
                        case "ON HOLD":
                            lblOnHoldTasks.Text = count.ToString();
                            break;
                    }
                }
                lblTotalTasks.Text = TotalTask.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error fetching task stats: " + ex.Message);
            }
        }
    }
}
