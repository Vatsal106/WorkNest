using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class changeRoles : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
            if (!IsPostBack)
            {
                bindNames();
                bindRoles();


            }
        }
        public void bindNames()
        {
            dbConn.dbConnect();
            string query = "SELECT * FROM EMPLOYEE E JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID WHERE R.ROLE_NAME != 'Admin'";
            SqlDataAdapter adpt = new SqlDataAdapter(query, dbConn.con);
            DataSet ds = new DataSet();
            adpt.Fill(ds);
            ddlName.DataSource = ds;
            ddlName.DataTextField = "FULL_NAME";
            ddlName.DataValueField = "EMPLOYEE_ID";
            ddlName.DataBind();
            ddlName.Items.Insert(0, new ListItem("--Select Name--", "0"));
        }

        protected void bindCurrentRole(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            int roleId = Convert.ToInt32(ddlName.SelectedValue);
            string query = "SELECT R.ROLE_NAME FROM EMPLOYEE E JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID WHERE E.EMPLOYEE_ID = @EmployeeId";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@EmployeeId", roleId);
            object result = cmd.ExecuteScalar();
            if (result != null)
            {
                txtCurrentRole.Text = result.ToString();
            }
            else
            {
                txtCurrentRole.Text = "No role assigned";
            }
        }

        public void bindRoles()
        {
            dbConn.dbConnect();
            string query = "SELECT * FROM ROLES WHERE ROLE_NAME != 'Admin'";
            SqlDataAdapter adpt = new SqlDataAdapter(query, dbConn.con);
            DataSet ds = new DataSet();
            adpt.Fill(ds);
            ddlChangedRole.DataSource = ds;
            ddlChangedRole.DataTextField = "ROLE_NAME";
            ddlChangedRole.DataValueField = "ROLE_ID";
            ddlChangedRole.DataBind();
            ddlChangedRole.Items.Insert(0, new ListItem("--Select Role--", "0"));
        }

        protected void btnUpdateRole_Click(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            int empId = Convert.ToInt32(ddlName.SelectedValue);
            int roleId = Convert.ToInt32(ddlChangedRole.SelectedValue);
            string query = "UPDATE EMPLOYEE_ROLES SET ROLE_ID = @RoleId WHERE EMPLOYEE_ID = @EmpId";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@RoleId", roleId);
            cmd.Parameters.AddWithValue("@EmpId", empId);
            int rowsAffected = cmd.ExecuteNonQuery();

            if (rowsAffected > 0)
            {
                lblMessage.Text = "Role updated successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.Text = "Employee role update failed. Employee might not exist.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlName.SelectedIndex = 0;
            txtCurrentRole.Text = string.Empty;
            ddlChangedRole.SelectedIndex = 0;
            lblMessage.Text = "";

        }

        
    }
}