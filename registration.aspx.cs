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

            if (password.Length < MinLength || password.Length > MaxLength)
            {
                lblError.Text = "Invalid Password, Please Rewrite!!"; return false;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[A-Z]"))
            {
                lblError.Text = "Invalid Password, Please Rewrite!!"; return false;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[a-z]"))
            {
                lblError.Text = "Invalid Password, Please Rewrite!!"; return false;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "\\d"))
            {
                lblError.Text = "Invalid Password, Please Rewrite!!"; return false;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[!@#$%^&*(),.?\"{}|<>]"))
            {
                lblError.Text = "Invalid Password, Please Rewrite!!";
                return false;
            }

            if (txtPassword.Text != txtRepassword.Text)
            {
                lblError.Text = "Password does not matched.";
                
                return false;
            }

            return true;

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {


            //string connectionString = "Data Source=LAPTOP-C6B669RO\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            string connectionString = "Data Source=VATSAL\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";
            //string connectionString = "Data Source=DESKTOP-4D8U420\\SQLEXPRESS;Initial Catalog=WORKNEST;Integrated Security=True";

            string selectedCity = ddlCity.SelectedItem.Text;

            // DATE FORMET:-'2023-01-24'
            // Construct the query


            // Execute the query
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {

                    
                     if (string.IsNullOrWhiteSpace(txtName.Text))
                    {
                        lblError.Text = "Please enter your name.";
                        lblError.ForeColor= Color.Red;
                        return;
                    }

                    else if (string.IsNullOrWhiteSpace(txtPhone.Text) || string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtUsername.Text))
                    {
                        lblError.Text = "Please fill all required fields.";
                        lblError.ForeColor = Color.Red;
                        return;
                    }
                    else if (!ValidatePassword(txtPassword.Text))
                    {
                        lblError.ForeColor = Color.Red;
                        return;
                    }
                    else
                    {
                        conn.Open();
                        string query = "INSERT INTO REGISTER(NAME, PHONE, EMAIL, USERNAME, PASSWORD, GENDER, CITY, ADDRESS,DOB) " +
                          "VALUES ('" + txtName.Text + "', '" + txtPhone.Text + "', '" + txtEmail.Text + "', '" +
                          txtUsername.Text + "', '" + txtPassword.Text + "', '" + rblGender.SelectedItem.Text + "', '" +
                          selectedCity + "', '" + txtAddress.Text + "','" + txtDate.Text + "')";
                        SqlCommand cmd = new SqlCommand(query, conn);

                        cmd.ExecuteNonQuery();

                        Response.Write("Registration Successful");
                        Response.Redirect("login.aspx");
                    }

                }
                catch (Exception ex)
                {
                    // Log the error (in a real application, consider using a logging framework)
                    Response.Write($"Error: {ex.Message.ToString()}");
                }
                finally
                {
                    conn.Close();

                }
            }

        }
    }
}
