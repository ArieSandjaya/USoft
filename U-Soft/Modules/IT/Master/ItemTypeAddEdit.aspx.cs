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

using USoft.Globalization.Classes;
using USoft.Common.CommonFunction;
using USoft.DataAccess;
using USoft.Globalization;

namespace USoft.Modules.IT.Master
{
    public partial class ItemTypeAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                if (this.state == "add")
                {
                    imbUpdate.Enabled = false;
                    imbUpdate.Visible = false;
                }
                else
                {
                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadData();
                    txtItemTypeCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " IT Item Type";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.Master.ItemType info = new USoft.DataAccess.Entities.IT.Master.ItemType();
            USoft.DataAccess.IT.Master.ItemType da = new USoft.DataAccess.IT.Master.ItemType();

            info.ItemTypeCode = editID;

            da.getITItemTypeView(ref info);

            txtItemTypeCode.Text = info.ItemTypeCode;
            txtItemTypeName.Text = info.ItemTypeName;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.IT.Master.ItemType info = new USoft.DataAccess.Entities.IT.Master.ItemType();
            USoft.DataAccess.IT.Master.ItemType da = new USoft.DataAccess.IT.Master.ItemType();

            info.ItemTypeCode = txtItemTypeCode.Text;
            info.ItemTypeName = txtItemTypeName.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.ITItemTypeUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.ITItemTypeInsert(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        protected void ProcessForm()
        {
            CekSessions.BlockUI(this.Page);

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //imbAdd.Visible = false;
                    Response.Redirect("ItemTypeAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtItemTypeCode.Text + "&state=edit&msg=" + lblMessage.Text);
                }
            }
            else
            {
                ProcessData("U");
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbAdd_Click(object sender, ImageClickEventArgs e)
        {
            ProcessForm();
        }

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            ProcessForm();
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemType.aspx?validate=" + validate(0));
        }
    }
}
