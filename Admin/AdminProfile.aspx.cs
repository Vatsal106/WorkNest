using System;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        dbConnection dbconn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            dbconn.dbConnect();
            string empID = Session["EmployeeID"]?.ToString();
            if (string.IsNullOrEmpty(empID))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            string query = @"SELECT E.FULL_NAME, E.EMAIL, E.PHONE_NUMBER, E.HIRE_DATE, E.IMAGE,
                                    D.DEPARTMENT_NAME, R.ROLE_NAME, 
                                    U.USER_NAME, U.PASSWORD
                             FROM EMPLOYEE E
                             LEFT JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                             LEFT JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID
                             LEFT JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID
                             LEFT JOIN USER_CREDENTIALS U ON E.EMPLOYEE_ID = U.EMPLOYEE_ID
                             WHERE E.EMPLOYEE_ID = @EmployeeID";

            SqlCommand cmd = new SqlCommand(query, dbconn.con);
            cmd.Parameters.AddWithValue("@EmployeeID", empID);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblEmpID.Text = empID;
                lblUsername.Text = reader["USER_NAME"].ToString();
                lblPassword.Text = "********"; // Masked Password
                lblFullName.Text = reader["FULL_NAME"].ToString();
                txtFullName.Text = lblFullName.Text;
                lblEmail.Text = reader["EMAIL"].ToString(); // Email is no longer editable
                lblPhone.Text = reader["PHONE_NUMBER"].ToString();
                txtPhone.Text = lblPhone.Text;
                lblHireDate.Text = Convert.ToDateTime(reader["HIRE_DATE"]).ToString("yyyy-MM-dd");
                lblDepartment.Text = reader["DEPARTMENT_NAME"].ToString();
                lblRole.Text = reader["ROLE_NAME"].ToString();

                // Fetch and display profile image
                if (!reader.IsDBNull(reader.GetOrdinal("IMAGE")))
                {
                    byte[] imgData = (byte[])reader["IMAGE"];
                    string base64String = Convert.ToBase64String(imgData);
                    imgProfile.ImageUrl = "data:image/png;base64," + base64String;
                }
                else
                {
                    imgProfile.ImageUrl = "~/Images/default-profile.png"; // Default image
                }
            }
            reader.Close();
            dbconn.con.Close();
        }
        protected void checkUser(object sender, EventArgs e)
        {
            try
            {
                dbconn.dbConnect();
                string nameof = txtUsername.Text.Trim();
                if (lblUsername.Text != nameof)
                {
                    string queryUser = "SELECT COUNT(USER_NAME) FROM USER_CREDENTIALS WHERE USER_NAME = @Username";
                    SqlCommand cmdUser = new SqlCommand(queryUser, dbconn.con);
                    cmdUser.Parameters.AddWithValue("@Username", nameof);

                    int count = Convert.ToInt32(cmdUser.ExecuteScalar());

                    if (count > 0)
                    {
                        lblError.Text = "This username is already taken.";
                        lblError.ForeColor = Color.Red;
                        return;
                        //checkUserduplicate = false;
                    }
                    else
                    {
                        lblError.Text = "";
                        //checkUserduplicate = true;
                        //txtPassword.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        private void UpdateField(string table, string field, string value, string empID)
        {
            dbconn.dbConnect();
            string query = $"UPDATE {table} SET {field} = @Value WHERE EMPLOYEE_ID = @EmployeeID";
            SqlCommand cmd = new SqlCommand(query, dbconn.con);
            cmd.Parameters.AddWithValue("@Value", value);
            cmd.Parameters.AddWithValue("@EmployeeID", empID);
            cmd.ExecuteNonQuery();
            dbconn.con.Close();
        }

        protected void btnEditFullName_Click(object sender, EventArgs e) => ToggleEdit(txtFullName, lblFullName, btnEditFullName, btnSaveFullName);
        protected void btnSaveFullName_Click(object sender, EventArgs e) => SaveField("EMPLOYEE", "FULL_NAME", txtFullName, lblFullName, btnEditFullName, btnSaveFullName);

        protected void btnEditPhone_Click(object sender, EventArgs e) => ToggleEdit(txtPhone, lblPhone, btnEditPhone, btnSavePhone);
        protected void btnSavePhone_Click(object sender, EventArgs e) => SaveField("EMPLOYEE", "PHONE_NUMBER", txtPhone, lblPhone, btnEditPhone, btnSavePhone);

        protected void btnEditUsername_Click(object sender, EventArgs e) => ToggleEdit(txtUsername, lblUsername, btnEditUsername, btnSaveUsername);
        protected void btnSaveUsername_Click(object sender, EventArgs e)
        {
            checkUser(sender, e);
            SaveField("USER_CREDENTIALS", "USER_NAME", txtUsername, lblUsername, btnEditUsername, btnSaveUsername);
        }
        protected void btnShowPassword_Click(object sender, EventArgs e)
        {
            if (lblPassword.Text == "********")
            {
                dbconn.dbConnect();
                string empID = Session["EmployeeID"]?.ToString();
                if (string.IsNullOrEmpty(empID)) return;

                string query = "SELECT PASSWORD FROM USER_CREDENTIALS WHERE EMPLOYEE_ID = @EmployeeID";
                SqlCommand cmd = new SqlCommand(query, dbconn.con);
                cmd.Parameters.AddWithValue("@EmployeeID", empID);
                object password = cmd.ExecuteScalar();
                dbconn.con.Close();

                if (password != null)
                {
                    lblPassword.Text = password.ToString();  // Show actual password
                    btnShowPassword.Text = "Hide"; // Change button text to "Hide"
                }
            }
            else
            {
                lblPassword.Text = "********"; // Hide password again
                btnShowPassword.Text = "Show"; // Change button text back to "Show"
            }
        }

        private void ToggleEdit(TextBox txt, Label lbl, Button btnEdit, Button btnSave)
        {
            lbl.Visible = false;
            txt.Visible = true;
            btnEdit.Visible = false;
            btnSave.Visible = true;
        }

        private void SaveField(string table, string field, TextBox txt, Label lbl, Button btnEdit, Button btnSave)
        {
            string empID = Session["EmployeeID"]?.ToString();
            UpdateField(table, field, txt.Text, empID);
            lbl.Text = txt.Text;
            lbl.Visible = true;
            txt.Visible = false;
            btnEdit.Visible = true;
            btnSave.Visible = false;
        }

        protected void btnEditImage_Click(object sender, EventArgs e)
        {
            fuProfileImage.Visible = true;
            btnUploadImage.Visible = true;
            btnEditImage.Visible = false;
        }

        protected void btnUploadImage_Click(object sender, EventArgs e)
        {
            if (fuProfileImage.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(fuProfileImage.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblError.Text = "Only JPG and PNG formats are allowed.";
                    lblError.Visible = true;
                    return;
                }

                if (fuProfileImage.PostedFile.ContentLength > 4 * 1024 * 1024)
                {
                    lblError.Text = "File size must be less than 4 MB.";
                    lblError.Visible = true;
                    return;
                }

                try
                {
                    byte[] imageBytes = fuProfileImage.FileBytes;
                    string empID = Session["EmployeeID"]?.ToString();
                    if (!string.IsNullOrEmpty(empID))
                    {
                        dbconn.dbConnect();
                        string query = "UPDATE EMPLOYEE SET IMAGE = @Image WHERE EMPLOYEE_ID = @EmployeeID";
                        SqlCommand cmd = new SqlCommand(query, dbconn.con);
                        cmd.Parameters.AddWithValue("@Image", imageBytes);
                        cmd.Parameters.AddWithValue("@EmployeeID", empID);
                        cmd.ExecuteNonQuery();
                        dbconn.con.Close();

                        LoadProfile();
                        lblError.Visible = false;
                        fuProfileImage.Visible = false;
                        btnUploadImage.Visible = false;
                        btnEditImage.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error uploading image: " + ex.Message;
                    lblError.Visible = true;
                }
            }
            else
            {
                lblError.Text = "Please select an image to upload.";
                lblError.Visible = true;
            }
        }
    }
}
