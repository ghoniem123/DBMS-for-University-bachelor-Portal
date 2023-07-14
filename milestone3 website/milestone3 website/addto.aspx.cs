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
    public partial class addto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void addbutton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(idbox.Text) || string.IsNullOrWhiteSpace(todobox.Text))
            {
                Response.Write("please fill all fields");
            }
            else
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

                int id = int.Parse(idbox.Text);
                string todo = todobox.Text;

                SqlCommand AddProc = new SqlCommand("StudentAddToDo", connection);
                AddProc.CommandType = System.Data.CommandType.StoredProcedure;
                AddProc.Parameters.Add(new SqlParameter("@meetingID", id));
                AddProc.Parameters.Add(new SqlParameter("@ToDoList", todo));

                connection.Open();
                AddProc.ExecuteNonQuery();
                connection.Close();
            }
        }
    }
}