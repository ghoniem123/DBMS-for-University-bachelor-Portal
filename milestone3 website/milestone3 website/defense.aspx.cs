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
    public partial class defense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void viewbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("defenseview.aspx");
        }

        protected void updatebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("defenseupdate.aspx");
        }
    }
}