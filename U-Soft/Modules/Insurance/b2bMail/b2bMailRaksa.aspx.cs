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
using System.IO;
using System.Drawing;
using System.Net.Mail;
using System.Net.Mime;
using USoft.Globalization;
using USoft.Common.Setting;
using USoft.Insurance.B2BMail;

namespace USoft.Modules.b2bMail
{
    public partial class b2bMailRaksa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                clsSetting cSetting = new clsSetting();
                cSetting.InsType = dllEmailTo.SelectedValue.ToString();
                getEmail();
            }            
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "B2B MAIL";
            ucHeaderPage.CssClass = "divHeader1";
        }

        public void getEmail()
        {
            string Userid = HttpContext.Current.Session["UserId"].ToString();
            string Email  = HttpContext.Current.Session["Email"].ToString();
            
            if (Userid == null) { Userid = ""; }
            if (Session["UserId"].ToString() != "")
            {
                DataSet ds = new clsSetting().getCC();
                string strTo = "";
                string strCC = "";
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["EmailType"].ToString() == "TO")
                    {
                        strTo = strTo + dr["Email"].ToString() + ",";
                    }
                    else
                    {
                        strCC = strCC + dr["Email"].ToString() + ",";
                    }
                }
                lblMessage.Text = "";
                txtSender.Text = Email;
                txtReceiver.Text = strTo;
                txtCc.Text = strCC;
                if (dllEmailTo.SelectedValue.ToString() == "TOKIO")
                {
                    txtSubject.Text = "Aplikasi Endorsment";
                }
                else
                {
                    txtSubject.Text = "Aplikasi Asuransi";
                }
            }
            else
            {
                Response.Redirect("LogOn.aspx");
            }
        }
        
        protected void dllEmailTo_SelectedIndexChanged(object sender, EventArgs e)
        {               

        }

        protected void dllEmailTo_TextChanged(object sender, EventArgs e)
        {
            clsSetting cSetting = new clsSetting();
            cSetting.InsType = dllEmailTo.SelectedValue.ToUpper();
            getEmail();
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress(txtSender.Text, "UFI");
                mailMessage.To.Add(txtReceiver.Text);
                if (txtCc.Text != "")
                {
                    mailMessage.CC.Add(txtCc.Text);
                }
                mailMessage.Subject = txtSubject.Text;
                mailMessage.Body = txtBody.Text;
                if (rblMailFormat.SelectedItem.Text == "Text")
                    mailMessage.IsBodyHtml = false;
                else
                    mailMessage.IsBodyHtml = true;
                string attach1 = null;
                string attach2 = null;
                string attach3 = null;
                string strFileName = null;
                if (inpAttachment1.PostedFile != null)
                {
                    HttpPostedFile attFile = inpAttachment1.PostedFile;
                    int attachFileLength = attFile.ContentLength;
                    if (attachFileLength > 0)
                    {
                        strFileName = Path.GetFileName(inpAttachment1.PostedFile.FileName);
                        File.Delete(Server.MapPath(strFileName));
                        inpAttachment1.PostedFile.SaveAs(Server.MapPath(strFileName));
                        Attachment atch = new Attachment(Server.MapPath(strFileName));
                        mailMessage.Attachments.Add(atch);
                        attach1 = strFileName;
                    }
                }
                if (inpAttachment2.PostedFile != null)
                {
                    HttpPostedFile attFile = inpAttachment2.PostedFile;
                    int attachFileLength = attFile.ContentLength;
                    if (attachFileLength > 0)
                    {
                        strFileName = Path.GetFileName(inpAttachment2.PostedFile.FileName);
                        File.Delete(Server.MapPath(strFileName));
                        inpAttachment2.PostedFile.SaveAs(Server.MapPath(strFileName));
                        Attachment atch = new Attachment(Server.MapPath(strFileName));
                        mailMessage.Attachments.Add(atch);
                        attach2 = strFileName;
                    }
                }
                if (inpAttachment3.PostedFile != null)
                {
                    HttpPostedFile attFile = inpAttachment3.PostedFile;
                    int attachFileLength = attFile.ContentLength;
                    if (attachFileLength > 0)
                    {
                        strFileName = Path.GetFileName(inpAttachment3.PostedFile.FileName);
                        File.Delete(Server.MapPath(strFileName));
                        inpAttachment3.PostedFile.SaveAs(Server.MapPath(strFileName));
                        Attachment atch = new Attachment(Server.MapPath(strFileName));
                        mailMessage.Attachments.Add(atch);
                        attach3 = strFileName;
                    }
                }
                string mail_host; 
                int port;
                mail_host = SystemSetting.MailHost; 
                port = SystemSetting.Port;

                SmtpClient client = new SmtpClient(mail_host, port); 
                client.Send(mailMessage);
                CekSessions.UnBlockUI(this.Page, this.UpdatePanel1, ScriptManager1);

                txtBody.Text = "";

                lblMessage.Visible = true;
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Message sent.";
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = ex.ToString();
            }
        }

    }
}
