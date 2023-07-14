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
    public partial class projectpreference : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void confimbutton_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(codebox.Text) || string.IsNullOrWhiteSpace(preferencebox.Text))
            {
                Response.Write(" Fill all the fields please to be able to make a preference for a project");
            }
            else
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

                string code = codebox.Text;
                int number = int.Parse(preferencebox.Text);


                SqlCommand preferenceProc = new SqlCommand("MakePreferencesLocalProject", connection);
                preferenceProc.CommandType = System.Data.CommandType.StoredProcedure;
                preferenceProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));
                preferenceProc.Parameters.Add(new SqlParameter("@bachelorCode", code));
                preferenceProc.Parameters.Add(new SqlParameter("@preferenceNumber", number));


                connection.Open();
                try
                {
                    preferenceProc.ExecuteNonQuery();
                }catch(Exception exp)
                {
                    Response.Write(" You only make preference for a project only once ");
                    return;
                }
                connection.Close();
            }
        }
    }
}