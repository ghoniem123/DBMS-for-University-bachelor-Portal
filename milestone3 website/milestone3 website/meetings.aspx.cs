using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3_website
{
    public partial class meetings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void homebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void notbookedbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("notbooked.aspx");
        }

        protected void bookbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("book.aspx");
        }

        protected void viewbookedbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("booked.aspx");
        }

        protected void addtodobutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("addto.aspx");
        }
    }
}