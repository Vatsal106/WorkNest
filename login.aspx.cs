using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            string connectionString = "Data Source=VATSAL\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            //string connectionString = "Data Source=LAPTOP-C6B669RO\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            string query = "SELECT COUNT(1) FROM REGISTER WHERE USERNAME = @Username AND PASSWORD = @Password";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.ExecuteNonQuery();
                    int count = (int)cmd.ExecuteScalar();

                    if (count == 1)
                    {
                        Response.Write("Login Successful");
                    }
                    else
                    {
                        Response.Write("Invalid Username or Password");
                    }
                    
                }
                catch (Exception ex)
                {
                    Response.Write($"Error: {ex.Message}");
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}