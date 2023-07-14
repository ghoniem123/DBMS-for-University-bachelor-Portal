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
    public partial class thesissubmit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void submitbutton_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(titlebox.Text) || string.IsNullOrWhiteSpace(pdfbox.Text))
            {
                Response.Write("please fill all the fields");
            }
            else
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

                string title = titlebox.Text;
                string pdf = pdfbox.Text;

                SqlCommand submitthesisproc = new SqlCommand("SubmitMyThesis", connection);
                submitthesisproc.CommandType = System.Data.CommandType.StoredProcedure;
                submitthesisproc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));
                submitthesisproc.Parameters.Add(new SqlParameter("@title", title));
                submitthesisproc.Parameters.Add(new SqlParameter("@PDFDocument", pdf));

                connection.Open();
                submitthesisproc.ExecuteNonQuery();
                connection.Close();
            }
        }
    }
}