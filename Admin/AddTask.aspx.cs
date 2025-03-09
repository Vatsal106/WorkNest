using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class AddTask : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    LoadProjects();
                    LoadEmployees();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading page: " + ex.Message + "');</script>");
            }
        }

        private void LoadProjects()
        {
            try
            {
                dbConn.dbConnect();
                string query = "SELECT PROJECT_ID, PROJECT_NAME FROM PROJECT";
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                SqlDataReader reader = cmd.ExecuteReader();

                ddlProject.DataSource = reader;
                ddlProject.DataTextField = "PROJECT_NAME";
                ddlProject.DataValueField = "PROJECT_ID";
                ddlProject.DataBind();
                ddlProject.Items.Insert(0, new ListItem("-- Select Project --", ""));

                reader.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading projects: " + ex.Message + "');</script>");
            }
        }

        private void LoadEmployees()
        {
            try
            {
                dbConn.dbConnect();
                string query = @"
        SELECT E.EMPLOYEE_ID, E.FULL_NAME 
        FROM EMPLOYEE E
         JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID
         JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID
        WHERE R.ROLE_NAME = 'Project_Member'";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                SqlDataReader reader = cmd.ExecuteReader();

                ddlAssignTo.DataSource = reader;
                ddlAssignTo.DataTextField = "FULL_NAME";  
                ddlAssignTo.DataValueField = "EMPLOYEE_ID";
                ddlAssignTo.DataBind();
                ddlAssignTo.Items.Insert(0, new ListItem("-- Select Employee --", ""));

                reader.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading employees: " + ex.Message + "');</script>");
            }
        }



        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                dbConn.dbConnect();
                if (ddlProject.SelectedValue == "" || ddlAssignTo.SelectedValue == "")
                {
                    Response.Write("<script>alert('Please select Project and Employee.');</script>");
                    return;
                }

                string query = @"INSERT INTO TASK (TASK_NAME, PROJECT_ID, DESCRIPTION, START_DATE, DUE_DATE, STATUS, ASSIGN_TO) 
                                VALUES (@TaskName, @ProjectID, @Description, @StartDate, @DueDate, @Status, @AssignTo)";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@TaskName", txtTaskName.Text);
                cmd.Parameters.AddWithValue("@ProjectID", ddlProject.SelectedValue);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
                cmd.Parameters.AddWithValue("@DueDate", txtDueDate.Text);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@AssignTo", ddlAssignTo.SelectedValue);

                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Task added successfully!'); window.location='AllTasks.aspx';</script>");
                Response.Redirect("AllTasks.aspx");

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error adding task: " + ex.Message + "');</script>");
            }
        }
    }
}
