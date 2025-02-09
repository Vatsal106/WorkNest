using System;

namespace WorkNest.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["Role"] == null || Session["UserRole"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
        }
    }
}