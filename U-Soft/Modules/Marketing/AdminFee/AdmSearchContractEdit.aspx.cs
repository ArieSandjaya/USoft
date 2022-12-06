using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using USoft.Marketing.AdminFee;
using System.Collections.Generic;

namespace USoft.Modules.Marketing
{
    public partial class AdmSearchContractEdit : System.Web.UI.Page
    {
        private static string RefundNet;
        private static string RefundGross;
        private static DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                txtOTR.Attributes.Add("stringFormat", "{0:N}");
                //txtFlatRate.Attributes.Add("stringFormat", "custom");
                txtOTR.Attributes.Add("stringFormat", "{0:N}");
                string ContractNo = Request.QueryString["ContractNo"].ToString();
                getValue(ContractNo);
                txtRefundNet.Text = RefundNet;
                txtRefund.Text =  RefundGross;
                lbl25.Visible = false;
                dt.Clear();
                dt = new DataTable();
                getGrid();
                UpdatePanel1.Update();
            }
            if (new GetContract().SaveState == 1)
            {
                btnPrint.Enabled = true;
                btnSave.Enabled = false;
            }
            else
            {
                btnPrint.Enabled = false;
                if (txtCommence.Text == "")
                {
                    btnSave.Enabled = false;
                }
                else
                {
                    btnSave.Enabled = true;
                }
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Admin Search Contract Edit";
            ucHeaderPage.CssClass = "divHeader1";
        }

        protected void gdView_RowCreated(object sender, GridViewRowEventArgs e)
        {
        }
        protected void getValue(string ContractNo)
        {
            List<KeyValuePair<string, object>> myControl= new List<KeyValuePair<string, object>>();
            myControl.Add(new KeyValuePair<string, object>("contract_number", txtContractNum));
            myControl.Add(new KeyValuePair<string, object>("admFee", txtAdmFee));
            myControl.Add(new KeyValuePair<string, object>("Procentage", txtAdmFeePercen));
            myControl.Add(new KeyValuePair<string, object>("name", txtCustName));
            myControl.Add(new KeyValuePair<string, object>("sellInterest", txtFlatRate));
            myControl.Add(new KeyValuePair<string, object>("effRate", txtEffRate));
            myControl.Add(new KeyValuePair<string, object>("policy_fee_Credit", txtPolicyFeeCredit));
            myControl.Add(new KeyValuePair<string, object>("OTR", txtOTR));
            myControl.Add(new KeyValuePair<string, object>("inputInt", txtInputRate));
            myControl.Add(new KeyValuePair<string, object>("effective_input_rate", txtEffInputRate));
            myControl.Add(new KeyValuePair<string, object>("admPremiCredit", txtPremiCredit));
            myControl.Add(new KeyValuePair<string, object>("admin_fee", txtAdminFee));
            myControl.Add(new KeyValuePair<string, object>("policy_fee", txtPolicyFeeCash));
            myControl.Add(new KeyValuePair<string, object>("other_fee", txtOtherFeeCash));
            GetContract gContract = new GetContract();
            gContract.getContract(ContractNo, myControl);

            //txtPremiCredit.Text = string.Format("{0:N}", Convert.ToDouble(FeeValue.admPremiCredit));
            //txtPremiCust.Text = string.Format("{0:N}", Convert.ToDouble(FeeValue.standPremi) + Convert.ToDouble(FeeValue.adminFee));
            //txtStdPremi.Text = string.Format("{0:N}", Convert.ToDouble(FeeValue.standPremi));
            //txtAdminFee.Text = string.Format("{0:N}", FeeValue.adminFee);
            //txtPolicyFeeCash.Text = string.Format("{0:N}", Convert.ToDouble(FeeValue.policyFee));
            //txtOtherFeeCash.Text = string.Format("{0:N}", Convert.ToDouble(FeeValue.otherFee));
            //lblMaxRefund.Text = string.Format("{0:N}", FeeValue.maxPercent);
            //if (FeeValue.Commence == "")
            //{
            //    txtCommence.Text = "";
            //}
            //else
            //{
            //    txtCommence.Text = String.Format("{0:dd-MM-yyyy}", Convert.ToDateTime(FeeValue.Commence));
            //}
            //txtStdPremiPercent.Text = string.Format("{0:0.0000}", (Convert.ToDouble(FeeValue.standPremi) / Convert.ToDouble(FeeValue.OTR)) * 100) + " %";
            //txttjh.Text = FeeValue.tjh;
            //txtRefundDealer.Text = FeeValue.RefundProcent;
            //new clsSearchEdit().SearchInsurance(contNo);
            //clsSearchEdit Insurance = new clsSearchEdit();
            //txtInsuranceName.Text = Insurance.InsuranceName;
            //lbl01.Text = Insurance.TIns01;
            //lbl02.Text = Insurance.TIns02;
            //lbl03.Text = Insurance.TIns03;
            //lbl04.Text = Insurance.TIns04;
            //lbl05.Text = Insurance.TIns05;
            //txtModel.Text = Insurance.Brand;
            //txtCategory.Text = Insurance.Name;
            //txtAssetCond.Text = Insurance.Condition;
            //txtYear.Text = Insurance.Year;
            //txtBrand.Text = Insurance.BrandItemName;
            //txtInsRate.Text = Insurance.InsRate;
            //txtInsRate2.Text = Insurance.InsRate2;
            //txtInsRate3.Text = Insurance.InsRate3;
            //txtInsRate4.Text = Insurance.InsRate4;
            //GetRefundBunga();
        }
        protected void getGrid()
        {
            //if (txtRefundPercen.Text == "") { txtRefundPercen.Text = "0"; }
            //if ((txtContractNum.Text != "") && (txtRefundPercen.Text != ""))
            //{
            //    int grade;
            //    decimal TaxProcent25 = 0;
            //    double Amount25 = 0;
            //    double NetAmount25 = 0;
            //    double TaxAmount25 = 0;
            //    try
            //    {
            //        DataTable dt = new clsCalculate().calcRefund25(txtContractNum.Text, Convert.ToDecimal(txtRefundPercen.Text));
            //        Session["GridInt" + Session["UName"]] = dt.Rows.Count;
            //        if (dt.Rows.Count > 0)
            //        {
            //            gViewTotal.DataSource = dt;
            //            gViewTotal.DataBind();
            //            if (Convert.ToDecimal(txtRefundPercen.Text) > 25)
            //            {
            //                gViewTotal25.DataSource = dt;
            //                gViewTotal25.DataBind();
            //                gViewTotalSisa.DataSource = dt;
            //                gViewTotalSisa.DataBind();
            //                lbl40.Text = "DATA PENERIMA INSENTIF DAN PAJAK YANG DIPOTONG TOTAL";
            //                lbl25.Text = "DATA PENERIMA INSENTIF DAN PAJAK YANG DIPOTONG GRADASI 25 %)";
            //                lblSisa.Text = "DATA PENERIMA INSENTIF DAN PAJAK YANG DIPOTONG (TOTAL - GRADASI " + Convert.ToString(Convert.ToDecimal(txtRefundPercen.Text) - 25) + "";
            //                lbl40.Visible = true;
            //                lbl25.Visible = true;
            //                lblSisa.Visible = true;

            //                lbl25.Visible = true;
            //                lblSisa.Visible = true;
            //                lbl40.Visible = true;
            //                gViewTotal25.CssClass = "";
            //                gViewTotalSisa.CssClass = "";
            //                gViewTotal.CssClass = "";
            //            }
            //            else
            //            {
            //                gViewTotal25.DataSource = dt;
            //                gViewTotal25.DataBind();
            //                lbl25.Text = "DATA PENERIMA INSENTIF DAN PAJAK YANG DIPOTONG GRADASI 25 %)";
            //                lbl25.Visible = true;
            //                lblSisa.Visible = false;
            //                lbl40.Visible = false;
            //                gViewTotal25.CssClass = "";
            //                gViewTotal.CssClass = "hide";
            //                gViewTotalSisa.CssClass = "hide";
            //            }
            //            grade = Convert.ToInt32(dt.Rows[0].ItemArray[10]);
            //            foreach (DataRow dr in dt.Rows)
            //            {
            //                Amount25 += Convert.ToDouble(dr[7].ToString());
            //                TaxAmount25 += Convert.ToDouble(dr[9].ToString());
            //                NetAmount25 += Convert.ToDouble(dr[8].ToString());
            //                TaxProcent25 += Convert.ToDecimal(dr[11].ToString());
            //            }
            //            gViewTotal25.FooterRow.Cells[2].Text = string.Format("{0:n}", TaxProcent25);
            //            gViewTotal25.FooterRow.Cells[3].Text = string.Format("{0:n}", TaxProcent25);
            //            gViewTotal25.FooterRow.Cells[11].Text = string.Format("{0:n}", Amount25);
            //            gViewTotal25.FooterRow.Cells[12].Text = string.Format("{0:n}", TaxAmount25);
            //            gViewTotal25.FooterRow.Cells[13].Text = string.Format("{0:n}", NetAmount25);
            //            if (txtRefundPercen.Text != "0")
            //            {
            //                lblTotalAB.Text = Convert.ToString(Amount25);
            //                lblTotalTaxAB.Text = Convert.ToString(TaxAmount25);
            //                lblTotalNetAB.Text = Convert.ToString(NetAmount25);
            //            }
            //        }
            //    }
            //    catch(Exception ex)
            //    {
            //        if (ex.Message == "There is no row at position 0.")
            //        {
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Contract Doesn't Have Refund Recipient');", true);
            //        }
            //        else
            //        {
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert(" + ex.Message + ");", true);
            //        }
            //    }
            //}
        }
        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            RefundNet = txtRefundNet.Text;
            RefundGross = txtRefund.Text;
            getGrid();
        }
        protected void gView25_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            //int i;
            //i = 0;
            //try
            //{
            //    SaveInterest();
            //    if (SaveStatus == true && Convert.ToInt32(Session["GridInt" + Session["UName"]].ToString()) > 0)
            //    {
            //        TextBox lblGrossTotal = gViewTotal.FooterRow.FindControl("lblGrossTotal") as TextBox;
            //        TextBox lblAmountTotal01 = gViewTotal.FooterRow.FindControl("lblTotalAmount") as TextBox;
            //        TextBox lblAmountTotal02 = gViewTotal25.FooterRow.FindControl("lblTotalAmount") as TextBox;
            //        if (Convert.ToDecimal(txtRefundPercen.Text) <= 25)
            //        {
            //            lblGrossTotal.Text = txtRefundPercen.Text;
            //            lblAmountTotal01.Text = txtRefund.Text;
            //        }
            //        if (Convert.ToDecimal(lblGrossTotal.Text) == decimal.Round(Convert.ToDecimal(txtRefundPercen.Text), 2))
            //        {
            //            if (Math.Round(Convert.ToDecimal(lblAmountTotal01.Text), 0) == Convert.ToDecimal(txtRefund.Text) || lblAmountTotal01.Text == txtRefundNet.Text)
            //            {
            //                string RefundNet = txtRefundNet.Text;
            //                string RefundGross = txtRefund.Text;
            //                string RefundPercen = txtRefundPercen.Text;
            //                string Contract = txtContractNum.Text;

            //                clsSaveTransaction SaveHeader = new clsSaveTransaction();

            //                if (SaveHeader.SaveAdminFeeHD(Contract, RefundNet, RefundGross, RefundPercen) == true)
            //                {
            //                    if (Convert.ToDecimal(txtRefundPercen.Text) > 25)
            //                    {
            //                        foreach (GridViewRow row in gViewTotal.Rows)
            //                        {
            //                            i += 1;
            //                            TextBox txtNet = row.FindControl("txtNet") as TextBox;
            //                            TextBox txtGross = row.FindControl("txtGross") as TextBox;
            //                            TextBox lblGross = row.FindControl("lblGross") as TextBox;
            //                            TextBox lblAmountTotal = row.FindControl("lblAmountTotal") as TextBox;
            //                            TextBox lblTaxAmount = row.FindControl("lblTaxAmountTotal") as TextBox;
            //                            TextBox lblNetAmountTotal = row.FindControl("lblNetAmountTotal") as TextBox;
            //                            string TaxType = row.Cells[14].Text;
            //                            string NPWP = row.Cells[15].Text; ;

            //                            string strRecipientCode = row.Cells[4].Text;
            //                            double strRecipientId = Convert.ToDouble(row.Cells[5].Text);
            //                            decimal Net;
            //                            if (txtNet.Text != "")
            //                            {
            //                                Net = Convert.ToDecimal(txtNet.Text);
            //                            }
            //                            else
            //                            {
            //                                Net = 0;
            //                            }
            //                            decimal Gross;
            //                            if (txtGross.Text != "")
            //                            {
            //                                Gross = Convert.ToDecimal(txtGross.Text);
            //                            }
            //                            else
            //                            {
            //                                Gross = 0;
            //                            }
            //                            decimal GrossNet = Convert.ToDecimal(lblGross.Text);
            //                            decimal Amount = Convert.ToDecimal(lblAmountTotal.Text);
            //                            decimal TaxAmount = Convert.ToDecimal(lblTaxAmount.Text);
            //                            decimal NetAmount = Convert.ToDecimal(lblNetAmountTotal.Text);
            //                            clsSaveTransaction cSave = new clsSaveTransaction();
            //                            if (cSave.SaveAdminFee(i, txtContractNum.Text, "A", strRecipientId, strRecipientCode, Net, Gross,
            //                                                   GrossNet, Amount, TaxAmount, NetAmount, TaxType, NPWP) == true)
            //                            {
            //                                if (Convert.ToDecimal(txtRefundPercen.Text) > 25)
            //                                {
            //                                    GridViewRow row25;
            //                                    row25 = gViewTotal25.Rows[i - 1];
            //                                    decimal lblGross25 = Convert.ToDecimal(row25.Cells[2].Text);
            //                                    decimal lblAmountTotal25 = Convert.ToDecimal(row25.Cells[11].Text);
            //                                    decimal lblTaxAmount25 = Convert.ToDecimal(row25.Cells[12].Text);
            //                                    decimal lblNetAmountTotal25 = Convert.ToDecimal(row25.Cells[13].Text);

            //                                    decimal GrossNet25 = Convert.ToDecimal(lblGross25);
            //                                    decimal Amount25 = Convert.ToDecimal(lblAmountTotal25);
            //                                    decimal TaxAmount25 = Convert.ToDecimal(lblTaxAmount25);
            //                                    decimal NetAmount25 = Convert.ToDecimal(lblNetAmountTotal25);

            //                                    if (cSave.SaveAdminFee(i, txtContractNum.Text, "B", strRecipientId, strRecipientCode, 0, 0,
            //                                                   GrossNet25, Amount25, TaxAmount25, NetAmount25, TaxType, NPWP) == true)
            //                                    {
            //                                        GridViewRow rowSisa;
            //                                        rowSisa = gViewTotalSisa.Rows[i - 1];
            //                                        TextBox lblGrossSisa = rowSisa.FindControl("lblGrossMurniTotal25") as TextBox;
            //                                        decimal GrossNetSisa;
            //                                        GrossNetSisa = Convert.ToDecimal(lblGrossSisa.Text);
            //                                        decimal AmountSisa = Amount - Amount25;
            //                                        decimal TaxAmountSisa = TaxAmount - TaxAmount25;
            //                                        decimal NetAmountSisa = NetAmount - NetAmount25;

            //                                        if (AmountSisa == 0 || AmountSisa < 1)
            //                                        {
            //                                            AmountSisa = 0;
            //                                            TaxAmountSisa = 0;
            //                                            NetAmountSisa = 0;
            //                                        }
            //                                        if (cSave.SaveAdminFee(i, txtContractNum.Text, "C", strRecipientId, strRecipientCode, 0, 0,
            //                                                   GrossNetSisa, AmountSisa, TaxAmountSisa, NetAmountSisa, TaxType, NPWP) == true)
            //                                        {

            //                                        }
            //                                    }
            //                                }
            //                                else
            //                                {

            //                                }
            //                            }
            //                            else
            //                            {
            //                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Saved Data,Please Contact Administrator');", true);
            //                            }
            //                        }

            //                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
            //                    }
            //                    else
            //                    {
            //                        foreach (GridViewRow row25B in gViewTotal25.Rows)
            //                        {
            //                            i += 1;
            //                            string strRecipientCode = row25B.Cells[4].Text;
            //                            double strRecipientId = Convert.ToDouble(row25B.Cells[5].Text);
            //                            decimal lblGross25 = Convert.ToDecimal(row25B.Cells[2].Text);
            //                            decimal lblAmountTotal25 = Convert.ToDecimal(row25B.Cells[11].Text);
            //                            decimal lblTaxAmount25 = Convert.ToDecimal(row25B.Cells[12].Text);
            //                            decimal lblNetAmountTotal25 = Convert.ToDecimal(row25B.Cells[13].Text);
            //                            string TaxType = row25B.Cells[14].Text; ;
            //                            string NPWP = row25B.Cells[15].Text; ;

            //                            decimal GrossNet25 = Convert.ToDecimal(lblGross25);
            //                            decimal Amount25 = Convert.ToDecimal(lblAmountTotal25);
            //                            decimal TaxAmount25 = Convert.ToDecimal(lblTaxAmount25);
            //                            decimal NetAmount25 = Convert.ToDecimal(lblNetAmountTotal25);
            //                            clsSaveTransaction cSave = new clsSaveTransaction();
            //                            if (cSave.SaveAdminFee(i, txtContractNum.Text, "A", strRecipientId, strRecipientCode, 0, 0,
            //                                           GrossNet25, Amount25, TaxAmount25, NetAmount25, TaxType, NPWP) == true)
            //                            {

            //                            }

            //                        }
            //                    }
            //                    new clsSearchCtr().SaveState = 1;
            //                    btnPrint.Enabled = true;
            //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
            //                }
            //                else
            //                {
            //                    new clsSearchCtr().SaveState = 0;
            //                    btnPrint.Enabled = false;
            //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Data, because Unbalance Total');", true);
            //                }
            //            }
            //        }
            //        else
            //        {
            //            new clsSearchCtr().SaveState = 0;
            //            btnPrint.Enabled = false;
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Data, because Unbalance Total');", true);
            //            clsSaveTransaction cDel = new clsSaveTransaction();
            //            cDel.DelAdminFee(txtContractNum.Text);
            //            cDel.DelInterest(txtContractNum.Text);
            //        }
            //    }
            //    else if (SaveStatus == true)
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Interest Refund Already Saved');", true);
            //        btnPrint.Enabled = true;
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Interest Refund');", true);
            //    }

            //}
            //catch
            //{
            //    new clsSearchCtr().SaveState = 0;
            //    btnPrint.Enabled = false;
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('There is an error, please Contact Administrator');", true);
            //    clsSaveTransaction cDel = new clsSaveTransaction();
            //    cDel.DelAdminFee(txtContractNum.Text);
            //    cDel.DelInterest(txtContractNum.Text);
            //}
        }
        protected void gViewTotal_DataBound(object sender, EventArgs e)
        {
            ((TextBox)gViewTotal.FooterRow.FindControl("lblTotalAmount")).Attributes.Add("readonly", "readonly");
            ((TextBox)gViewTotal.FooterRow.FindControl("lblGrossTotal")).Attributes.Add("readonly", "readonly");
        }
        protected void gViewTotalSisa_RowCreated(object sender, GridViewRowEventArgs e)
        {

        }
        protected void txtRefundPercen_TextChanged(object sender, EventArgs e)
        {

        }
        protected void gViewTotal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ((TextBox)e.Row.FindControl("lblGross")).Attributes.Add("readonly", "readonly");
                ((TextBox)e.Row.FindControl("lblAmountTotal")).Attributes.Add("readonly", "readonly");
                ((TextBox)e.Row.FindControl("lblTaxAmountTotal")).Attributes.Add("readonly", "readonly");
                ((TextBox)e.Row.FindControl("lblNetAmountTotal")).Attributes.Add("readonly", "readonly");
            }
        }
        protected void gViewTotal25_RowCreated(object sender, GridViewRowEventArgs e)
        {
             
        }
        protected void gViewTotal25_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex >= 0)
            {
                ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[7] = string.Format("{0:n}", ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[7]);
                ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[8] = string.Format("{0:n}", ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[8]);
                ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[18] = string.Format("{0:n}", ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[18]);
                ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[19] = string.Format("{0:n}", ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[19]);
            }

        }
        protected void btnPrint_Click(object sender, EventArgs e)
        {
            string str;
            str = "window.open('http://172.172.100.10/Reportserver?%2fADMINFEE%2fAFTransaction&rs:Command=Render&ContNo=" + Session["contractNo" + Session["UName"]].ToString() + "')";
            ScriptManager.RegisterStartupScript(this,this.GetType(),"popup",str,true);
        }
        private void GetRefundBunga()
        {
            //DataTable dt = new clsCalculate().getRefundBunga(Session["contractNo" + Session["UName"]].ToString());
            //if (dt.Rows.Count > 0)
            //{
            //    gViewInterest.DataSource = dt;
            //}
            //else
            //{
            //    gViewInterest.DataSource = dt;
            //}
            //gViewInterest.DataBind();
        }
        private void SaveInterest()
        {
            //clsSaveTransaction cSave = new clsSaveTransaction();
            //try
            //{
            //    if (gViewInterest.Rows.Count > 0)
            //    {
            //        foreach (GridViewRow row in gViewInterest.Rows)
            //        {
            //            string strRecipientCode = row.Cells[0].Text;
            //            double strRecipientId = Convert.ToDouble(row.Cells[1].Text);
            //            decimal lblAmount = Convert.ToDecimal(row.Cells[7].Text);
            //            decimal lblTaxAmount = Convert.ToDecimal(row.Cells[8].Text);
            //            decimal lblNetAmountTotal = Convert.ToDecimal(row.Cells[9].Text);
            //            string TaxType = row.Cells[10].Text;
            //            string NPWP = row.Cells[11].Text;

            //            SaveStatus = cSave.SaveInterest(txtContractNum.Text, strRecipientId, strRecipientCode, lblAmount, lblTaxAmount, lblNetAmountTotal, TaxType, NPWP);
            //            if (SaveStatus == false)
            //            {
            //                break;
            //            }
            //        }
            //        if (SaveStatus == false)
            //        {
            //            cSave.DelInterest(txtContractNum.Text);
            //        }
            //    }
            //    else
            //    {
            //        SaveStatus = true;
            //    }
            //}
            //catch
            //{
            //    SaveStatus = false;
            //    cSave.DelInterest(txtContractNum.Text);
            //}
        }
    }
}
