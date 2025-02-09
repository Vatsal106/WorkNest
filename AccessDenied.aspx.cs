using System;

namespace WorkNest
{
    public partial class AccessDenied : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();   // Clear all session data
            Session.Abandon();
        }
    }
}