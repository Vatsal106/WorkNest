using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class EmployeeDetails : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string employeeId = Request.QueryString["EmployeeID"];
                if (!string.IsNullOrEmpty(employeeId))
                {
                    LoadEmployeeDetails(employeeId);
                }
                else
                {
                    Response.Redirect("Employees.aspx");
                }
            }
        }

        private void LoadEmployeeDetails(string employeeId)
        {
            dbConn.dbConnect();
            try
            {
                string query = @"
                    SELECT e.FULL_NAME, e.EMAIL, e.PHONE_NUMBER, e.IMAGE, d.DEPARTMENT_NAME, r.ROLE_NAME
                    FROM EMPLOYEE e
                    JOIN DEPARTMENT d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
                    JOIN EMPLOYEE_ROLES er ON e.EMPLOYEE_ID = er.EMPLOYEE_ID
                    JOIN ROLES r ON er.ROLE_ID = r.ROLE_ID
                    WHERE e.EMPLOYEE_ID = @EmployeeID";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    employeeName.InnerText = reader["FULL_NAME"].ToString();
                    employeeEmail.InnerText = reader["EMAIL"].ToString();
                    employeePhone.InnerText = reader["PHONE_NUMBER"].ToString();
                    employeeDepartment.InnerText = reader["DEPARTMENT_NAME"].ToString();
                    employeeRole.InnerText = reader["ROLE_NAME"].ToString();

                    if (reader["IMAGE"] != DBNull.Value)
                    {
                        byte[] imageBytes = (byte[])reader["IMAGE"];
                        employeePhoto.Src = "data:image/png;base64," + Convert.ToBase64String(imageBytes);
                    }
                    else
                    {
                        employeePhoto.Src = "~/Images/employee photo.jpg";
                    }
                }
                reader.Close();
                cmd.Dispose();

                LoadEmployeeProjects(employeeId);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
        private void LoadEmployeeTasks(string employeeId)
        {
            try
            {
                string query = @"
            SELECT p.PROJECT_NAME, t.TASK_NAME, t.STATUS, t.DUE_DATE, t.TASK_ID
            FROM TASK t
            JOIN PROJECT p ON t.PROJECT_ID = p.PROJECT_ID
            WHERE t.ASSIGN_TO = @EmployeeID
            ORDER BY p.PROJECT_NAME, t.DUE_DATE";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dtTasks = new DataTable();
                da.Fill(dtTasks);

                rptTasks.DataSource = dtTasks.AsEnumerable()
                    .GroupBy(row => row["PROJECT_NAME"].ToString())
                    .Select(g => new
                    {
                        ProjectName = g.Key,
                        Tasks = g.CopyToDataTable()
                    }).ToList();

                rptTasks.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void btnDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string taskId = btn.CommandArgument;
            Response.Redirect("TaskDetails.aspx?TaskID=" + taskId);
        }

        private void LoadEmployeeProjects(string employeeId)
        {
            try
            {
                string query = @"
            SELECT PROJECT_ID, PROJECT_NAME, START_DATE, END_DATE 
            FROM PROJECT
            WHERE PROJECT_ID IN (
                SELECT DISTINCT PROJECT_ID FROM TASK WHERE ASSIGN_TO = @EmployeeID
            )";

                SqlCommand cmd = new SqlCommand(query, dbConn.con);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dtProjects = new DataTable();
                da.Fill(dtProjects);

                gvProjects.DataSource = dtProjects;
                gvProjects.DataBind();

                LoadEmployeeTasks(employeeId);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

    }
}