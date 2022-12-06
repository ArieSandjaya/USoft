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
using USoft.Common.Setting;
using USoft.Common.Security;
using USoft.Globalization.Users;

namespace USoft.Modules.Main
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            txtUserName.Text = Session["UserId"].ToString();
            if (!IsPostBack)
            { }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Change Password";
            ucHeaderPage.CssClass = "divHeader1";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if(setPassword()==true)
                { AppMessage.SetMessage(this.Page, "Password Already Change"); }
                else
                { AppMessage.SetMessage(this.Page, "Cannot Change Password"); }

                Response.Redirect("~/Default.aspx", false); /////
            }
            catch(Exception ex)
            { AppMessage.SetMessage(this.Page, ex.Message);}
        }

        private Boolean setPassword()
        {
                UserLogon uLogon = new UserLogon();
                if (txtReType.Text != "" && txtReType.Text.Length >= Convert.ToInt16(SystemSetting.MinPassLength))
                {

                    return uLogon.changePassword(txtUserName.Text, txtOldPassword.Text, EncryptionMD5.Encrypt(txtReType.Text));
                }
                else
                {
                    return false;
                }
        }
    }
}
