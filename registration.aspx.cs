using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;

namespace WorkNest
{
    public partial class registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=LAPTOP-C6B669RO;Initial Catalog=WORKNEST;Integrated Security=True";
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            string username = txtName.Text;
            string password = txtPassword.Text;
            string query = ("INSERT INTO LOGINTABLE(USERNAME , PASSWORD) VALUES('"+username+"','"+password+"');");
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.ExecuteNonQuery();
            conn.Close();
            
        }
    }
}