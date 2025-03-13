using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.Project_Manager
{
    public partial class EditTask : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString["TaskID"] != null)
                    {
                        hfTaskID.Value = Request.QueryString["TaskID"];
                        string assignedEmployeeId = LoadTaskDetails(hfTaskID.Value);
                        LoadEmployees(assignedEmployeeId);  // Pass assigned employee ID to retain selection
                    }
                    else
                    {
                        Response.Redirect("AllTasks.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading page: " + ex.Message + "');</script>");
            }
        }

        private string LoadTaskDetails(string taskId)
        {
            dbConn.dbConnect();
            string assignedEmployeeId = "";
            try
            {
                string query = "SELECT TASK_NAME, DESCRIPTION, DUE_DATE, STATUS, ASSIGN_TO FROM TASK WHERE TASK_ID = @TaskID";
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@TaskID", taskId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtTaskName.Text = reader["TASK_NAME"].ToString();
                    txtTaskDesc.Text = reader["DESCRIPTION"].ToString();
                    txtDueDate.Text = Convert.ToDateTime(reader["DUE_DATE"]).ToString("yyyy-MM-dd");
                    ddlStatus.SelectedValue = reader["STATUS"].ToString();

                    assignedEmployeeId = reader["ASSIGN_TO"].ToString();
                }
                reader.Close();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading task details: " + ex.Message + "');</script>");
            }

            return assignedEmployeeId;
        }

        private void LoadEmployees(string assignedEmployeeId)
        {
            dbConn.dbConnect(); // Ensure connection is open
            try
            {
                string query = @"
                SELECT DISTINCT e.EMPLOYEE_ID, e.FULL_NAME
                FROM EMPLOYEE e
                JOIN EMPLOYEE_ROLES er ON e.EMPLOYEE_ID = er.EMPLOYEE_ID
                WHERE er.ROLE_ID <> @AdminRoleID";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@AdminRoleID", 1);  // Exclude ROLE_ID = 1

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlAssignedTo.DataSource = dt;
                ddlAssignedTo.DataTextField = "FULL_NAME";
                ddlAssignedTo.DataValueField = "EMPLOYEE_ID";
                ddlAssignedTo.DataBind();

                ddlAssignedTo.Items.Insert(0, new ListItem("-- Select Employee --", ""));

                // Retain previously assigned employee
                if (!string.IsNullOrEmpty(assignedEmployeeId))
                {
                    ddlAssignedTo.SelectedValue = assignedEmployeeId;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading employees: " + ex.Message + "');</script>");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            try
            {
                // Validate and Convert Due Date
                DateTime dueDate;
                bool isValidDate = DateTime.TryParse(txtDueDate.Text, out dueDate);

                string updateQuery = @"
                    UPDATE TASK 
                    SET TASK_NAME = @TaskName, 
                        DESCRIPTION = @Description, 
                        DUE_DATE = @DueDate, 
                        STATUS = @Status, 
                        ASSIGN_TO = @AssignedTo 
                    WHERE TASK_ID = @TaskID";

                SqlCommand cmd = new SqlCommand(updateQuery, dbConn.con);
                cmd.Parameters.AddWithValue("@TaskName", txtTaskName.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtTaskDesc.Text.Trim());

                // Handle NULL due date
                if (isValidDate)
                {
                    cmd.Parameters.AddWithValue("@DueDate", dueDate);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DueDate", DBNull.Value);
                }

                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@AssignedTo", ddlAssignedTo.SelectedValue);
                cmd.Parameters.AddWithValue("@TaskID", hfTaskID.Value);

                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    // Show success alert and redirect after confirmation
                    Response.Write("<script>alert('Task updated successfully!'); window.location='AllTasks.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Task update failed!');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error updating task: " + ex.Message + "');</script>");
            }
        }
    }
}
