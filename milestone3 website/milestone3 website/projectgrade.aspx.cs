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
    public partial class projectgrade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);
            SqlCommand gradeProc = new SqlCommand("ViewMyBachelorProjectGrade", connection);
            gradeProc.CommandType = System.Data.CommandType.StoredProcedure;
            gradeProc.Parameters.Add(new SqlParameter("@sid", Session["userid"]));

            SqlParameter grade = gradeProc.Parameters.Add("@BachelorGrade", System.Data.SqlDbType.Float);

            grade.Direction = System.Data.ParameterDirection.Output;

            connection.Open();
            gradeProc.ExecuteNonQuery();
            connection.Close();

            string check = grade.Value.ToString();

            string gradedetail = ( String.IsNullOrEmpty(check) )? "not graded yet" : "your bachelor project grade is " + grade.Value;


                Label gradedata = new Label();
                gradedata.Text = gradedetail;
                form1.Controls.Add(gradedata);
            
        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");

        }
    }
}