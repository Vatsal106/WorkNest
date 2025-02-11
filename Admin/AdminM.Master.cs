using System;

namespace WorkNest.Project_Manager
{
    public partial class AdminM : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
        }
    }
}