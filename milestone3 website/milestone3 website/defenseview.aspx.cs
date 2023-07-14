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
    public partial class defenseview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);
            SqlCommand viewdefenseProc = new SqlCommand("ViewMyDefense", connection);
            viewdefenseProc.CommandType = System.Data.CommandType.StoredProcedure;
            viewdefenseProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));

            string defensedetails="no defense was found";

            connection.Open();
            SqlDataReader read = viewdefenseProc.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (read.Read())
            {

                defensedetails = "- Defense location : " + (read.IsDBNull(1) ? "empty" : read.GetString(1)) + "," + "\x0A " 
                    + " - Content : " + (read.IsDBNull(2) ? "empty" : read.GetString(2)) + "," + "\x0A "
                    + " - Defense time : " + (read.IsDBNull(3) ? "empty" : read.GetValue(3).ToString()) + "," 
                    + "\x0A " + " - Defense date : " + (read.IsDBNull(4) ? "empty" : read.GetValue(4).ToString()) + ","
                    + "\x0A " + " - total grade : " + (read.IsDBNull(5) ? "empty" : read.GetValue(5).ToString()) + "<br/>";

              
            }
            Label defensedata = new Label();
            defensedata.Text = defensedetails;
            defenseform.Controls.Add(defensedata);
        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
    }
}