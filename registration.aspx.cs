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
        private bool ValidatePassword(string password)
        {
            const int MinLength = 8;
            const int MaxLength = 20;
            string errorMessages = "";

            if (password.Length < MinLength || password.Length > MaxLength)
            {
                errorMessages += "Password length must be between 8 and 20 characters.<br/>";
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[A-Z]"))
            {
                errorMessages += "Password must contain at least one uppercase letter.<br/>";
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[a-z]"))
            {
                errorMessages += "Password must contain at least one lowercase letter.<br/>";
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"\d"))
            {
                errorMessages += "Password must contain at least one numeric digit.<br/>";
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[!@#$%^&*(),.?""{}|<>]"))
            {
                errorMessages += "Password must contain at least one special character.<br/>";
            }

            if (!string.IsNullOrEmpty(errorMessages))
            {
                lblPasserror.Text = errorMessages; 
                return false;
            }

            return true;
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
             

        string connectionString = "Data Source=LAPTOP-C6B669RO\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            //string connectionString = "Data Source=VATSAL\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            //string connectionString = "Data Source=DESKTOP-4D8U420\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            
            string selectedCity = ddlCity.SelectedItem.Text;

            // DATE FORMET:-'2023-01-24'
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

                    if (!ValidatePassword(txtPassword.Text))
                    {
                        return;
                    }

                    if (txtPassword.Text == txtRepassword.Text)
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand(query, conn);
                    
                        cmd.ExecuteNonQuery();
                   
                    Response.Write("Registration Successful");
                    Response.Redirect("login.aspx");
                    }
                    else
                    {
                        lblPasserror.Text = "Password does not match!!";
                    }
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