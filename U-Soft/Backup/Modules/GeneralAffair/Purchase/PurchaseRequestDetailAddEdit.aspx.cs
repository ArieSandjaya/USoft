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
using USoft.Globalization.Classes;
using USoft.Common.CommonFunction;
using USoft.DataAccess;

namespace USoft.Modules.GeneralAffair.Purchase
{
    public partial class PurchaseRequestDetailAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlItemCategory, "- Select One -", "spGetGAItemCategoryToCombo ''", "ItemCategoryCode", "ItemCategoryName", null);

                lblRequestID.Text = editID;

                txtQuantity.Attributes["onkeyup"] = "formatNumber(this); CalculateTotal();";
                txtPrice.Attributes["onkeyup"] = "formatNumber(this); CalculateTotal();";
                LoadData();

                if (this.state == "add")
                {
                    imbUpdate.Enabled = false;
                    imbUpdate.Visible = false;
                }
                else
                {
                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadDataDetail();
                    FormState();
                }
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Purchase Request Detail";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.RequestId = editID;

            da.getPurchaseRequestView(ref info);

            CreatedBy = info.CreatedBy;
            Status = info.Status;
            lblCurrency.Text = info.CurrencyCode;
        }
        
        
        private void LoadDataDetail()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.RequestId = editID;
            info.RequestDetailId = editDetailID;

            da.getPurchaseRequestDetailView(ref info);

            lblRequestID.Text = info.RequestId;
            ddlItemCategory.SelectedValue = info.ItemCategoryCode;
            ControlBindingHelper.BindDataSetToCombo(ddlItemGroup, "- Select One -", "spGetGAItemGroupToCombo 'ItemCategoryCode = ''" + ddlItemCategory.SelectedValue + "'''", "ItemGroupCode", "ItemGroupName", info.ItemGroupCode);
            ControlBindingHelper.BindDataSetToCombo(ddlItemType, "- Select One -", "spGetGAItemTypeToCombo 'ItemGroupCode = ''" + ddlItemGroup.SelectedValue + "'''", "ItemTypeCode", "ItemTypeName", info.ItemTypeCode);
            txtQuantity.Text = Convert.ToString(info.Quantity);
            lblMeasurement.Text = info.MeasurementCode;
            txtPrice.Text = Convert.ToString(info.Price);
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.RequestId = editID;
            info.ItemTypeCode = ddlItemType.SelectedValue;
            info.Quantity = Convert.ToDouble(txtQuantity.Text);
            info.Price = Convert.ToDouble(txtPrice.Text);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                info.RequestDetailId = editDetailID;
                lblMessage.Text = da.PurchaseRequestDetailUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.PurchaseRequestDetailInsert(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        protected void ProcessForm()
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.blockUI();", true);

            CekSessions.BlockUI(this.Page);

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //imbSubmit.Visible = false;
                    ClearForm();
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
            Response.Redirect("PurchaseRequestDetail.aspx?validate=" + validate(0) + "&from=" + from + "&editID=" + editID);
        }

        protected void ClearForm()
        {
            ddlItemCategory.SelectedValue = "";
            ddlItemGroup.Items.Clear();
            ddlItemType.Items.Clear();
            txtQuantity.Text = "";
            lblMeasurement.Text = "";
            txtPrice.Text = "";
            txtTotal.Text = "";
        }

        protected void FormState()
        {
            if ((CreatedBy != enUI.UserId) || (Status != "D"))
            {
                ddlItemCategory.Enabled = false;
                ddlItemGroup.Enabled = false;
                ddlItemType.Enabled = false;
                txtQuantity.Enabled = false;
                txtPrice.Enabled = false;
                txtTotal.Enabled = false;
                imbUpdate.Visible = false;
            }
        }

        protected void ddlItemCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page); 
            
            ddlItemGroup.Items.Clear();
            ddlItemType.Items.Clear();
            lblMeasurement.Text = "";
            if (ddlItemCategory.SelectedValue != "")
            {
                ControlBindingHelper.BindDataSetToCombo(ddlItemGroup, "- Select One -", "spGetGAItemGroupToCombo 'ItemCategoryCode = ''" + ddlItemCategory.SelectedValue + "'''", "ItemGroupCode", "ItemGroupName", null);
            }

            pnlDataForm.Update();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void ddlItemGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page); 
            
            ddlItemType.Items.Clear();
            lblMeasurement.Text = "";
            if (ddlItemGroup.SelectedValue != "")
            {
                ControlBindingHelper.BindDataSetToCombo(ddlItemType, "- Select One -", "spGetGAItemTypeToCombo 'ItemGroupCode = ''" + ddlItemGroup.SelectedValue + "'''", "ItemTypeCode", "ItemTypeName", null);
            }

            pnlDataForm.Update();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void ddlItemType_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            lblMeasurement.Text = "";
            if (ddlItemType.SelectedValue != "")
            {
                USoft.DataAccess.Entities.General_Affair.Master.ItemType info = new USoft.DataAccess.Entities.General_Affair.Master.ItemType();
                USoft.DataAccess.General_Affair.Master.ItemType da = new USoft.DataAccess.General_Affair.Master.ItemType();

                info.ItemTypeCode = ddlItemType.SelectedValue;

                da.getItemTypeView(ref info);

                lblMeasurement.Text = info.MeasurementCode;
            }

            pnlDataForm.Update();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }
    }
}
