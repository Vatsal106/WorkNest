using System;

namespace WorkNest
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeID"] != null)
                {
                    Session.Clear();
                    Session.Abandon();
                    Response.Redirect("~/Login.aspx");
                }
                else
                {
                    Response.Redirect("~/Login.aspx");

                }
            }
        }
    }
}