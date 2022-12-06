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
using USoft.Common.Shared;
using System.Collections.Generic;
using USoft.Marketing.CashReward;
using System.Globalization;
using USoft.Globalization;

namespace USoft.Modules.Marketing.CashReward
{
    public partial class CashReward : System.Web.UI.Page
    {
        private decimal TotalAmount = 0, TotalAmountTax = 0, TotalAmountNet = 0;
        private int paidtype;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            if (!IsPostBack)
            {
                gvCashReward.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                ControlBindingHelper.BindMyDropDownListAsBranch(ddlBranch, true);
                ControlBindingHelper.BindMyDropDownListAsBrand(ddlBrand, false);
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Cash Reward";
            ucHeaderPage.CssClass = "divHeader1";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Show(1,true);
            CekSessions.UnBlockUI(this.Page, this.updPanel, ScriptManager1);

            string Status = getStatus_WF().ToString();
            if (Status == "REQUEST")
            {
                gvCashReward.Enabled = false;
                AppMessage.SetMessage(this.Page, "This Period is waiting for approval");
            }
            else if (Status == "APPROVED")
            {
                gvCashReward.Enabled = false;
                AppMessage.SetMessage(this.Page, "This Period has been Approved");
            }
            else //if Rejected
            {
                gvCashReward.Enabled = true;
            }
        }

        private void Show(int MinRow,bool NewSearch)
        {
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PERIOD", txtPeriod.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CONDITION", ddlAssetCondition.SelectedValue));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRAND", ddlBrand.SelectedItem.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRANCH", ddlBranch.SelectedValue));
            ParameterCollection.Add(new KeyValuePair<string, object>("@RECIPIENT_NAME", txtRecipientName.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 0));
            GetCashReward.Show(ParameterCollection, gvCashReward, CtrlPager,MinRow,NewSearch);
        }
        private String getStatus_WF() //get status from table Cash_Reward_Header
        {
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PERIOD", txtPeriod.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PaidType", paidtype));

            GetCashReward gS = new GetCashReward();
            return gS.CheckCR_WF_status(ParameterCollection).ToString();
        }

        public void NextPager(object sender, EventArgs e)
        {
            Label lblCurrPage = (Label)CtrlPager.FindControl("lblCurrent");
            Show(Convert.ToInt16(lblCurrPage.Text),false);
        }

        public void PrevPager(object sender, EventArgs e)
        {
            Label lblCurrPage = (Label)CtrlPager.FindControl("lblCurrent");
            Show(Convert.ToInt16(lblCurrPage.Text), false);
        }

        protected void gvCashReward_RowDataBound(object sender, GridViewRowEventArgs e)
        {            
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                string period =  e.Row.Cells[1].Text;
                string contractId = e.Row.Cells[2].Text;
                string SupplierType = e.Row.Cells[3].Text;
                string RefundRecId = e.Row.Cells[4].Text;
                string SupplierCode = e.Row.Cells[5].Text;
                string BrandCode = e.Row.Cells[6].Text;
                string RecipientName = e.Row.Cells[20].Text;
                CheckBox chkPaid = (CheckBox)e.Row.FindControl("chkPaid");
                CheckBox chkLater = (CheckBox)e.Row.FindControl("chkLater");
                TextBox tBox = (TextBox)e.Row.FindControl("txtAmountRewardPaid");
                decimal iTax = Convert.ToDecimal(((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[33].ToString());
                chkPaid.Attributes.Add("onclick", "SelectionCheckBox('" + period + "','" + contractId + "','" + SupplierType + "','" + RefundRecId + "','" + SupplierCode + "','" + BrandCode + "','" + RecipientName + "'," + "this" + ",'cpaid')");
                chkLater.Attributes.Add("onclick", "SelectionCheckBox('" + period + "','" + contractId + "','" + SupplierType + "','" + RefundRecId + "','" + SupplierCode + "','" + BrandCode + "','" + RecipientName + "'," + "this" + ",'clater')");
                tBox.Attributes.Add("onblur", "UpdateAmount('" + period + "','" + contractId + "','" + SupplierType + "','" + RefundRecId + "','" + SupplierCode + "','" + BrandCode + "','" + RecipientName + "'," + "this" + ",'" + iTax + "')");
                //chkPaid.Enabled = chkLater.Checked?false:true;
                //chkLater.Enabled = chkPaid.Checked?false:true;
                if (chkLater.Checked)
                {
                    chkPaid.InputAttributes.Add("disabled","");
                    paidtype = 2; //
                }
                if(chkPaid.Checked)
                {
                    chkLater.InputAttributes.Add("disabled","");
                    paidtype = 1; //
                }
                if ((chkPaid.Checked == false) && (chkLater.Checked == false))
                {
                    paidtype = 0;
                }

                TotalAmount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
                TotalAmountTax = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalTax"));
                TotalAmountNet = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalNet"));
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotal = (Label)e.Row.FindControl("lblTotalAmount");
                lblTotal.Text = TotalAmount.ToString("Rp, 0,0.00");
                Label lblTotalTax = (Label)e.Row.FindControl("lblTotalTax");
                lblTotalTax.Text = TotalAmountTax.ToString("0,0.00");
                Label lblTotalNet = (Label)e.Row.FindControl("lblTotalNet");
                lblTotalNet.Text = TotalAmountNet.ToString("0,0.00");
            }
        }

        protected void gvCashReward_DataBound(object sender, EventArgs e)
        {
            
        }
    }
}
