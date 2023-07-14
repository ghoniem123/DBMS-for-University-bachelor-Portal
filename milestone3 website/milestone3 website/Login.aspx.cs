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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginbutton_Click(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

            string email = idbox.Text;
            string pass = passbox.Text;

            SqlCommand LoginProc = new SqlCommand("UserLogin", connection);
            LoginProc.CommandType = System.Data.CommandType.StoredProcedure;
            LoginProc.Parameters.Add(new SqlParameter("@email", email));
            LoginProc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = LoginProc.Parameters.Add("@success", System.Data.SqlDbType.Bit);
            SqlParameter id = LoginProc.Parameters.Add("@ID", System.Data.SqlDbType.Int);

            success.Direction = System.Data.ParameterDirection.Output;
            id.Direction = System.Data.ParameterDirection.Output;

            connection.Open();
            LoginProc.ExecuteNonQuery();
            connection.Close();

            Session["userid"] = id.Value;

            if (success.Value.Equals(true))
            {
                Response.Redirect("profile.aspx");
            }
            else
            {
                Response.Write("incorrect password or email" );
            }

        }
    }
}