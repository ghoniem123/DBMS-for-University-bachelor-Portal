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
    public partial class progressreport : System.Web.UI.Page
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
            if (!string.IsNullOrWhiteSpace(datebox.Text)  && (datebox.Text.Length != 10 || datebox.Text[4].CompareTo('/') != 0 || datebox.Text[7].CompareTo('/') != 0)  ) {

          
                Response.Write("please enter the date in the specified format");

            } else {
                string prr = "9999/12/31";

                DateTime prdate = DateTime.Parse(prr);

                if (!string.IsNullOrWhiteSpace(datebox.Text))
                {
                    try
                    {
                        prdate = DateTime.Parse(datebox.Text);
                    }catch (Exception exp)
                    {
                    
                        Response.Write("please enter the date in the specified format");
                        return;
                    }
                }


                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);
                SqlCommand prProc = new SqlCommand("ViewMyProgressReport", connection);
                prProc.CommandType = System.Data.CommandType.StoredProcedure;
                prProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));
                prProc.Parameters.Add(new SqlParameter("@date", prdate));

                string prdetails = "No progress reports ";

                connection.Open();
                SqlDataReader read = prProc.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                while (read.Read())
                {
                    if (prdetails.Equals("No progress reports "))
                    {
                        prdetails = "";
                    }

                    prdetails += "- report date : " + (read.IsDBNull(1) ? "empty" : read.GetValue(1).ToString()) + "," + "\x0A " +
                        " - Content : " + (read.IsDBNull(2) ? "empty" : read.GetValue(2).ToString()) + "," + "\x0A "
                       + " - Grade : " + (read.IsDBNull(3) ? "empty" : read.GetValue(3).ToString()) + "," + "\x0A "
                       + " - Updating user id : " + (read.IsDBNull(4) ? "empty" : read.GetValue(4).ToString()) + "," + "\x0A "
                       + " - Comulative grade : " + (read.IsDBNull(5) ? "empty" : read.GetValue(5).ToString()) + "<br/>" + "<br/>";


                }
                Label prdata = new Label();
                prdata.Text = prdetails;
                form1.Controls.Add(prdata);
            }
        }
        }
    }
