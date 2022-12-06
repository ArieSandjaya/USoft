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

namespace USoft.Modules.GeneralAffair.Master
{
    public partial class ItemGroupAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlItemCategory, "- Select One -", "spGetGAItemCategoryToCombo ''", "ItemCategoryCode", "ItemCategoryName", null);
                
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
                    txtItemGroupCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Item Group";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Master.ItemGroup info = new USoft.DataAccess.Entities.General_Affair.Master.ItemGroup();
            USoft.DataAccess.General_Affair.Master.ItemGroup da = new USoft.DataAccess.General_Affair.Master.ItemGroup();

            info.ItemGroupCode = editID;

            da.getItemGroupView(ref info);

            txtItemGroupCode.Text = info.ItemGroupCode;
            txtItemGroupName.Text = info.ItemGroupName;
            ddlItemCategory.SelectedValue = info.ItemCategoryCode;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.General_Affair.Master.ItemGroup info = new USoft.DataAccess.Entities.General_Affair.Master.ItemGroup();
            USoft.DataAccess.General_Affair.Master.ItemGroup da = new USoft.DataAccess.General_Affair.Master.ItemGroup();

            info.ItemGroupCode = txtItemGroupCode.Text;
            info.ItemGroupName = txtItemGroupName.Text;
            info.ItemCategoryCode = ddlItemCategory.SelectedValue;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.ItemGroupUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.ItemGroupInsert(info);
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
                    //mbAdd.Visible = false;
                    Response.Redirect("ItemGroupAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtItemGroupCode.Text + "&state=edit&msg=" + lblMessage.Text);
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
            Response.Redirect("ItemGroup.aspx?validate=" + validate(0));
        }
    }
}
