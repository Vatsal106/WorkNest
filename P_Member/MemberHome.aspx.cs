using System;
using System.Collections.Generic;

namespace WorkNest.P_Member
{
    public partial class MemberHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Project_Member")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
            if (!IsPostBack)
            {
                LoadProjectMemberTasks();
            }
        }
        private void LoadProjectMemberTasks()
        {
            var tasks = new List<object>
            {
                new { Title = "Assigned Tasks", Description = "View and manage your assigned project tasks." },
                new { Title = "Project Deadlines", Description = "Stay on top of upcoming deadlines and deliverables." },
                new { Title = "Task Progress", Description = "Update your task progress and report completion." },
                new { Title = "Team Collaboration", Description = "Communicate and collaborate with your team members." },
                new { Title = "Resource Access", Description = "Access project documents, guidelines, and tools." },
                new { Title = "Performance Metrics", Description = "Track your performance and receive feedback from managers." }
            };

            rptProjectMemberTasks.DataSource = tasks;
            rptProjectMemberTasks.DataBind();
        }
    }
}