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
    public partial class Priviledge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SavePrivilegde();
        }
        
        private void SavePrivilegde()
        {
            PrivCreate priv = new PrivCreate();
            priv.PrivCode = txtPrivCode.Text;
            priv.PrivName = txtPrivName.Text;

            string newString = priv.CreatePriviledge();
            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
                PrivMenu privmenu = new PrivMenu();
                privmenu.PrivCode = txtPrivCode.Text;
                gvMenu.DataSource = privmenu.GetAllPrivMenu();
                gvMenu.DataBind();
                tblMenu.Attributes.Add("class", "show");
                updGrid.Update();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Privilege Already Exists');", true);
            }

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
                    pMenu.PrivCode = txtPrivCode.Text;
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
    }
}
