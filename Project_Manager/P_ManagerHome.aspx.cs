using System;
using System.Collections.Generic;

namespace WorkNest.Project_Manager
{
    public partial class P_ManagerHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Project_Manager")
            {
                Response.Redirect("~/AccessDenied.aspx");
            }
            if (!IsPostBack)
            {
                LoadFunctionalities();
            }
        }
        public void LoadFunctionalities()
        {
            var functionalities = new List<object>
            {
                new { Title = "View Assigned Projects", Description = "Overview of all projects assigned to you." },
                new { Title = "Task Allocation", Description = "Assign tasks to team members and set deadlines." },
                new { Title = "Monitor Progress", Description = "Track the progress of each project and tasks." },
                new { Title = "Team Communication", Description = "Interact with team members and stakeholders." },
                new { Title = "Generate Reports", Description = "Create detailed reports on project status and team performance." },
                new { Title = "Manage Resources", Description = "Allocate resources effectively to ensure project success." },
                new { Title = "Approve Leave Requests", Description = "Review and approve leave requests from team members." },
                new { Title = "Project Budgeting", Description = "Manage project budgets and track expenses." }
            };

            rptFunctionalities.DataSource = functionalities;
            rptFunctionalities.DataBind();

        }
    }
}