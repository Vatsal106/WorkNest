using System;

namespace WorkNest.Project_Manager
{
    public partial class AdminM : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/AccessDenied.aspx");
            }
        }
    }
}