using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Project_Manager
{
    public partial class P_ManagerDashboard : Page
    {
        dbConnection dbconn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatistics();
                LoadClientReviews();
            }
        }

        private void LoadStatistics()
        {
            dbconn.dbConnect();

            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM PROJECT", dbconn.con);
            lblTotalProject.Text = cmd.ExecuteScalar().ToString();

            cmd.CommandText = "SELECT COUNT(*) FROM EMPLOYEE";
            lblTotalEmployee.Text = cmd.ExecuteScalar().ToString();

            cmd.CommandText = "SELECT COUNT(*) FROM TASK";
            lblTotalTask.Text = cmd.ExecuteScalar().ToString();

            dbconn.con.Close();
        }

        private void LoadClientReviews()
        {
            dbconn.dbConnect();

            SqlCommand cmd = new SqlCommand("SELECT TOP 2 CLIENT_NAME,Review FROM CLIENTS ORDER BY NEWID()", dbconn.con);
            SqlDataReader reader = cmd.ExecuteReader();

            int count = 1;
            while (reader.Read())
            {
                if (count == 1)
                {
                    lblReview1.Text = "\"" + reader["Review"].ToString() + "\"";
                    lblClient1.Text = "- " + reader["CLIENT_NAME"].ToString();
                }
                else
                {
                    lblReview2.Text = "\"" + reader["Review"].ToString() + "\"";
                    lblClient2.Text = "- " + reader["CLIENT_NAME"].ToString();
                }
                count++;
            }
            dbconn.con.Close();
        }

    }
}
