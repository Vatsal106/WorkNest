using System;
using System.Data.SqlClient;

namespace WorkNest
{
    public partial class registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Use connection string from Web.config
            string strconn = System.Configuration.ConfigurationManager.ConnectionStrings["WorkNest"].ConnectionString;

            // Use 'using' blocks for proper resource disposal
            using (SqlConnection conn = new SqlConnection(strconn))
            {
                try
                {
                    conn.Open();

                    // Use parameterized queries to prevent SQL injection
                    string query = "INSERT INTO register (name) VALUES (@Name)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Display success message (optional)
                            lblCon.Text = "Registration successful!";
                        }
                        else
                        {
                            lblCon.Text = "Registration failed. Please try again.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log or display the error (avoid exposing sensitive details to users)
                    lblCon.Text = "An error occurred. Please contact support.";
                    // Log error details: ex.Message
                }
            }
        }
    }
}
