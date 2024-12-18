using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;

namespace WorkNest
{
    public partial class registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //string connectionString = "Data Source=VATSAL\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            //SqlConnection conn = new SqlConnection(connectionString);
            //conn.Open();
            //string username = txtName.Text;
            //string query = ("INSERT INTO RGISTER(NAME) VALUES('"+username+"');");
            //SqlCommand cmd = new SqlCommand(query, conn);
            //cmd.ExecuteNonQuery();
            //conn.Close();

            //string connectionString = "Data Source=LAPTOP-C6B669RO\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            string connectionString = "Data Source=VATSAL\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            // Get the selected city from the DropDownList
            string selectedCity = ddlCity.SelectedItem.Text;

            // Construct the query
            string query = "INSERT INTO REGISTER(NAME, PHONE, EMAIL, USERNAME, PASSWORD, GENDER, CITY, ADDRESS) " +
                           "VALUES ('" + txtName.Text + "', '" + txtPhone.Text + "', '" + txtEmail.Text + "', '" +
                           txtUsername.Text + "', '" + txtPassword.Text + "', '" + rblGender.SelectedItem.Text + "', '" +
                           selectedCity + "', '" + txtAddress.Text + "')";

            // Execute the query
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.ExecuteNonQuery();
                    Response.Write("Registration Successful");
                }
                catch (Exception ex)
                {
                    // Log the error (in a real application, consider using a logging framework)
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