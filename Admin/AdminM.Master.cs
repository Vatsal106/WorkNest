using System;
using System.Data.SqlClient;

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
            if (!IsPostBack)
            {
                FetchEmployeeNameAndProfile();
            }
        }

        public void FetchEmployeeNameAndProfile()
        {
            dbConnection dbconn = new dbConnection();
            dbconn.dbConnect();

            try
            {
                if (Session["EmployeeID"] == null)
                {
                    lblFullName.Text = "Unknown!";
                    profilePhoto.ImageUrl = "~/Images/employee photo.png";
                }
                else
                {
                    int employeeId = Convert.ToInt32(Session["EmployeeID"]);
                    string query = "SELECT FULL_NAME, IMAGE FROM EMPLOYEE WHERE EMPLOYEE_ID = @EmployeeID";
                    SqlCommand cmd = new SqlCommand(query, dbconn.con);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string fullName = reader["FULL_NAME"].ToString();
                        byte[] photoData = reader["IMAGE"] as byte[];

                        lblFullName.Text = fullName;
                        if (photoData != null && photoData.Length > 0)
                        {
                            string base64Photo = Convert.ToBase64String(photoData);
                            profilePhoto.ImageUrl = "data:image/jpeg;base64," + base64Photo;
                        }
                        else
                        {
                            profilePhoto.ImageUrl = "~/Images/employee photo.jpg";
                        }
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                lblFullName.Text = "Error fetching data!";
                profilePhoto.ImageUrl = "~/Images/employee photo.jpg";
                Console.WriteLine("Error: " + ex.Message); // Logging error
            }
        }
    }
}
