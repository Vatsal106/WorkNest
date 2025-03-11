using System;
using System.IO;
using System.Web;

namespace WorkNest.Admin
{
    public partial class DownloadFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["file"]))
            {
                string fileName = Request.QueryString["file"];
                string filePath = Server.MapPath("~/Uploads/" + fileName);

                if (File.Exists(filePath))
                {
                    Response.Clear();
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
                    Response.TransmitFile(filePath);
                    Response.End();
                }
                else
                {
                    Response.Write("<script>alert('File not found!'); window.history.back();</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Invalid file request!'); window.history.back();</script>");
            }
        }
    }
}
