using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace WorkNest.Project_Manager
{
    public partial class AddLeave : Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Session["EmployeeID"] == null)
                //{
                //    Response.Redirect("~/login.aspx"); // Redirect to login if session expired
                //}
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            dbConn.dbConnect();

            if (Session["EmployeeID"] == null)
            {
                lblMessage.Text = "Session expired. Please log in again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int employeeId;
            if (!int.TryParse(Session["EmployeeID"].ToString(), out employeeId))
            {
                lblMessage.Text = "Invalid Employee ID.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtStartDate.Text) || string.IsNullOrWhiteSpace(txtEndDate.Text))
            {
                lblMessage.Text = "Please select both Start and End dates.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            DateTime startDate, endDate;
            if (!DateTime.TryParse(txtStartDate.Text, out startDate) || !DateTime.TryParse(txtEndDate.Text, out endDate))
            {
                lblMessage.Text = "Invalid date format.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (endDate < startDate)
            {
                lblMessage.Text = "End Date cannot be earlier than Start Date.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string leaveType = ddlLeaveType.SelectedValue;
            string reason = txtReason.Text;
            string status = "Pending"; // Default status

            byte[] FILE = null;
            string fileName = "";
            string fileExtension = "";
            if (fileAttachment.HasFile)
            {
                fileName = Path.GetFileName(fileAttachment.FileName);
                fileExtension = Path.GetExtension(fileAttachment.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".png", ".pdf", ".doc", ".docx" };
                int maxFileSize = 5 * 1024 * 1024; // 5MB

                if (!Array.Exists(allowedExtensions, ext => ext == fileExtension))
                {
                    lblMessage.Text = "Invalid file type. Only JPG, PNG, PDF, DOC, DOCX allowed.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                if (fileAttachment.FileContent.Length > maxFileSize)
                {
                    lblMessage.Text = "File size exceeds the 5MB limit.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                FILE = fileAttachment.FileBytes;
            }

            try
            {
                string query = "INSERT INTO LEAVES (EMPLOYEE_ID, LEAVE_TYPE, START_DATE, END_DATE, REASON, STATUS, ATTACHMENT,FILE_NAME,FILE_EXTANSION) " +
                               "VALUES (@EMPLOYEE_ID, @LEAVE_TYPE, @START_DATE, @END_DATE, @REASON, @STATUS, @ATTACHMENT,@FILE_NAME,@FILE_EXTANTION)";

                using (SqlCommand cmd = new SqlCommand(query, dbConn.con))
                {
                    cmd.Parameters.AddWithValue("@EMPLOYEE_ID", employeeId);
                    cmd.Parameters.AddWithValue("@LEAVE_TYPE", leaveType);
                    cmd.Parameters.AddWithValue("@START_DATE", startDate);
                    cmd.Parameters.AddWithValue("@END_DATE", endDate);
                    cmd.Parameters.AddWithValue("@REASON", reason);
                    cmd.Parameters.AddWithValue("@STATUS", status);
                    cmd.Parameters.AddWithValue("@ATTACHMENT", FILE);
                    cmd.Parameters.AddWithValue("@FILE_NAME", fileName);
                    cmd.Parameters.AddWithValue("@FILE_EXTANTION", fileExtension);

                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "Leave request submitted successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                Response.Redirect("LeaveList.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }

        }
    }
}
