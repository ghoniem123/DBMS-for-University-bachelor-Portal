using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Drawing;

namespace milestone3_website
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void registerbutton_Click(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Milestone3"].ConnectionString);

            if (string.IsNullOrWhiteSpace(fnamebox.Text) || string.IsNullOrWhiteSpace(lnamebox.Text) || string.IsNullOrWhiteSpace(dateofbirthbox.Text)
                || string.IsNullOrWhiteSpace(usernamebox.Text) || string.IsNullOrWhiteSpace(emailbox.Text) || string.IsNullOrWhiteSpace(gpabox.Text)
                || string.IsNullOrWhiteSpace(addressbox.Text) || string.IsNullOrWhiteSpace(majorcodebox.Text) || string.IsNullOrWhiteSpace(phonebox.Text))
            {
     
                Response.Write("Fill all the fields please to be able to register");
            }
            else if (dateofbirthbox.Text.Length != 10 || dateofbirthbox.Text[4].CompareTo('/') != 0 || dateofbirthbox.Text[7].CompareTo('/') != 0)
            {
                Response.Write("Please enter the date of birth in the specified format");
            }
            else
            {
                string fname = fnamebox.Text;
                string lname = lnamebox.Text;
                DateTime dateofbirthvalue;

                try
                {
                    dateofbirthvalue = DateTime.Parse(dateofbirthbox.Text);
                }
                catch (Exception exp)
                {

                    Response.Write("please enter the date in the specified format");
                    return;
                }

               
                string username = usernamebox.Text;
                string email = emailbox.Text;
                int semester = int.Parse(semesterlist.SelectedItem.Value);
                double gpa = double.Parse(gpabox.Text);
                string address = addressbox.Text;
                string major = majorcodebox.Text;
                string phone = phonebox.Text;

                SqlCommand RegisterProc = new SqlCommand("UserRegister", connection);
                RegisterProc.CommandType = System.Data.CommandType.StoredProcedure;
                RegisterProc.Parameters.Add(new SqlParameter("@usertype", "Student"));
                RegisterProc.Parameters.Add(new SqlParameter("@Username", username));
                RegisterProc.Parameters.Add(new SqlParameter("@Email", email));
                RegisterProc.Parameters.Add(new SqlParameter("@firstname", fname));
                RegisterProc.Parameters.Add(new SqlParameter("@lastname", lname));
                RegisterProc.Parameters.Add(new SqlParameter("@DateOfBirth", dateofbirthvalue));
                RegisterProc.Parameters.Add(new SqlParameter("@GPA", gpa));
                RegisterProc.Parameters.Add(new SqlParameter("@Semester", semester));
                RegisterProc.Parameters.Add(new SqlParameter("@StudentAddress", address));
                RegisterProc.Parameters.Add(new SqlParameter("@FacultyCode", ""));
                RegisterProc.Parameters.Add(new SqlParameter("@MajorCode", major));
                RegisterProc.Parameters.Add(new SqlParameter("@company_name", ""));
                RegisterProc.Parameters.Add(new SqlParameter("@RepresentativeName", ""));
                RegisterProc.Parameters.Add(new SqlParameter("@RepresentativeEmail", ""));
                RegisterProc.Parameters.Add(new SqlParameter("@Phone", phone));
                RegisterProc.Parameters.Add(new SqlParameter("@CompanyLocation", ""));

                SqlParameter idofregister = RegisterProc.Parameters.Add("@ID", System.Data.SqlDbType.Int);
                SqlParameter passwordofregister = RegisterProc.Parameters.Add("@password", System.Data.SqlDbType.VarChar, 10);

                idofregister.Direction = System.Data.ParameterDirection.Output;
                passwordofregister.Direction = System.Data.ParameterDirection.Output;

                connection.Open();
                RegisterProc.ExecuteNonQuery();
                connection.Close();

                Session["userid"] = idofregister.Value;

                if (passwordofregister.Value.Equals("email"))
                {
                    Response.Write("Email already exists, enter a different one");
                }
                else if (passwordofregister.Value.Equals("major"))
                {
                    Response.Write("you are entering a major that doesn't exist");
                }
                else
                {
                    Response.Redirect("profile.aspx");
                }
            }
        }
    }
}