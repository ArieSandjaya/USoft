using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using USoft.Globalization;
using USoft.Globalization.Users;

namespace USoft
{
    public partial class LogOn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int count;
            String[] userLang = Request.UserLanguages;

            for (count = 0; count < userLang.Length; count++)
            {
                if (userLang[count].ToUpper() != "EN-US")
                {
                    lblWarning.Visible = true; // zul was here
                    loginButton.Visible = false; //test
                }
                else
                {
                    lblWarning.Visible = false;
                    loginButton.Visible = true;
                }
            }
        }

        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                if (isAuthtenticate(txtUserID.Text, txtPassword.Text))
                {
                    string chPass = Convert.ToString(Session["ChangePass"]);
                    if (chPass == "Y")
                    {
                        Response.Redirect("Modules/Main/ChangePassword.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                }
                else
                {
                    AppMessage.SetMessage(this.Page, "User ID and/or password are unauthorized");
                }
            }
            catch(Exception ex)
            {
                AppMessage.SetMessage(this.Page, ex.Message.ToString());
            }
        }

        private bool isAuthtenticate(string UserId, string Password)
        {
            UserLogon uLogon = new UserLogon();
            return uLogon.doLogon(UserId, Password);
        }
    }
}
