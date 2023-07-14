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
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);
            SqlCommand profileProc = new SqlCommand("ViewProfile", connection);
            profileProc.CommandType = System.Data.CommandType.StoredProcedure;
            profileProc.Parameters.Add(new SqlParameter("@ID", Session["userid"]));

            connection.Open();
            SqlDataReader read = profileProc.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (read.Read())
            {

                string id = "your id : " + (read.IsDBNull(0) ? "empty" : read.GetValue(0).ToString());
                string username = "your username : " + (read.IsDBNull(1) ? "empty" : read.GetString(1));
                string pass = "your password : " + (read.IsDBNull(2) ? "empty" : read.GetString(2));
                string email = "your email : " + (read.IsDBNull(3) ? "empty" : read.GetString(3));
                string userrole = "your role is : " + (read.IsDBNull(4) ? "empty" : read.GetString(4));
                string phone = "your phone number : " + (read.IsDBNull(5) ? "empty" : read.GetString(5));

                Label idlabel = new Label();
                Label usernamelabel = new Label();
                Label passlabel = new Label();
                Label emaillabel = new Label();
                Label userrolelabel = new Label();
                Label phonelabel = new Label();
                idlabel.Text = id +"<br/>";
                usernamelabel.Text = username +"<br/>";
                passlabel.Text = pass+ "<br/>";
                emaillabel.Text = email + "<br/>";
                userrolelabel.Text = userrole + "<br/>";
                phonelabel.Text = phone + "<br/>";

                form1.Controls.Add(idlabel);
                form1.Controls.Add(usernamelabel);
                form1.Controls.Add(passlabel);
                form1.Controls.Add(emaillabel);
                form1.Controls.Add(userrolelabel);
                form1.Controls.Add(phonelabel);
            }

        }

        protected void homewindow_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void viewprojects1_Click(object sender, EventArgs e)
        {
            Response.Redirect("projects.aspx");
        }
    }
}