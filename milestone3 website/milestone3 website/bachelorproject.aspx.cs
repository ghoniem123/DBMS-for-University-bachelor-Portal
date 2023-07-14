using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3_website
{
    public partial class bachelorproject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void preferencebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("projectpreference.aspx");
        }

        protected void gradebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("projectgrade.aspx");
        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
    }
}