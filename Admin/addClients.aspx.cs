using System;
using System.Data.SqlClient;
using System.Drawing;

namespace WorkNest.Admin
{
    public partial class addClients : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/AccessDenied.aspx");
            //}
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            dbConn.dbConnect();
            string cName = txtClientName.Text;
            string email = txtEmail.Text;
            string phone_number = txtPhoneNumber.Text;
            string company_name = txtCompanyName.Text;
            string address = txtAddress.Text;
            string query = "INSERT INTO CLIENTS(CLIENT_NAME,EMAIL,PHONE_NUMBER,COMPANY_NAME,ADDRESS) VALUES(@NAME,@EMAIL,@NUMBER,@COMPANY_NAME,@ADDRESS)";
            SqlCommand cmd = new SqlCommand(query, dbConn.con);
            cmd.Parameters.AddWithValue("@NAME", cName);
            cmd.Parameters.AddWithValue("@EMAIL", email);
            cmd.Parameters.AddWithValue("@NUMBER", phone_number);
            cmd.Parameters.AddWithValue("@COMPANY_NAME", company_name);
            cmd.Parameters.AddWithValue("@address", address);
            int rowaffected = cmd.ExecuteNonQuery();
            if (rowaffected > 0)
            {
                lblError.Text = "Client added successfully!";
                lblError.ForeColor = Color.Green;
            }
            else
            {
                lblError.Text = "Client Not added!";
                lblError.ForeColor = Color.Red;
            }
        }

    }
}