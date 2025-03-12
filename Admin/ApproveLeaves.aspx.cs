using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WorkNest.Admin
{
    public partial class ApproveLeaves : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjectManagerLeaves();
            }
        }

        private void LoadProjectManagerLeaves()
        {
            dbConn.dbConnect();
            try
            {
                string selectedStatus = ddlStatusFilter.SelectedValue;

                string query = @"
            SELECT LEAVES.LEAVE_ID, EMPLOYEE.FULL_NAME AS EMPLOYEE_NAME, LEAVES.START_DATE, LEAVES.END_DATE, 
                   LEAVES.REASON, LEAVES.STATUS
            FROM LEAVES
            INNER JOIN EMPLOYEE ON LEAVES.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID
            INNER JOIN EMPLOYEE_ROLES ON EMPLOYEE.EMPLOYEE_ID = EMPLOYEE_ROLES.EMPLOYEE_ID
            WHERE EMPLOYEE_ROLES.ROLE_ID = 2";
                if (selectedStatus != "All")
                {
                    query += " AND LEAVES.STATUS = @Status";
                }

                SqlCommand cmd = new SqlCommand(query, dbConn.con);

                if (selectedStatus != "All")
                {
                    cmd.Parameters.AddWithValue("@Status", selectedStatus);
                }

                SqlDataReader reader = cmd.ExecuteReader();
                gvProjectManagerLeaves.DataSource = reader;
                gvProjectManagerLeaves.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }


        protected void gvProjectManagerLeaves_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int leaveId = Convert.ToInt32(e.CommandArgument);
                string newStatus = e.CommandName == "Approve" ? "Approved" : "Rejected";

                dbConn.dbConnect();
                try
                {
                    string query = "UPDATE LEAVES SET STATUS = @Status WHERE LEAVE_ID = @LeaveID";
                    SqlCommand cmd = new SqlCommand(query, dbConn.con);
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@LeaveID", leaveId);

                    cmd.ExecuteNonQuery();
                    LoadProjectManagerLeaves();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProjectManagerLeaves();
        }
    }
}
