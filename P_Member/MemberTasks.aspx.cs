﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkNest.P_Member
{
    public partial class MemberTasks : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                LoadProjectTasks("");
            }
        }

        private void LoadProjectTasks(string searchKeyword)
        {
            dbConn.dbConnect();

            try
            {
                // Retrieve logged-in Project Manager ID
                string MemberID = Session["EmployeeID"]?.ToString();

                if (string.IsNullOrEmpty(MemberID))
                {
                    lblErrorTask.Text = "Error: Employee ID not found.";
                    return;
                }

                string projectQuery = @"
                SELECT DISTINCT P.PROJECT_ID, P.PROJECT_NAME 
                FROM PROJECT P
                INNER JOIN TASK T ON P.PROJECT_ID = T.PROJECT_ID
                WHERE T.ASSIGN_TO = @EmployeeID
                AND (P.PROJECT_NAME LIKE @Search OR T.TASK_NAME LIKE @Search)";

                SqlDataAdapter da = new SqlDataAdapter(projectQuery, dbConn.con);
                da.SelectCommand.Parameters.AddWithValue("@EmployeeID", MemberID);
                da.SelectCommand.Parameters.AddWithValue("@Search", "%" + searchKeyword + "%");

                DataTable dtProjects = new DataTable();
                da.Fill(dtProjects);

                rptProjects.DataSource = dtProjects;
                rptProjects.DataBind();


            }
            catch (Exception ex)
            {
                lblErrorTask.Text = "Error loading project tasks!" + ex.Message;

            }
        }


        protected void rptProjects_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    string projectId = DataBinder.Eval(e.Item.DataItem, "PROJECT_ID").ToString();
                    GridView gv = (GridView)e.Item.FindControl("gvTaskReports");

                    // Retrieve logged-in Project Manager ID
                    string managerID = Session["EmployeeID"]?.ToString();
                    if (string.IsNullOrEmpty(managerID))
                    {
                        Console.WriteLine("Error: Employee ID not found.");
                        return;
                    }

                    string taskQuery = @"
                    SELECT T.TASK_ID, T.TASK_NAME, 
                           T.DESCRIPTION AS TASK_DESC, 
                           T.START_DATE, T.DUE_DATE, T.STATUS, 
                           E.FULL_NAME AS ASSIGN_TO, 
                           ISNULL(TR.LAST_UPDATE, T.START_DATE) AS LAST_UPDATE
                    FROM TASK T
                    LEFT JOIN TASK_REPORT TR ON T.TASK_ID = TR.TASK_ID
                    INNER JOIN EMPLOYEE E ON T.ASSIGN_TO = E.EMPLOYEE_ID
                    WHERE T.PROJECT_ID = @ProjectID
                    AND T.ASSIGN_TO = @EmployeeID";

                    SqlDataAdapter da = new SqlDataAdapter(taskQuery, dbConn.con);
                    da.SelectCommand.Parameters.AddWithValue("@ProjectID", projectId);
                    da.SelectCommand.Parameters.AddWithValue("@EmployeeID", managerID);

                    DataTable dtTasks = new DataTable();
                    da.Fill(dtTasks);

                    gv.DataSource = dtTasks;
                    gv.DataBind();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }


        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            try
            {
                LoadProjectTasks(txtSearch.Text.Trim());
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
