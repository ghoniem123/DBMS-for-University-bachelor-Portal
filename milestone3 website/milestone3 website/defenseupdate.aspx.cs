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
    public partial class defenseupdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void updatebutton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(contentbox.Text))
            {
                Response.Write("please enter the content ");
            }
            else
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

                string content = contentbox.Text;

                SqlCommand updatedefnseProc = new SqlCommand("UpdateMyDefense", connection);
                updatedefnseProc.CommandType = System.Data.CommandType.StoredProcedure;
                updatedefnseProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));
                updatedefnseProc.Parameters.Add(new SqlParameter("@defenseContent", content));

                connection.Open();
                updatedefnseProc.ExecuteNonQuery();
                connection.Close();
            }
        }
    }
}