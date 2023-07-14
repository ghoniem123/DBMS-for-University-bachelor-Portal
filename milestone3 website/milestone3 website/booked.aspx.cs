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
    public partial class booked : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void viewbutton_Click(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

            int meetingid;

            if (String.IsNullOrWhiteSpace(idbox.Text))
            {
                 meetingid = -500;
            }
            else
            {
                 meetingid = int.Parse(idbox.Text);
            }

            SqlCommand viewProc = new SqlCommand("ViewMeeting", connection);
            viewProc.CommandType = System.Data.CommandType.StoredProcedure;
            viewProc.Parameters.Add(new SqlParameter("@meetingID", meetingid));
            viewProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));

            string bookedmeetings = "Meeting is not booked";

            connection.Open();
            SqlDataReader read = viewProc.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (read.Read())
            {
                if (bookedmeetings.Equals("Meeting is not booked"))
                    bookedmeetings = "";

                bookedmeetings += "- Meeting ID : " + (read.IsDBNull(0) ? "empty" : read.GetValue(0).ToString()) + "," + "\x0A "
                    + "- The meeting lecturer id : " + (read.IsDBNull(1) ? "empty" : read.GetValue(1).ToString()) + "," + "\x0A "
                    + "- Start time: " + (read.IsDBNull(2) ? "empty" : read.GetValue(2).ToString()) + "," + "\x0A "
                    + "- End time : " + (read.IsDBNull(3) ? "empty" : read.GetValue(3).ToString()) + "," + "\x0A "
                    + " - Duration : " + (read.IsDBNull(4) ? "empty" : read.GetValue(4).ToString())+" minutes " + "," + "\x0A "
                    + " - Date : " + (read.IsDBNull(5) ? "empty" : read.GetValue(5).ToString()) + ","
                    + "\x0A " + " - Meeting point : " + (read.IsDBNull(6) ? "empty" : read.GetString(6))
                    + " - To do list : " + (read.IsDBNull(8) ? "empty" : read.GetString(8)) + "<br/>"+"<br/>";
            }
            Label meetingdata = new Label();
            meetingdata.Text = bookedmeetings;
            form1.Controls.Add(meetingdata);
        }
    }
}