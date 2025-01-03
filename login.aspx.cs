﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest
{

    public partial class login : System.Web.UI.Page
    {
        //SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void btnLogin_Click(object sender, EventArgs e)
        {

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            dbConnection dbConn = new dbConnection();
            dbConn.dbConnect();
            string loginQuery = "SELECT COUNT(1) FROM tblRegister WHERE USERNAME = @Username AND PASSWORD = @Password";
            string imageQuery = "SELECT IMAGE FROM tblRegister WHERE USERNAME = @Username AND PASSWORD = @Password";
            try
            {


                // Check user credentials
                SqlCommand loginCmd = new SqlCommand(loginQuery, dbConn.con);
                loginCmd.Parameters.AddWithValue("@Username", username);
                loginCmd.Parameters.AddWithValue("@Password", password);

                int count = (int)loginCmd.ExecuteScalar();

                if (count == 1)
                {
                    lblMessage.Text = "Login successful!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    //// Fetch the user's image
                    //SqlCommand imageCmd = new SqlCommand(imageQuery, conn);
                    //imageCmd.Parameters.AddWithValue("@Username", username);
                    //imageCmd.Parameters.AddWithValue("@Password", password);

                    //byte[] imageBytes = imageCmd.ExecuteScalar() as byte[];
                    //if (imageBytes != null && imageBytes.Length > 0)
                    //{
                    //    imgPhoto.EnableViewState = true;
                    //    string base64Image = Convert.ToBase64String(imageBytes);
                    //    imgPhoto.ImageUrl = "data:image/png;base64," + base64Image;
                    //}
                    //else
                    //{
                    //    imgPhoto.ImageUrl = "~/Images/default.png"; // Fallback to default image
                    //}
                }
                else
                {
                    lblMessage.Text = "Invalid Username or Password!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                Response.Write($"Error: {ex.Message}");
            }
            finally
            {
                dbConn.con.Close();
            }

        }
    }
}