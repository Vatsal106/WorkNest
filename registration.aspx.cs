using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.IO;
using System.Configuration;


namespace WorkNest
{
    public partial class registration : System.Web.UI.Page
    {
        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        private bool ValidatePassword(string password)
        {


            const int MinLength = 8;
            const int MaxLength = 20;



            if (password.Length < MinLength || password.Length > MaxLength ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "[A-Z]") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "[a-z]") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "\\d") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "[!@#$%^&*(),.?\"{}|<>]"))
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

        protected void PasswordChanged(object sender, EventArgs e)
        {
            string password = txtPassword.Text;

            // Check for minimum length
            if (password.Length >= 8)
            {
                lblLength.ForeColor = System.Drawing.Color.Green;
                lblLength.Text = "✓ At least 8 characters";
            }
            else
            {
                lblLength.ForeColor = System.Drawing.Color.Red;
                lblLength.Text = "At least 8 characters";
            }

            // Check for at least one number or symbol
            if (System.Text.RegularExpressions.Regex.IsMatch(password, @"[\d!@#$%^&*(),.?""{}|<>]"))
            {
                lblNumberOrSymbol.ForeColor = System.Drawing.Color.Green;
                lblNumberOrSymbol.Text = "✓ At least one number (0-9) or a symbol";
            }
            else
            {
                lblNumberOrSymbol.ForeColor = System.Drawing.Color.Red;
                lblNumberOrSymbol.Text = "At least one number (0-9) or a symbol";
            }

            // Check for both uppercase and lowercase letters
            if (System.Text.RegularExpressions.Regex.IsMatch(password, "[A-Z]") && System.Text.RegularExpressions.Regex.IsMatch(password, "[a-z]"))
            {
                lblCase.ForeColor = System.Drawing.Color.Green;
                lblCase.Text = "✓ Lowercase (a-z) and uppercase (A-Z)";
            }
            else
            {
                lblCase.ForeColor = System.Drawing.Color.Red;
                lblCase.Text = "Lowercase (a-z) and uppercase (A-Z)";
            }
        }

        protected void dbConnect()
        {
            string strconn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            con = new SqlConnection(strconn);
            con.Open();

            if (con.State == ConnectionState.Open)
            {
                Response.Write("Database connection established successfully.");

            }
            else
            {
                Response.Write("Failed to connect to the database.");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string selectedCity = ddlCity.SelectedItem.Text;

            // DATE FORMET:-'2023-01-24'
            // Construct the query


            // Execute the query

            try
            {


                if (string.IsNullOrWhiteSpace(txtName.Text))
                {
                    lblError.Text = "Please enter your name.";
                    lblError.ForeColor = Color.Red;
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
                    byte[] imageBytes = null;

                    // Check if a file is uploaded
                    if (fuImage.HasFile)
                    {
                        using (Stream fs = fuImage.PostedFile.InputStream)
                        {
                            using (BinaryReader br = new BinaryReader(fs))
                            {
                                imageBytes = br.ReadBytes((int)fs.Length);
                            }
                        }
                    }
                    dbConnect();
                    string query = "INSERT INTO REGISTER(NAME, PHONE, EMAIL, USERNAME, PASSWORD, GENDER, CITY, ADDRESS,DOB,IMAGE) " +
                      "VALUES ('" + txtName.Text + "', '" + txtPhone.Text + "', '" + txtEmail.Text + "', '" +
                      txtUsername.Text + "', '" + txtPassword.Text + "', '" + rblGender.SelectedItem.Text + "', '" +
                      selectedCity + "', '" + txtAddress.Text + "','" + txtDate.Text + "',@IMAGE)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Image", (object)imageBytes ?? DBNull.Value);

                    cmd.ExecuteNonQuery();


                }
                Response.Write("Registration Successful");
                Response.Redirect("login.aspx");
            }
            catch (Exception ex)
            {
                // Log the error (in a real application, consider using a logging framework)
                Response.Write($"Error: {ex.Message.ToString()}");
            }

        }
    }

}
