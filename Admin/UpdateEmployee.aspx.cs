﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;

namespace WorkNest.Admin
{
    public partial class UpdateEmployee : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        Boolean checkEmailduplicate = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    LoadDepartments();
                    if (Request.QueryString["EmployeeID"] != null)
                    {
                        string employeeId = Request.QueryString["EmployeeID"];
                        hfEmployeeID.Value = employeeId;
                        LoadEmployeeDetails(employeeId);
                    }
                    else
                    {
                        Response.Redirect("Employees.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading page: " + ex.Message + "');</script>");
            }
        }

        private void LoadEmployeeDetails(string employeeId)
        {
            try
            {
                dbConn.dbConnect();
                string query = "SELECT FULL_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, DEPARTMENT_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = @EmployeeID";
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtFullName.Text = dr["FULL_NAME"].ToString();
                    txtEmail.Text = dr["EMAIL"].ToString();
                    txtPhoneNumber.Text = dr["PHONE_NUMBER"].ToString();
                    txtHireDate.Text = Convert.ToDateTime(dr["HIRE_DATE"]).ToString("yyyy-MM-dd");
                    ddlDepartment.SelectedValue = dr["DEPARTMENT_ID"].ToString();
                }
                dr.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading employee details: " + ex.Message + "');</script>");
            }
        }

        private void LoadDepartments()
        {
            try
            {
                dbConn.dbConnect();
                string query = "SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENT";
                SqlDataAdapter da = new SqlDataAdapter(query, dbConn.con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlDepartment.DataSource = dt;
                ddlDepartment.DataTextField = "DEPARTMENT_NAME";
                ddlDepartment.DataValueField = "DEPARTMENT_ID";
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, "Select Department");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading departments: " + ex.Message + "');</script>");
            }
        }

        protected void btnUpdateEmployee_Click(object sender, EventArgs e)
        {
            try
            {
                EmailChange(sender, e);
                if (checkEmailduplicate)
                {
                    string employeeId = hfEmployeeID.Value;
                    string fullName = txtFullName.Text.Trim();
                    string email = txtEmail.Text.Trim();
                    string phone = txtPhoneNumber.Text.Trim();
                    string hireDate = txtHireDate.Text;
                    string departmentId = ddlDepartment.SelectedValue;

                    byte[] imageBytes = null;

                    if (fuProfileImage.HasFile)
                    {
                        string fileExtension = Path.GetExtension(fuProfileImage.FileName).ToLower();
                        string[] allowedExtensions = { ".jpg", ".jpeg", ".png" };
                        int maxFileSize = 4 * 1024 * 1024;

                        if (!allowedExtensions.Contains(fileExtension))
                        {
                            lblError.Text = "Invalid image format. Only .jpg, .jpeg, and .png are allowed.";
                            lblError.ForeColor = Color.Red;
                            return;
                        }

                        if (fuProfileImage.FileContent.Length > maxFileSize)
                        {
                            lblError.Text = "File size must be less than 4MB.";
                            lblError.ForeColor = Color.Red;
                            return;
                        }

                        imageBytes = fuProfileImage.FileBytes;
                    }
                    dbConn.dbConnect();
                    string query = @"
                    UPDATE EMPLOYEE 
                    SET FULL_NAME = @FullName, EMAIL = @Email, PHONE_NUMBER = @Phone, 
                        HIRE_DATE = @HireDate, DEPARTMENT_ID = @DepartmentId";

                    if (imageBytes != null)
                    {
                        query += ", IMAGE = @Image";
                    }

                    query += " WHERE EMPLOYEE_ID = @EmployeeID";

                    SqlCommand cmd = new SqlCommand(query, dbConn.con);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@HireDate", hireDate);
                    cmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

                    if (imageBytes != null)
                    {
                        cmd.Parameters.AddWithValue("@Image", imageBytes);
                    }

                    cmd.ExecuteNonQuery();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Employee updated successfully'); window.location='Employees.aspx';", true);
                    Response.Redirect("Employees.aspx");
                }
                else
                {
                    lblError.Text = "Something went wrong!!";
                    lblError.ForeColor = Color.Red;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error updating employee: " + ex.Message + "');</script>");
            }
        }

        protected void EmailChange(object sender, EventArgs e)
        {
            try
            {
                dbConn.dbConnect();
                string email = txtEmail.Text.Trim();
                string queryEmail = "SELECT COUNT(*) FROM EMPLOYEE WHERE EMAIL = @Email and Employee_id<>@Emp_id";
                SqlCommand cmdEmail = new SqlCommand(queryEmail, dbConn.con);
                cmdEmail.Parameters.AddWithValue("@Email", email);
                cmdEmail.Parameters.AddWithValue("@Emp_id", hfEmployeeID.Value);

                int count = Convert.ToInt32(cmdEmail.ExecuteScalar());

                if (count > 0)
                {
                    lblEemail.Text = "This Email Address is already taken!!";
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
                Response.Write("<script>alert('Error checking email: " + ex.Message + "');</script>");
            }
        }
    }
}
