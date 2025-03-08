using System;
using System.Collections.Generic;

namespace WorkNest.Admin
{
    public partial class AdminHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
                //{
                //    Response.Redirect("~/AccessDenied.aspx");
                //}
                if (!IsPostBack)
                {
                    LoadFunctionalities();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in Page_Load: " + ex.Message);
            }
        }

        public void LoadFunctionalities()
        {
            try
            {
                var functionalities = new List<object>
                {
                    new { Title = "Project Management", Description = "Create, update, and track project progress." },
                    new { Title = "Employee Management", Description = "Manage employees, track attendance, and performance." },
                    new { Title = "Task Management", Description = "Assign tasks, set deadlines, and monitor completion." },
                    new { Title = "Reports & Analytics", Description = "View detailed reports on projects and employees." },
                    new { Title = "User Roles & Permissions", Description = "Control access levels for different user roles." },
                    new { Title = "Notifications & Alerts", Description = "Receive important updates on approvals and deadlines." }
                };

                rptfunctionalities.DataSource = functionalities;
                rptfunctionalities.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in LoadFunctionalities: " + ex.Message);
            }
        }
    }
}
