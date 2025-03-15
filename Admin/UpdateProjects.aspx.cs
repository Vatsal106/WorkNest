using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class UpdateProjects : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["ProjectID"] != null)
                {
                    String projectId = Request.QueryString["ProjectID"];
                    hfProjectID.Value = projectId;
                    try
                    {
                        bindProjectManagerName();
                        bindClient();
                        LoadProjectDetails(projectId);
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = "⚠ Error loading project details: " + ex.Message;
                        lblError.ForeColor = Color.Red;
                    }
                }
                else
                {
                    Response.Redirect("Projects.aspx");
                }
            }
        }

        public void LoadProjectDetails(string projectId)
        {
            try
            {
                dbConn.dbConnect();
                string query = "SELECT PROJECT_NAME, DESCRIPTION, START_DATE, END_DATE, STATUS, PROJECT_MANAGER_ID, CLIENT_ID FROM PROJECT WHERE PROJECT_ID = @ProjectID";
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@ProjectID", projectId);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtProjectName.Text = dr["PROJECT_NAME"].ToString();
                    txtDescription.Text = dr["DESCRIPTION"].ToString();
                    txtStartDate.Text = Convert.ToDateTime(dr["START_DATE"]).ToString("yyyy-MM-dd");
                    txtEndDate.Text = Convert.ToDateTime(dr["END_DATE"]).ToString("yyyy-MM-dd");
                    ddlStatus.SelectedValue = dr["STATUS"].ToString();
                    ddlProjectManager.SelectedValue = dr["PROJECT_MANAGER_ID"].ToString();
                    ddlClient.SelectedValue = dr["CLIENT_ID"].ToString();
                }
                dr.Close();
            }
            catch (Exception ex)
            {
                lblError.Text = "⚠ Error loading project details: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        public void bindProjectManagerName()
        {
            try
            {
                dbConn.dbConnect();
                string query = @"
                               SELECT DISTINCT E.EMPLOYEE_ID, E.FULL_NAME 
                               FROM EMPLOYEE E 
                               JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID 
                               JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID 
                               WHERE R.ROLE_NAME ='Project_Manager'";
                SqlDataAdapter adpt = new SqlDataAdapter(query, dbConn.con);
                DataSet ds = new DataSet();
                adpt.Fill(ds);
                ddlProjectManager.DataSource = ds;
                ddlProjectManager.DataTextField = "FULL_NAME";
                ddlProjectManager.DataValueField = "EMPLOYEE_ID";
                ddlProjectManager.DataBind();
                ddlProjectManager.Items.Insert(0, new ListItem("--Select Project Manager--", "0"));
            }
            catch (Exception ex)
            {
                lblError.Text = "⚠ Error binding project managers: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        public void bindClient()
        {
            try
            {
                dbConn.dbConnect();
                string query = "SELECT * FROM CLIENTS";
                SqlDataAdapter adpt = new SqlDataAdapter(query, dbConn.con);
                DataSet ds = new DataSet();
                adpt.Fill(ds);
                ddlClient.DataSource = ds;
                ddlClient.DataTextField = "CLIENT_NAME";
                ddlClient.DataValueField = "CLIENT_ID";
                ddlClient.DataBind();
                ddlClient.Items.Insert(0, new ListItem("--Select Client--", "0"));
            }
            catch (Exception ex)
            {
                lblError.Text = "⚠ Error binding clients: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        public void btnUpdateProject_Click()
        {
            try
            {
                dbConn.dbConnect();
                string p_name = txtProjectName.Text;
                string desc = txtDescription.Text;
                string sDate = txtStartDate.Text;
                string eDate = txtEndDate.Text;
                string status = ddlStatus.SelectedItem.Value;
                int pId = Convert.ToInt32(ddlProjectManager.SelectedValue);
                int cId = Convert.ToInt32(ddlClient.SelectedValue);

                string query = "UPDATE PROJECT SET PROJECT_NAME=@p_name, DESCRIPTION=@desc, START_DATE=@sDate, END_DATE=@eDate, STATUS=@status, PROJECT_MANAGER_ID=@pid, CLIENT_ID=@cId WHERE PROJECT_ID=" + hfProjectID.Value;
                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@p_name", p_name);
                cmd.Parameters.AddWithValue("@desc", desc);
                cmd.Parameters.AddWithValue("@sDate", sDate);
                cmd.Parameters.AddWithValue("@eDate", eDate);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@pId", pId);
                cmd.Parameters.AddWithValue("@cId", cId);

                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    string queryRole = @"UPDATE Employee_roles 
                                    SET ROLE_ID = 2, assigned_date = @AssignedDate 
                                    WHERE employee_id = @pId";
                    SqlCommand cmdRole = new SqlCommand(queryRole, dbConn.con);
                    cmdRole.Parameters.AddWithValue("@pId", pId);
                    cmdRole.Parameters.AddWithValue("@AssignedDate", DateTime.Now.Date);

                    cmdRole.ExecuteNonQuery();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Project details updated successfully.');", true);
                    Response.Redirect("Projects.aspx");
                }
                else
                {
                    lblError.Text = "⚠ Something went wrong!";
                    lblError.ForeColor = Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "⚠ Error updating project: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        protected void ValidateProject(object sender, EventArgs e)
        {
            try
            {
                string projectName = txtProjectName.Text.Trim();
                string description = txtDescription.Text.Trim();
                string startDate = txtStartDate.Text;
                string endDate = txtEndDate.Text;
                string status = ddlStatus.SelectedValue;
                string projectManager = ddlProjectManager.SelectedValue;
                string client = ddlClient.SelectedValue;

                if (string.IsNullOrEmpty(projectName) || string.IsNullOrEmpty(description) ||
                    string.IsNullOrEmpty(startDate) || string.IsNullOrEmpty(endDate))
                {
                    lblError.Text = "⚠ All fields are required.";
                    lblError.ForeColor = Color.Red;
                    return;
                }

                DateTime start, end;
                if (!DateTime.TryParse(startDate, out start) || !DateTime.TryParse(endDate, out end))
                {
                    lblError.Text = "⚠ Invalid date format.";
                    lblError.ForeColor = Color.Red;
                    return;
                }

                if (start >= end)
                {
                    lblError.Text = "⚠ End Date must be after Start Date.";
                    lblError.ForeColor = Color.Red;
                    return;
                }

                if (status == "0" || projectManager == "0" || client == "0")
                {
                    lblError.Text = "⚠ Please select all dropdown values.";
                    lblError.ForeColor = Color.Red;
                    return;
                }

                lblError.Text = "";
                btnUpdateProject_Click();
                lblError.Text = "✔ Project updated successfully!";
                lblError.ForeColor = Color.Green;
            }
            catch (Exception ex)
            {
                lblError.Text = "⚠ Error validating project: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        public void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Projects.aspx");
        }
    }
}
