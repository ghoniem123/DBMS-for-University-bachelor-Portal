using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;

namespace milestone3_website
{
    public partial class book : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void bookbutton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(idbox.Text))
            {
                Response.Write("please ente the desired meeting id");
            }
            else
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

                int meetingid = int.Parse(idbox.Text);

                SqlCommand bookProc = new SqlCommand("BookMeeting", connection);
                bookProc.CommandType = System.Data.CommandType.StoredProcedure;
                bookProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));
                bookProc.Parameters.Add(new SqlParameter("@meetingID", meetingid));

                connection.Open();
                try
                {
                    bookProc.ExecuteNonQuery();
                }
                catch (Exception exp)
                {
                    Response.Write("you have already booked this meeting");
                }
                connection.Close();
            }
        }
    }
}