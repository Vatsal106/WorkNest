using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class addProject : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindProjectManagerName();
                bindClient();
                bindStatus();
            }
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/AccessDenied.aspx");
            }
        }
        public void bindProjectManagerName()
        {
            dbConn.dbConnect();
            string query = "SELECT E.EMPLOYEE_ID,E.FULL_NAME FROM EMPLOYEE E JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID WHERE ROLE_NAME = 'Project Manager'";
            SqlDataAdapter adpt = new SqlDataAdapter(query,dbConn.con);
            DataSet ds = new DataSet();
            adpt.Fill(ds);
            ddlProjectManager.DataSource = ds;
            ddlProjectManager.DataTextField = "FULL_NAME";
            ddlProjectManager.DataValueField = "EMPLOYEE_ID";
            ddlProjectManager.DataBind();
            ddlProjectManager.Items.Insert(0, new ListItem("--Select Project Manager--", "0"));
        }
        public void bindClient()
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
        public void bindStatus()
        {
            dbConn.dbConnect();
            ddlStatus.Items.Insert(0, new ListItem("--Select Status--", "0"));
            ddlStatus.Items.Insert(1, new ListItem("HOLD", "1"));
            ddlStatus.Items.Insert(2, new ListItem("IN PROGRESS", "2"));
            ddlStatus.Items.Insert(3, new ListItem("COMPLETED", "3"));

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            string p_name = txtProjectName.Text;
            string desc = txtDesc.Text;
            string sDate = dateStart.Text;
            string eDate = dateEnd.Text;
            string status = ddlStatus.SelectedItem.Text;
            int pId = Convert.ToInt32( ddlProjectManager.SelectedValue);
            int cId = Convert.ToInt32(ddlClient.SelectedValue);
            string query = "INSERT INTO PROJECT (PROJECT_NAME,DESCRIPTION,START_DATE,END_DATE,STATUS,PROJECT_MANAGER_ID,CLIENT_ID) VALUES(@p_name,@desc,@sDate,@eDate,@status,@pId,@cId)";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@p_name",p_name);
            cmd.Parameters.AddWithValue("@desc", desc);
            cmd.Parameters.AddWithValue("@sDate", sDate);
            cmd.Parameters.AddWithValue("@eDate", eDate);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@pId", pId);
            cmd.Parameters.AddWithValue("@cId", cId);
            object project = cmd.ExecuteNonQuery();
            if (project!=null)
            {
                lblError.Text = "Project added!!";
                lblError.ForeColor = Color.Green;
            }
            else
            {
                lblError.Text = "Project Not added!!";
                lblError.ForeColor = Color.Red;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
             txtProjectName.Text = string.Empty;
            txtDesc.Text = string.Empty;
            dateStart.Text = string.Empty;
            dateEnd.Text = string.Empty;
            ddlStatus.SelectedIndex = 0;
            ddlProjectManager.SelectedIndex = 0;
            ddlClient.SelectedIndex = 0;
        }
    }
}