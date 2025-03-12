using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WorkNest.Project_Manager
{
    public partial class P_ManagerHome : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardStats();
                LoadRecentProjects();
                LoadUpcomingLeaves();
            }
        }

        private void LoadDashboardStats()
        {
            dbConn.dbConnect();

            try
            {
                

                lblTotalEmployees.Text = new SqlCommand("SELECT COUNT(*) FROM EMPLOYEE", dbConn.con).ExecuteScalar().ToString();
                lblTotalProjects.Text = new SqlCommand("SELECT COUNT(*) FROM PROJECT WHERE STATUS = 'Active'", dbConn.con).ExecuteScalar().ToString();
                lblTotalTasks.Text = new SqlCommand("SELECT COUNT(*) FROM TASK WHERE DUE_DATE > GETDATE()", dbConn.con).ExecuteScalar().ToString();
                lblPendingLeaves.Text = new SqlCommand("SELECT COUNT(*) FROM LEAVES WHERE LEAVE_TYPE = 'Pending'", dbConn.con).ExecuteScalar().ToString();
            }
            catch (Exception ex)
            {
                // Log the error and display a friendly message
                lblTotalEmployees.Text = "Error";
                lblTotalProjects.Text = "Error";
                lblTotalTasks.Text = "Error";
                lblPendingLeaves.Text = "Error";
                // Log error to a file or database (optional)
                System.Diagnostics.Debug.WriteLine("Error in LoadDashboardStats: " + ex.Message);
            }

        }

        private void LoadRecentProjects()
        {
            string query = "SELECT TOP 5 PROJECT_NAME, DESCRIPTION, START_DATE, END_DATE FROM PROJECT ORDER BY START_DATE DESC";
            LoadDataIntoGrid(query, gvRecentProjects);
        }

        private void LoadUpcomingLeaves()
        {
            string query = "SELECT TOP 5 EMPLOYEE.FULL_NAME, LEAVES.LEAVE_TYPE, LEAVES.START_DATE, LEAVES.END_DATE " +
                           "FROM LEAVES INNER JOIN EMPLOYEE ON LEAVES.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID " +
                           "WHERE LEAVES.START_DATE >= GETDATE() ORDER BY LEAVES.START_DATE ASC";
            LoadDataIntoGrid(query, gvUpcomingLeaves);
        }

        private void LoadDataIntoGrid(string query, System.Web.UI.WebControls.GridView grid)
        {
            dbConn.dbConnect();

            try
            {
                
                SqlDataAdapter adapter = new SqlDataAdapter(query, dbConn.con);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                grid.DataSource = dt;
                grid.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in LoadDataIntoGrid: " + ex.Message);
                grid.DataSource = null;
                grid.DataBind();
            }

        }
    }
}
