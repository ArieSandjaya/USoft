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

namespace USoft.Modules.GeneralAffair.Purchase
{
    public partial class PurchaseReceivedAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlOrder, "- Select One -", "spGetGAPurchaseOrderToCombo '(Status = ''A'') AND (IsReceived = 0)'", "OrderId", "OrderId", null);

                if (this.state == "add")
                {
                    lblReceivedID.Text = "[Generated By System]";
                }
                else
                {
                    LoadData();
                }
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Purchase Received";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedId = editID;

            da.getPurchaseReceivedView(ref info);

            lblReceivedID.Text = info.ReceivedId;
            txtReceivedDate.Text = cf.DateFormatYYYYMMDD(info.ReceivedDate);
            ddlOrder.SelectedValue = info.OrderId;
            lblOrderDate.Text = cf.DateFormatDDMMYYYY(info.OrderDate);
            lblSupplier.Text = info.SupplierName;
            lblCurrency.Text = info.CurrencyCode;
            txtPIC.Text = info.PIC;
            txtDescription.Text = info.Description;
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedDate = Convert.ToDateTime(txtReceivedDate.Text);
            info.OrderId = ddlOrder.SelectedValue;
            info.PIC = txtPIC.Text;
            info.Description = txtDescription.Text;
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                info.ReceivedId = editID;
                lblMessage.Text = da.PurchaseReceivedUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.PurchaseReceivedInsert(ref info);
                ReturnID = info.ReceivedId;
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        protected void imbSubmit_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //imbSubmit.Visible = false;
                    Response.Redirect("PurchaseReceivedDetail.aspx?validate=" + validate(0) + "&editID=" + ReturnID + "&msg=" + lblMessage.Text);
                }
            }
            else
            {
                ProcessData("U");
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            if (from == "detail")
            {
                Response.Redirect("PurchaseReceivedDetail.aspx?validate=" + validate(0) + "&editID=" + editID);
            }
            else
            {
                Response.Redirect("PurchaseReceived.aspx?validate=" + validate(0));
            }
        }

        protected void ddlOrder_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page); 
            
            lblOrderDate.Text = "";
            lblSupplier.Text = "";
            lblCurrency.Text = "";

            if (ddlOrder.SelectedValue != "")
            {
                USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
                USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

                info.OrderId = ddlOrder.SelectedValue;

                da.getPurchaseOrderView(ref info);

                lblOrderDate.Text = cf.DateFormatDDMMYYYY(info.OrderDate);
                lblSupplier.Text = info.SupplierName;
                lblCurrency.Text = info.CurrencyCode;
            }

            pnlDataForm.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataForm, ScriptManager1);
        }
    }
}
