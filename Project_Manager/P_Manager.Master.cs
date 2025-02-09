using System;

namespace WorkNest.Project_Manager
{
    public partial class P_Manager : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Project_Manager")
            {
                Response.Redirect("~/AccessDenied.aspx");
            }
        }

    }
}