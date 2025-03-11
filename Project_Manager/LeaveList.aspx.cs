using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.Project_Manager
{
    public partial class LeaveList : Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLeaveRequests();
            }
        }

        private void LoadLeaveRequests()
        {
            dbConn.dbConnect();
            string statusFilter = ddlStatusFilter.SelectedValue;
            string query = @"
        SELECT L.LEAVE_ID, 
       E.FULL_NAME AS EMPLOYEE_NAME, 
       L.LEAVE_TYPE, 
       L.START_DATE, 
       L.END_DATE, 
       L.REASON, 
       L.STATUS 
        FROM LEAVES L 
        JOIN EMPLOYEE E ON L.EMPLOYEE_ID = E.EMPLOYEE_ID
        JOIN EMPLOYEE_ROLES ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID
        JOIN ROLES R ON ER.ROLE_ID = R.ROLE_ID
        WHERE R.ROLE_NAME = 'Project_Member'";

            if (statusFilter != "All")
            {
                query += " AND L.STATUS = @Status";
            }

            SqlCommand cmd = new SqlCommand(query, dbConn.con);

            if (statusFilter != "All")
            {
                cmd.Parameters.AddWithValue("@Status", statusFilter);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvLeaveRequests.DataSource = dt;
            gvLeaveRequests.DataBind();

            cmd.Dispose();
            da.Dispose();
        }



        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadLeaveRequests();
        }

        protected void gvLeaveRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int leaveId = Convert.ToInt32(e.CommandArgument);
                string newStatus = e.CommandName == "Approve" ? "Approved" : "Rejected";

                dbConn.dbConnect();
                string query = "UPDATE LEAVES SET STATUS = @Status WHERE LEAVE_ID = @LeaveId";

                using (SqlCommand cmd = new SqlCommand(query, dbConn.con))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@LeaveId", leaveId);
                    cmd.ExecuteNonQuery();
                }

                LoadLeaveRequests(); 
            }
        }
    }
}
