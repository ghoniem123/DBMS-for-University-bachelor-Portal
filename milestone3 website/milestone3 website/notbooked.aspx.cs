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
    public partial class notbooked : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);
            SqlCommand notbookedProc = new SqlCommand("ViewNotBookedMeetings", connection);
            notbookedProc.CommandType = System.Data.CommandType.StoredProcedure;
            notbookedProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));

            string meetingsdetails = "All meetings are booked ";

            connection.Open();
            SqlDataReader read = notbookedProc.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (read.Read())
            {

                if (meetingsdetails.Equals("All meetings are booked "))
                    meetingsdetails = "";

                meetingsdetails += "- Meeting ID : " + (read.IsDBNull(0) ? "empty" : read.GetValue(0).ToString()) + "," + "\x0A "
                    + "- The meeting lecturer id : " + (read.IsDBNull(1) ? "empty" : read.GetValue(1).ToString()) + "," + "\x0A "
                    + "- Start time: " + (read.IsDBNull(2) ? "empty" : read.GetValue(2).ToString()) + "," + "\x0A "
                    + "- End time : " + (read.IsDBNull(3) ? "empty" : read.GetValue(3).ToString()) + "," + "\x0A " 
                    + " - Duration : " + (read.IsDBNull(4) ? "empty" : read.GetValue(4).ToString()) + " minutes " + "," + "\x0A "
                    + " - Date : " + (read.IsDBNull(5) ? "empty" : read.GetValue(5).ToString()) + "," 
                    + "\x0A " + " - Meeting point : " + (read.IsDBNull(6) ? "empty" : read.GetString(6)) + "<br/>"+"<br/>";

               
            }
            Label meetingdata = new Label();
            meetingdata.Text = meetingsdetails;
            form1.Controls.Add(meetingdata);
        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
    }
}