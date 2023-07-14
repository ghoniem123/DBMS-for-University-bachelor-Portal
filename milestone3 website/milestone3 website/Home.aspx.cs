using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3_website
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void thesisbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("thesis.aspx");
        }

        protected void projectbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("bachelorproject.aspx");
        }

        protected void profilebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("profile.aspx");
        }

        protected void progressbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("progressreport.aspx");
        }

        protected void defensebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("defense.aspx");
        }

        protected void meetingbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("meetings.aspx");
        }
    }
}