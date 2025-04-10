﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;

namespace WorkNest.Admin
{
    public partial class registrations : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        Boolean checkEmailduplicate = false;
        Boolean checkUserduplicate = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                txtPassword.Attributes["value"] = txtPassword.Text;
                txtRepassword.Attributes["value"] = txtRepassword.Text;
                lblEphone.Attributes["Text"] = lblEphone.Text;
            }
            if (!IsPostBack)
            {
                bindDept();
            }
            //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
        }

        protected void checkUser(object sender, EventArgs e)
        {
            try
            {
                dbConn.dbConnect();
                string nameof = txtUsername.Text.Trim();
                string queryUser = "SELECT COUNT(USER_NAME) FROM USER_CREDENTIALS WHERE USER_NAME = @Username";
                SqlCommand cmdUser = new SqlCommand(queryUser, dbConn.con);
                cmdUser.Parameters.AddWithValue("@Username", nameof);

                int count = Convert.ToInt32(cmdUser.ExecuteScalar());

                if (count > 0)
                {
                    lblEuser.Text = "This username is already taken.";
                    lblEuser.ForeColor = Color.Red;
                    checkUserduplicate = false;
                }
                else
                {
                    lblEuser.Text = "";
                    checkUserduplicate = true;
                    txtPassword.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                EmailChange(sender, e);
                checkUser(sender, e);

                dbConn.dbConnect();
                byte[] imageBytes = null;
                bool imgSeted = false;

                if (fuImage.HasFile)
                {
                    imgSeted = true;
                    string fileExtension = Path.GetExtension(fuImage.FileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png" };
                    int maxFileSize = 4 * 1024 * 1024;

                    if (!allowedExtensions.Contains(fileExtension))
                    {
                        lblError.Text = "Invalid image format. Only .jpg, .jpeg, and .png are allowed.";
                        lblError.ForeColor = Color.Red;
                        return;
                    }

                    if (fuImage.FileContent.Length > maxFileSize)
                    {
                        lblError.Text = "File size must be less than 4MB.";
                        lblError.ForeColor = Color.Red;
                        return;
                    }

                    imageBytes = fuImage.FileBytes;
                }

                if (checkUserduplicate && imgSeted && checkEmailduplicate)
                {
                    SqlTransaction transaction = dbConn.con.BeginTransaction();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = dbConn.con;
                    cmd.Transaction = transaction;

                    try
                    {
                        string query = "INSERT INTO EMPLOYEE (FULL_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, IMAGE, DEPARTMENT_ID) " +
                                       "VALUES (@Name, @Email, @Phone, @Hire, @Image, @Department)";
                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Hire", txtDate.Text);
                        cmd.Parameters.AddWithValue("@Image", (object)imageBytes ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@Department", ddlDept.SelectedValue);
                        cmd.ExecuteNonQuery();

                        string queryID = "SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE EMAIL = @Email";
                        cmd.CommandText = queryID;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        int empid = Convert.ToInt32(cmd.ExecuteScalar());

                        cmd.CommandText = "INSERT INTO USER_CREDENTIALS (USER_NAME, PASSWORD, EMPLOYEE_ID) VALUES (@Username, @Password, @EmpID)";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                        cmd.Parameters.AddWithValue("@EmpID", empid);
                        cmd.ExecuteNonQuery();

                        int RoleId = 3;
                        string queryRole = "INSERT INTO EMPLOYEE_ROLES (EMPLOYEE_ID, ROLE_ID, ASSIGNED_DATE) VALUES (@EmpId, @RoleId, @AssignedDate)";
                        cmd.CommandText = queryRole;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@EmpId", empid);
                        cmd.Parameters.AddWithValue("@RoleId", RoleId);
                        cmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now.Date);
                        cmd.ExecuteNonQuery();

                        transaction.Commit();

                        btnReset_Click(sender, e);
                        lblError.Text = "Employee added successfully!";
                        lblError.ForeColor = Color.Green;
                        Response.Redirect("Employees.aspx");
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        lblError.Text = "An error occurred: " + ex.Message;
                        lblError.ForeColor = Color.Red;
                    }
                }
                else if (!imgSeted)
                {
                    lblError.Text = "Please select an image.";
                    lblError.ForeColor = Color.Red;
                }
                else
                {
                    lblError.Text = "Something went wrong.";
                    lblError.ForeColor = Color.Red;
                }
            }
            catch (Exception ex)
            {
                Response.Write($"Error: {ex.Message}");
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

            fuImage.Attributes.Clear();
            txtPassword.Attributes["value"] = string.Empty;
            txtPassword.Enabled = false;
            txtRepassword.Attributes["value"] = string.Empty;
            txtRepassword.Enabled = false;
            lblError.Text = string.Empty;
            lblEemail.Text = string.Empty;
        }

        public void bindDept()
        {
            try
            {
                dbConn.dbConnect();
                string query = "SELECT * FROM DEPARTMENT";
                SqlDataAdapter adpt = new SqlDataAdapter(query, dbConn.con);
                DataSet ds = new DataSet();
                adpt.Fill(ds);
                ddlDept.DataSource = ds;
                ddlDept.DataTextField = "DEPARTMENT_NAME";
                ddlDept.DataValueField = "DEPARTMENT_ID";
                ddlDept.DataBind();
                ddlDept.Items.Insert(0, "---select---");
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        protected void EmailChange(object sender, EventArgs e)
        {
            try
            {
                dbConn.dbConnect();
                string email = txtEmail.Text.Trim();
                string queryEmail = "SELECT COUNT(*) FROM EMPLOYEE WHERE EMAIL = @Email";
                SqlCommand cmdEmail = new SqlCommand(queryEmail, dbConn.con);
                cmdEmail.Parameters.AddWithValue("@Email", email);

                int count = Convert.ToInt32(cmdEmail.ExecuteScalar());

                if (count > 0)
                {
                    lblEemail.Text = "This Email is already taken.";
                    lblEemail.ForeColor = Color.Red;
                    checkEmailduplicate = false;
                }
                else
                {
                    lblEemail.Text = "";
                    checkEmailduplicate = true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }
    }
}
