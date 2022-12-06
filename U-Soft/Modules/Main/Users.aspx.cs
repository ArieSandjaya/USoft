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

namespace USoft.Modules.Main
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["menuprivcode"] = "";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveUsers();
        }
        private void SaveUsers()
        {
            UserControl uc1 = (UserControl)this.FindControl("CtrlBranch");
            DropDownList ddl1 = (DropDownList)uc1.FindControl("ddlBranch");
            string strBranchId = ddl1.SelectedValue.ToString();

            UserCreate user = new UserCreate();
            user.UserID = txtUserId.Text;
            user.Username = txtName.Text;
            user.Password = txtReTypePassword.Text;
            user.BranchID = Convert.ToInt32(ddl1.SelectedValue.ToString());
            user.Email = txtEmail.Text;
            if (chkCPass.Checked) user.ChangePass = "Y"; 
             else user.ChangePass = "N";

            if (chkSendMail.Checked) user.SendMail = "Y"; 
            else user.SendMail = "N";

            string newString = user.CreateUser();
            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
                UserMenu usermenu = new UserMenu();
                usermenu.UserID = txtUserId.Text;
                gvMenu.DataSource = usermenu.GetAllMenu();
                gvMenu.DataBind();
                tblMenu.Attributes.Add("class", "show");
                updGrid.Update();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User Already Exists');", true);
            }
        }

        //btn menu by priv
        protected void Button1_Click(object sender, EventArgs e) /////////////////
        {
            mpePR.Show();
        }
        protected void imgBtnCancel_Click(object sender, ImageClickEventArgs e) //////////////
        {
            mpePR.Hide();
        }
        protected void btnOK_Click(object sender, EventArgs e) /////////////////
        {
            UserControl uc2 = (UserControl)this.FindControl("CtrlPriviledge");
            DropDownList ddl2 = (DropDownList)uc2.FindControl("ddlPriviledge");
            string strPrivCode = ddl2.SelectedValue.ToString();

            PrivMenu privmenu = new PrivMenu();
            if (strPrivCode == "") privmenu.PrivCode = "";
            else privmenu.PrivCode = strPrivCode;
            Session["menuprivcode"] = privmenu.PrivCode;
            gvMenu.DataSource = privmenu.GetAllPrivMenu();
            gvMenu.DataBind();
            updGrid.Update();
        }

        //btn menu by user
        protected void Button2_Click(object sender, EventArgs e) //////////////
        {
            mpeUSR.Show();
        }
        protected void imgBtnCancel2_Click(object sender, ImageClickEventArgs e) ///////////
        {
            mpeUSR.Hide();
        }
        protected void btnOK2_Click(object sender, EventArgs e) ////////////
        {
            UserControl uc3 = (UserControl)this.FindControl("CtrlUserId");
            DropDownList ddl3 = (DropDownList)uc3.FindControl("ddlUserId");
            string strUserId = ddl3.SelectedValue.ToString();
            string strPrivCod = ddl3.SelectedItem.Attributes["code"].ToString();

            UserMenu usr = new UserMenu();
            usr.UserID = strUserId;
            usr.PrivCode = strPrivCod;
            Session["menuprivcode"] = usr.PrivCode;
            gvMenu.DataSource = usr.GetAllMenu();
            gvMenu.DataBind();
            updGrid.Update();
        }

        protected void btnSaveMenu_Click(object sender, EventArgs e)
        {
            foreach (TableRow tr in gvMenu.Rows)
            {
                try
                {
                    CheckBox chkInsert = tr.FindControl("chkInsert") as CheckBox;
                    CheckBox chkUpdate = tr.FindControl("chkUpdate") as CheckBox;
                    CheckBox chkDelete = tr.FindControl("chkDelete") as CheckBox;
                    CheckBox chkView = tr.FindControl("chkView") as CheckBox;
                    
                    UserMenu uMenu = new UserMenu();
                    uMenu.UserID = txtUserId.Text;
                    uMenu.PrivCode = Session["menuprivcode"].ToString(); //////////
                    uMenu.MenuId = Convert.ToInt32(tr.Cells[0].Text);
                    uMenu.Insert = chkInsert.Checked ? 1 : 0;
                    uMenu.Update = chkUpdate.Checked ? 1 : 0;
                    uMenu.Delete = chkDelete.Checked ? 1 : 0;
                    uMenu.View = chkView.Checked ? 1 : 0;
                    uMenu.SaveUserMenu();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
                }
                catch
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Data');", true);
                }
            }
        }
   
    }
}
