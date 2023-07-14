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
    public partial class thesisview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void enterbutton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(titlebox.Text))
            {
                Response.Write("please enter the thesis title to view it");
            }
            else
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

                string title = titlebox.Text;

                SqlCommand viewproc = new SqlCommand("ViewMyThesis", connection);
                viewproc.CommandType = System.Data.CommandType.StoredProcedure;
                viewproc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));
                viewproc.Parameters.Add(new SqlParameter("@title", title));

                string thesisdetails = "No thesis is found";

                connection.Open();
                SqlDataReader read = viewproc.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                while (read.Read())
                {
                    if (thesisdetails.Equals("No thesis is found"))

                     thesisdetails += "- Title : " + (read.IsDBNull(1) ? "empty" : read.GetValue(1).ToString()) + "," + "\x0A " + " - Deadline : " + (read.IsDBNull(2) ? "empty" : read.GetValue(2).ToString()) + "," + "\x0A "
                        + " - pdf document : " + (read.IsDBNull(3) ? "empty" : read.GetValue(3).ToString()) + "," + "\x0A " + " - total grade: " + (read.IsDBNull(4) ? "empty" : read.GetValue(4).ToString()) + "<br/>";

      
                }
                Label thesisdata = new Label();
                thesisdata.Text = thesisdetails;
                form1.Controls.Add(thesisdata);
            }
        }
    }
}