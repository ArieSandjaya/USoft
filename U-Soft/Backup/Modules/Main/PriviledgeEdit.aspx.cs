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
using USoft.Globalization.Privilege;

namespace USoft.Modules.Main
{
    public partial class PriviledgeEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtPrivCode1.Text = Request.QueryString["PrivCode"];
                txtPrivName1.Text = Request.QueryString["PrivName"];
                DropDownList ddlIsActive = (DropDownList)CtrlIsActive.FindControl("ddlIsActive");
                ddlIsActive.SelectedIndex = ddlIsActive.Items.IndexOf(ddlIsActive.Items.FindByValue(Request.QueryString["Active"]));
                
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdatePriviledge();
        }

        private void UpdatePriviledge()
        {
            DropDownList dl = (DropDownList)CtrlIsActive.FindControl("ddlIsActive");
            string strStatus = dl.SelectedValue.ToString();

            PrivEdit prv = new PrivEdit();
            prv.PrivCode = txtPrivCode1.Text;
            prv.PrivName = txtPrivName1.Text;
            prv.Status = Convert.ToInt16(strStatus);

            string newString = prv.EditPrivil();
            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data has been Updated');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error When Update proses');", true);
            }
        }

        protected void btnEditMenu_Click(object sender, EventArgs e)
        {
            PrivMenu prvmenu = new PrivMenu();
            prvmenu.PrivCode = txtPrivCode1.Text;
            gvMenu.DataSource = prvmenu.GetAllPrivMenu();
            gvMenu.DataBind();
            tblMenu.Attributes.Add("class", "show");
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

                    PrivMenu pMenu = new PrivMenu();
                    pMenu.PrivCode = txtPrivCode1.Text;
                    pMenu.MenuId = Convert.ToInt32(tr.Cells[0].Text);
                    pMenu.Insert = chkInsert.Checked ? 1 : 0;
                    pMenu.Update = chkUpdate.Checked ? 1 : 0;
                    pMenu.Delete = chkDelete.Checked ? 1 : 0;
                    pMenu.View = chkView.Checked ? 1 : 0;
                    pMenu.SavePrivMenu();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
                }
                catch
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Data');", true);
                }
            }
        }

        protected void imgBtnClose_Click(object sender, ImageClickEventArgs e)
        {
            tblMenu.Attributes.Add("class", "hide");
        }
    }
}
