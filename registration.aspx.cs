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
        dbConnection dbConn = new dbConnection();
        Boolean runInsert = false;
        Boolean checkUserduplicate = false;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack)
            {
                txtPassword.Attributes["value"] = txtPassword.Text;
                txtRepassword.Attributes["value"] = txtRepassword.Text;
            }
        }
        // check user duplication
        protected void checkUser(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            string nameof = txtUsername.Text.Trim();
            string queryUser = "SELECT COUNT(username) FROM tbl_user WHERE username ='" + nameof + "'";
            SqlCommand cmdUser = new SqlCommand(queryUser, dbConn.con);

            int count = Convert.ToInt32(cmdUser.ExecuteScalar());
            dbConn.con.Close();
            if (count > 0)
            {
                lblError.Text = "This username is already taken. Please choose another.";
                lblError.ForeColor = Color.Red;
                checkUserduplicate = false;

            }
            else
            {
                lblError.Text = "";
                checkUserduplicate = true;
            }
        }

        // check password is valide or not?
        private bool ValidatePassword()
        {
            string password = txtPassword.Text;

            if (password.Length < 8 ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "[A-Z]") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "[a-z]") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "[0-9]") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, "[!@#$%^&*(),.?\"{}|<>]"))
            {
                lblError.Text = "Invalid password. Please make sure it meets the requirements.";
                lblError.ForeColor = Color.Red;
                return false;
            }
            return true;
        }

        //event for password is acording conditon or not,that user can view what is on password and what is not 
        protected void PasswordChanged(object sender, EventArgs e)
        {
            string password = txtPassword.Text;
            runInsert = true;

            if (password.Length >= 8)
            {
                lblLength.ForeColor = Color.Green;
                lblLength.Text = "✓ At least 8 characters";
            }
            else
            {
                lblLength.ForeColor = Color.Red;
                lblLength.Text = "At least 8 characters";
                runInsert = false;
            }

            if (System.Text.RegularExpressions.Regex.IsMatch(password, @"[\d!@#$%^&*(),.?""{}|<>]"))
            {
                lblNumberOrSymbol.ForeColor = Color.Green;
                lblNumberOrSymbol.Text = "✓ At least one number (0-9) or a symbol";
            }
            else
            {
                lblNumberOrSymbol.ForeColor = Color.Red;
                lblNumberOrSymbol.Text = "At least one number (0-9) or a symbol";
                runInsert = false;
            }

            if (System.Text.RegularExpressions.Regex.IsMatch(password, "[A-Z]") && System.Text.RegularExpressions.Regex.IsMatch(password, "[a-z]"))
            {
                lblCase.ForeColor = Color.Green;
                lblCase.Text = "✓ Lowercase (a-z) and uppercase (A-Z)";
            }
            else
            {
                lblCase.ForeColor = Color.Red;
                lblCase.Text = "Lowercase (a-z) and uppercase (A-Z)";
                runInsert = false;
            }
        }


        protected void checkBothPass_TextChanged(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtRepassword.Text)
            {
                lblError.Text = "Password does not matched.";

                runInsert = false;
            }
            else
            {
                lblError.Text = "";
                runInsert = true;
            }


        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //checkUserduplicate = true;
            checkUser(sender, e);
            string selectedCity = ddlCity.SelectedItem.Text;

            try
            {
                if (string.IsNullOrWhiteSpace(txtName.Text) ||
                    string.IsNullOrWhiteSpace(txtPhone.Text) ||
                    string.IsNullOrWhiteSpace(txtEmail.Text) ||
                    string.IsNullOrWhiteSpace(txtUsername.Text))
                {
                    lblError.Text = "Please fill all required fields.";
                    lblError.ForeColor = Color.Red;
                    return;
                }

                if (!ValidatePassword())
                {
                    return;
                }

                if (txtPassword.Text != txtRepassword.Text)
                {
                    lblError.Text = "Passwords do not match.";
                    lblError.ForeColor = Color.Red;
                    return;
                }

                dbConn.dbConnect();
                byte[] imageBytes = null;
                bool imgSeted = false;
                if (fuImage.HasFile)
                {
                    imgSeted = true;
                    string fileExtension = Path.GetExtension(fuImage.FileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

                    if (!allowedExtensions.Contains(fileExtension))
                    {
                        lblError.Text = "Invalid image format. Only .jpg, .jpeg, .png, and .gif are allowed.";
                        lblError.ForeColor = Color.Red;
                        return;
                    }

                    using (Stream fs = fuImage.PostedFile.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            imageBytes = br.ReadBytes((int)fs.Length);
                        }
                    }
                }

                if (checkUserduplicate && imgSeted)
                {

                    string query = "INSERT INTO tbl_employee (name, phone, email, gender, city, address, dob, image) " +
                  "VALUES (@Name, @Phone, @Email, @Gender, @City, @Address, @Dob, @Image)";

                    SqlCommand cmd = new SqlCommand(query, dbConn.con);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gender", rblGender.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@City", selectedCity);
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@Dob", txtDate.Text);
                    cmd.Parameters.AddWithValue("@Image", (object)imageBytes ?? DBNull.Value);

                    cmd.ExecuteNonQuery();

                    string query1 = "SELECT empid FROM tbl_employee WHERE email = @Email";
                    SqlCommand cmdid = new SqlCommand(query1, dbConn.con);
                    cmdid.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    int empid = Convert.ToInt32(cmdid.ExecuteScalar());

                    string queryUser = "INSERT INTO tbl_user (username, password, empid) VALUES (@Username, @Password, @EmpID)";
                    SqlCommand cmdUser = new SqlCommand(queryUser, dbConn.con);
                    cmdUser.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmdUser.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmdUser.Parameters.AddWithValue("@EmpID", empid);

                    cmdUser.ExecuteNonQuery();

                    Response.Write("Registration Successful");
                    Response.Redirect("login.aspx");
                }
                else if (!imgSeted)
                {
                    lblError.Text = "Please Select Image!!";
                }

            }



            catch (Exception ex)
            {
                // Log the error (in a real application, consider using a logging framework)
                Response.Write($"Error: {ex.Message.ToString()}");
            }

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {

            txtName.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtRepassword.Text = string.Empty;
            txtDate.Text = string.Empty;
            txtAddress.Text = string.Empty;
            rblGender.ClearSelection();
            ddlCity.SelectedIndex = 0;
            fuImage.Attributes.Clear();
            txtPassword.Attributes["value"] = string.Empty;
            txtRepassword.Attributes["value"] = string.Empty;

            lblError.Text = string.Empty;
            lblCon.Text = string.Empty;

            lblLength.ForeColor = System.Drawing.Color.Red;
            lblNumberOrSymbol.ForeColor = System.Drawing.Color.Red;
            lblCase.ForeColor = System.Drawing.Color.Red;

            lblLength.Text = "At least 8 characters";
            lblNumberOrSymbol.Text = "At least one number (0-9) or a symbol";
            lblCase.Text = "Lowercase (a-z) and uppercase (A-Z)";
        }
    }

}
