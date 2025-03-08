using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
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
                        LoadTaskDetails(hfTaskID.Value);
                        LoadEmployees();
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

        private void LoadTaskDetails(string taskId)
        {
            dbConn.dbConnect();
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
                    ddlAssignedTo.SelectedValue = reader["ASSIGN_TO"].ToString();
                }
                reader.Close();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading task details: " + ex.Message + "');</script>");
            }
        }

        private void LoadEmployees()
        {
            dbConn.dbConnect();
            try
            {
                string query = "SELECT EMPLOYEE_ID, FULL_NAME FROM EMPLOYEE";
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlAssignedTo.DataSource = dt;
                ddlAssignedTo.DataTextField = "FULL_NAME";
                ddlAssignedTo.DataValueField = "EMPLOYEE_ID";
                ddlAssignedTo.DataBind();

                ddlAssignedTo.Items.Insert(0, new ListItem("-- Select Employee --", ""));
               
               
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
                cmd.Parameters.AddWithValue("@DueDate", txtDueDate.Text);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@AssignedTo", ddlAssignedTo.SelectedValue);
                cmd.Parameters.AddWithValue("@TaskID", hfTaskID.Value);

                int rowsAffected = cmd.ExecuteNonQuery();
                

                if (rowsAffected > 0)
                {
                    Response.Redirect("AllTasks.aspx");
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
