using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;

namespace WorkNest
{
    public partial class registration : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        Boolean checkEmailduplicate = false;
        Boolean checkUserduplicate = false;

        protected void Page_Load(object sender, EventArgs e)
        {

            //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
            if (IsPostBack)
            {
                txtPassword.Attributes["value"] = txtPassword.Text;
                txtRepassword.Attributes["value"] = txtRepassword.Text;
                lblEphone.Attributes["Text"] = lblEphone.Text;

            }
            if (!IsPostBack)
            {
                bindDept();
                //bindRoles();
            }
        }
        // check user duplication
        protected void checkUser(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            string nameof = txtUsername.Text.Trim();
            string queryUser = "SELECT COUNT(USER_NAME) FROM USER_CREDENTIALS WHERE USER_NAME ='" + nameof + "'";
            SqlCommand cmdUser = new SqlCommand(queryUser, dbConn.con);

            int count = Convert.ToInt32(cmdUser.ExecuteScalar());
            dbConn.con.Close();
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
        void Lable()
        {
            lblLength.ForeColor = Color.Blue;
            lblCase.ForeColor = Color.Blue;
            lblNumberOrSymbol.ForeColor = Color.Blue;
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //checkUserduplicate = true;
            EmailChange(sender, e);
            checkUser(sender, e);
            //Lable();
            try
            {
                //if (string.IsNullOrWhiteSpace(txtName.Text) ||
                //    string.IsNullOrWhiteSpace(txtPhone.Text) ||
                //    string.IsNullOrWhiteSpace(txtEmail.Text) ||
                //    string.IsNullOrWhiteSpace(txtUsername.Text))
                //{
                //    lblError.Text = "Please fill all required fields.";
                //    lblError.ForeColor = Color.Red;
                //    return;
                //}

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

                if (checkUserduplicate && imgSeted && checkEmailduplicate)
                {

                    SqlTransaction transaction = dbConn.con.BeginTransaction();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = dbConn.con;
                    cmd.Transaction = transaction;

                    try
                    {
                        // Insert Employee data
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

                        // Get the inserted employee's ID
                        string queryID = "SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE EMAIL = @Email";
                        cmd.CommandText = queryID;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        int empid = Convert.ToInt32(cmd.ExecuteScalar());

                        // Insert User Credentials
                        //string hashedPassword = BCrypt.HashPassword(txtPassword.Text.Trim());

                        cmd.CommandText = "INSERT INTO USER_CREDENTIALS (USER_NAME, PASSWORD, EMPLOYEE_ID) VALUES (@Username, @Password, @EmpID)";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                        cmd.Parameters.AddWithValue("@EmpID", empid);
                        cmd.ExecuteNonQuery();

                        // Assign Role to Employee
                        int RoleId = 3;
                        string queryRole = "INSERT INTO EMPLOYEE_ROLES (EMPLOYEE_ID, ROLE_ID, ASSIGNED_DATE) VALUES (@EmpId, @RoleId, @AssignedDate)";
                        cmd.CommandText = queryRole;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@EmpId", empid);
                        cmd.Parameters.AddWithValue("@RoleId", RoleId);
                        cmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now.Date);
                        cmd.ExecuteNonQuery();

                        // Commit transaction if all queries succeed
                        transaction.Commit();

                        // Clear the form and display success message
                        btnReset_Click(sender, e);
                        lblError.Text = "Employee added successfully!";
                        lblError.ForeColor = Color.Green;
                    }
                    catch (Exception ex)
                    {
                        // Rollback transaction on failure
                        transaction.Rollback();
                        lblError.Text = "An error occurred: " + ex.Message;
                        lblError.ForeColor = Color.Red;

                    }
                }
                else if (!imgSeted)
                {
                    lblError.Text = "Please Select Image!!";
                    lblError.ForeColor = Color.Red;
                }
                else
                {
                    lblError.Text = "somthing went wrong!!";
                    lblError.ForeColor = Color.Red;
                }

            }



            catch (Exception ex)
            {

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

            fuImage.Attributes.Clear();
            txtPassword.Attributes["value"] = string.Empty;
            txtPassword.Enabled = false;
            txtRepassword.Attributes["value"] = string.Empty;
            txtRepassword.Enabled = false;
            lblError.Text = string.Empty;
            lblEemail.Text = string.Empty;
            //lblCon.Text = string.Empty;
            //lblLength.Text = "At least 8 characters";
            //lblNumberOrSymbol.Text = "At least one number (0-9) or a symbol";
            //lblCase.Text = "Lowercase (a-z) and uppercase (A-Z)";
        }
        public void bindDept()
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

        protected void EmailChange(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            string emaail = txtEmail.Text.Trim();
            string queryEmail = "SELECT COUNT(*) FROM EMPLOYEE WHERE EMAIL = @Email";
            SqlCommand cmdEmail = new SqlCommand(queryEmail, dbConn.con);
            cmdEmail.Parameters.AddWithValue("@Email", emaail);


            int count = Convert.ToInt32(cmdEmail.ExecuteScalar());
            dbConn.con.Close();
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
        //public void bindRoles()
        //{
        //    dbConn.dbConnect();
        //    string query = "SELECT * FROM ROLES where ROLE_ID <> 1";
        //    SqlDataAdapter adpt = new SqlDataAdapter(query, dbConn.con);
        //    DataSet ds = new DataSet();
        //    adpt.Fill(ds);
        //    ddlRole.DataSource = ds;
        //    ddlRole.DataTextField = "ROLE_NAME";
        //    ddlRole.DataValueField = "ROLE_ID";
        //    ddlRole.DataBind();
        //    ddlRole.Items.Insert(0, "---select---");
        //}
    }

}
