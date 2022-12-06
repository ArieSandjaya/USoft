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
    public partial class ItemTypeAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlItemCategory, "- Select One -", "spGetGAItemCategoryToCombo ''", "ItemCategoryCode", "ItemCategoryName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlMeasurement, "- Select One -", "spGetMeasurementToCombo ''", "MeasurementCode", "MeasurementCode", null);

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
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Item Type";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Master.ItemType info = new USoft.DataAccess.Entities.General_Affair.Master.ItemType();
            USoft.DataAccess.General_Affair.Master.ItemType da = new USoft.DataAccess.General_Affair.Master.ItemType();

            info.ItemTypeCode = editID;

            da.getItemTypeView(ref info);

            txtItemTypeCode.Text = info.ItemTypeCode;
            txtItemTypeName.Text = info.ItemTypeName;
            ddlItemCategory.SelectedValue = info.ItemCategoryCode;
            ControlBindingHelper.BindDataSetToCombo(ddlItemGroup, "- Select One -", "spGetGAItemGroupToCombo ''", "ItemGroupCode", "ItemGroupName", info.ItemGroupCode);
            ddlMeasurement.SelectedValue = info.MeasurementCode;
            txtDescription.Text = info.Description;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.General_Affair.Master.ItemType info = new USoft.DataAccess.Entities.General_Affair.Master.ItemType();
            USoft.DataAccess.General_Affair.Master.ItemType da = new USoft.DataAccess.General_Affair.Master.ItemType();

            info.ItemTypeCode = txtItemTypeCode.Text;
            info.ItemTypeName = txtItemTypeName.Text;
            info.ItemCategoryCode = ddlItemCategory.SelectedValue;
            info.ItemGroupCode = ddlItemGroup.SelectedValue;
            info.MeasurementCode = ddlMeasurement.SelectedValue;
            info.Description = txtDescription.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.ItemTypeUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.ItemTypeInsert(info);
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

        protected void ddlItemCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            ddlItemGroup.Items.Clear();

            if (ddlItemCategory.SelectedValue != "")
            {
                ControlBindingHelper.BindDataSetToCombo(ddlItemGroup, "- Select One -", "spGetGAItemGroupToCombo 'ItemCategoryCode = ''" + ddlItemCategory.SelectedValue + "'''", "ItemGroupCode", "ItemGroupName", null);
            }
            pnlItemGroup.Update();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }
    }
}
