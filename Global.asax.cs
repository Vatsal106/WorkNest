using System;
using System.Web.UI;

namespace WorkNest
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition(
       "jquery",
       new ScriptResourceDefinition
       {
           Path = "~/Scripts/jquery-3.6.0.min.js", // Adjust the path if using CDN or a different folder
           DebugPath = "~/Scripts/jquery-3.6.0.js",
           CdnPath = "https://code.jquery.com/jquery-3.6.0.min.js",
           CdnDebugPath = "https://code.jquery.com/jquery-3.6.0.js",
           CdnSupportsSecureConnection = true
       });
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}