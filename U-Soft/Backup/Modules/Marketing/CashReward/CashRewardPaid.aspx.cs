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
using System.Collections.Specialized;
using USoft.Globalization;

namespace USoft.Modules.Marketing.CashReward
{
    public partial class CashRewardPaid : System.Web.UI.Page
    {
        decimal TotalAmount = 0, TotalAmountTax = 0, TotalAmountNet = 0;
       
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            if (!IsPostBack)
            {
                gvCashRewardPaid.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                ControlBindingHelper.BindMyDropDownListAsBranch(ddlBranch, true);
                ControlBindingHelper.BindMyDropDownListAsBrand(ddlBrand, false);
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Cash Reward Paid in Same Period";
            ucHeaderPage.CssClass = "divHeader1";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Show(1, true);
            CekSessions.UnBlockUI(this.Page, this.updPanel, ScriptManager1);

            string Status = getStatus_WF().ToString();
            if (Status == "REQUEST")
            {
                gvCashRewardPaid.Enabled = false;
                btnWorkFlow.Enabled = false;
                AppMessage.SetMessage(this.Page, "This Period is waiting for approval");
            }
            else if (Status == "APPROVED")
            {
                gvCashRewardPaid.Enabled = false;
                btnWorkFlow.Enabled = false;
                AppMessage.SetMessage(this.Page, "This Period has been Approved");
            }
            else //if Rejected
            {
                gvCashRewardPaid.Enabled = true;
                btnWorkFlow.Enabled = true;
            }
        }

        private void Show(int MinRow, bool NewSearch)
        {
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PERIOD", txtPeriod.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CONDITION", ddlAssetCondition.SelectedValue));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRAND", ddlBrand.SelectedItem.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRANCH", ddlBranch.SelectedValue));
            ParameterCollection.Add(new KeyValuePair<string, object>("@RECIPIENT_NAME", txtRecipientName.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 0));
            GetCashReward.ShowPaid(ParameterCollection, gvCashRewardPaid, CtrlPager, MinRow, NewSearch);
        }
        private String getStatus_WF() //get status from table Cash_Reward_Header
        {
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PERIOD", txtPeriod.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PaidType", 1));
            
            GetCashReward gS = new GetCashReward();
            return gS.CheckCR_WF_status(ParameterCollection).ToString();            
        }

        public void NextPager(object sender, EventArgs e)
        {
            Label lblCurrPage = (Label)CtrlPager.FindControl("lblCurrent");
            Show(Convert.ToInt16(lblCurrPage.Text), false);
        }

        public void PrevPager(object sender, EventArgs e)
        {
            Label lblCurrPage = (Label)CtrlPager.FindControl("lblCurrent");
            Show(Convert.ToInt16(lblCurrPage.Text), false);
        }

        protected void btnConvert_Click(object sender, EventArgs e)
        {
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PERIOD", txtPeriod.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CONDITION", ddlAssetCondition.SelectedValue));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRAND", ddlBrand.SelectedItem.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRANCH", ddlBranch.SelectedValue));
            ParameterCollection.Add(new KeyValuePair<string, object>("@RECIPIENT_NAME", txtRecipientName.Text));
            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 0));
            GetCashReward.PaidConvertXls(ParameterCollection);
        }

        protected void gvCashRewardPaid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string period = e.Row.Cells[1].Text;
                string contractId = e.Row.Cells[2].Text;
                string SupplierType = e.Row.Cells[3].Text;
                string RefundRecId = e.Row.Cells[4].Text;
                string SupplierCode = e.Row.Cells[5].Text;
                string BrandCode = e.Row.Cells[6].Text;
                string RecipientName = e.Row.Cells[20].Text;
                TextBox tBox = (TextBox)e.Row.FindControl("txtAmountRewardPaid");
                decimal iTax = Convert.ToDecimal(((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[33].ToString());
                tBox.Attributes.Add("onblur", "UpdateAmount('" + period + "','" + contractId + "','" + SupplierType + "','" + RefundRecId + "','" + SupplierCode + "','" + BrandCode + "','" + RecipientName + "'," + "this" + ",'" + iTax + "')");

                TotalAmount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
                TotalAmountTax = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalTax"));
                TotalAmountNet = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalNet"));
                Session["Period"] = period;
                Session["Total"] = TotalAmount;
                Session["TotalTax"] = TotalAmountTax;
                Session["TotalNet"] = TotalAmountNet;           
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

        protected void gvCashRewardPaid_DataBound(object sender, EventArgs e)
        {
            
        }

        protected void btnWorkFlow_Click(object sender, EventArgs e)
        {
            InsertToCRHeader();
            AppMessage.SetMessage(this.Page, "Application has been Inserted to Workflow, and needs an approval");
            CekSessions.UnBlockUI(this.Page, this.updPanel, ScriptManager1);
            btnWorkFlow.Enabled = false;
            gvCashRewardPaid.Enabled = false;
        }

        private void InsertToCRHeader()
        {
            string sesUID = Session["UserId"].ToString();
            string period = Session["Period"].ToString();
            string amountPaid = Convert.ToDecimal(Session["Total"]).ToString("0,0.00");
            string amountTax = Convert.ToDecimal(Session["TotalTax"]).ToString("0,0.00");
            string amountNet = Convert.ToDecimal(Session["TotalNet"]).ToString("0,0.00");
            string Description = "Total Amount Paid in same Period : " + amountPaid +
                                 "</br> Total Amount Tax in same Period : " + amountTax +
                                 "</br> Total Amount Net in same Period : " + amountNet +
                                 "</br> Request By : " + sesUID;


            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@period", period));
            ParameterCollection.Add(new KeyValuePair<string, object>("@total_amountPaid", amountPaid)); 
            ParameterCollection.Add(new KeyValuePair<string, object>("@total_amountTax", amountTax));
            ParameterCollection.Add(new KeyValuePair<string, object>("@total_amountNet", amountNet));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", 1));
            ParameterCollection.Add(new KeyValuePair<string, object>("@status", "REQUEST"));
            //insert to Workflow
            ParameterCollection.Add(new KeyValuePair<string, object>("@reqBy", sesUID));
            ParameterCollection.Add(new KeyValuePair<string, object>("@descript", Description));
            
            GetCashReward.insertCRHeader_WF(ParameterCollection);
        }
        
    }
}
