﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3_website
{
    public partial class thesis : System.Web.UI.Page
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
            Response.Redirect("thesisview.aspx");
        }

        protected void submitbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("thesissubmit.aspx");
        }
    }
}