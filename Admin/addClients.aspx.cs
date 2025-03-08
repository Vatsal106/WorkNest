using System;
using System.Data.SqlClient;
using System.Drawing;

namespace WorkNest.Admin
{
    public partial class addClients : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtClientName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtPhoneNumber.Text) ||
                string.IsNullOrWhiteSpace(txtCompanyName.Text) ||
                string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                lblError.Text = "All fields are required.";
                lblError.ForeColor = Color.Red;
                return;
            }

            try
            {
                dbConn.dbConnect();
                string query = "INSERT INTO CLIENTS (CLIENT_NAME, EMAIL, PHONE_NUMBER, COMPANY_NAME, ADDRESS) VALUES (@NAME, @EMAIL, @NUMBER, @COMPANY_NAME, @ADDRESS)";
                using (SqlCommand cmd = new SqlCommand(query, dbConn.con))
                {
                    cmd.Parameters.AddWithValue("@NAME", txtClientName.Text.Trim());
                    cmd.Parameters.AddWithValue("@EMAIL", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@NUMBER", txtPhoneNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@COMPANY_NAME", txtCompanyName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ADDRESS", txtAddress.Text.Trim());

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        btnReset_Click(sender, e);
                        lblError.Text = "Client added successfully!";
                        lblError.ForeColor = Color.Green;
                    }
                    else
                    {
                        lblError.Text = "Failed to add client.";
                        lblError.ForeColor = Color.Red;
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                lblError.Text = "Database error: " + sqlEx.Message;
                lblError.ForeColor = Color.Red;
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtClientName.Text = "";
            txtEmail.Text = "";
            txtPhoneNumber.Text = "";
            txtCompanyName.Text = "";
            txtAddress.Text = "";
            lblError.Text = "";
        }
    }
}
