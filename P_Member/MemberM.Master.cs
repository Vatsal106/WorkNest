using System;

namespace WorkNest.P_Member
{
    public partial class MemberM : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Project_Member")
            {
                Response.Redirect("~/AccessDenied.aspx");
            }
        }
    }
}