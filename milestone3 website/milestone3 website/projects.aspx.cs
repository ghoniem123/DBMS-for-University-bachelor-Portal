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
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

        }

        protected void profilebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("profile.aspx");
        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void viewbutton_Click(object sender, EventArgs e)
        {
            int id = 0;

            if (String.IsNullOrEmpty(idbox.Text))
            {
                id = -1;
            }
            else
            {
                id = int.Parse(idbox.Text);
            }

            string type = typelist.SelectedItem.Value;

            if (type.Equals("Both"))
            {
                type = "";
            }

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);
            SqlCommand projectProc = new SqlCommand("ViewBachelorProjects", connection);
            projectProc.CommandType = System.Data.CommandType.StoredProcedure;
            projectProc.Parameters.Add(new SqlParameter("@projectType", type));
            projectProc.Parameters.Add(new SqlParameter("@userID", id));

            string projectdetails = "No projects yet";

            connection.Open();
            SqlDataReader read = projectProc.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (read.Read())
            {
                if (projectdetails.Equals("No projects yet"))
                {
                    projectdetails = "";
                }

                 projectdetails += "- project code : " + (read.IsDBNull(0) ? "empty" : read.GetString(0)) + "," + "\x0A " + " - Project name : " + (read.IsDBNull(1) ? "empty" : read.GetValue(1).ToString()) + "," + "\x0A "
                    + " - project submitted material : " + (read.IsDBNull(2) ? "empty" : read.GetValue(2).ToString()) + "," + "\x0A " + " - project description : " + (read.IsDBNull(3) ? "empty" : read.GetValue(3).ToString()) + "<br/>" + "<br/>";

               
            }
            Label projectdata = new Label();
            projectdata.Text = projectdetails;
            form1.Controls.Add(projectdata);
        }
    }
}