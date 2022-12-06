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
using USoft.Compliance.Entertainment;
using USoft.Globalization;
using USoft.Common.Security;

namespace USoft.Modules.Compliance.Entertainment
{
    public partial class EntPage : USoft.Modules.PageBase
    {        
        private static string action;
        private static string KeyId;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            
            if (!IsPostBack)
            {
                ControlBindingHelper.BindMyDropDownListAsEntCompany(ddlCompanyNa, true, true);
                ControlBindingHelper.BindMyDropDownListAsBranch(ddlBranch, true);
                ControlBindingHelper.BindMyDropDownListAsEntDept(ddlDept, true);
                action = Request["action"];
                KeyId = Request["KeyId"];
                CekSessions.SessionStatus(this.Page);
                //hdUserName.Value = CekSessions.getUserId();
                if (action == "Edit")
                {
                    disableField();
                    ShowEditData();
                    hdAction.Value = "Edit";
                }
                else
                {
                    Session["keyId"] = null;
                    hdAction.Value = "New";
                    trRegulerSudden.Attributes.Clear();
                    trTotalAmount.Attributes.Clear();
                    trEstimated.Attributes.Clear();
                    trRegulerSudden.Attributes.Add("class", "hide");
                    txtCounterPartyAddOthers.Attributes.Add("class", "hide");
                    txtTotalAmount.Attributes.Add("class", "validate[condRequired[txtOffer]] text-input");
                    txtEstBudget.Attributes.Add("class", "validate[condRequired[txtAcceptance]] text-input");
                    trTotalAmount.Attributes.Add("class", "hide");
                    txtCountpartyType.Attributes.Add("class", "validate[condRequired[txtCounterParty]] text-input hide");
                    //txtCountpartyType.Attributes.Add("class","");
                }
            }
        }
        private void LoadControl()
        {
            //ucHeaderPage.Text = "Entertainment & Gift Application";
            //ucHeaderPage.CssClass = "divHeader2";
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            {
                try
                {
                    int cekSum = 0;
                    decimal procentage1;
                    decimal procentage2;
                    decimal procentage3;
                    string cPartyName;
                    procentage1 = TxtPercentage1.Text == "" ? 0 : Convert.ToDecimal(TxtPercentage1.Text);
                    procentage2 = TxtPercentage2.Text == "" ? 0 : Convert.ToDecimal(TxtPercentage2.Text);
                    procentage3 = TxtPercentage3.Text == "" ? 0 : Convert.ToDecimal(TxtPercentage3.Text);
                    if (rdCounterparty.SelectedIndex == 0)
                    {
                        cPartyName = txtCounterPartyAddOthers.Text;
                    }
                    else
                    {
                        cPartyName = txtCountpartyType.Text;
                    }
                    int ORrece1;
                    if (ChkOriReceiptAttach.Checked == true)
                    {
                        ORrece1 = 1;
                    }
                    else
                    {
                        ORrece1 = 0;
                    }
                    if (ddlBranch.Text == "Please Select")
                    {
                        cekSum += 1;
                        return;
                    }
                    if (ddlDept.Text == "Please Select")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You Must Choose A Departement')", true);
                        cekSum += 1;
                        return;
                    }

                    if (ddlCompanyNa.Text == "Please Select")
                        if (rdCounterparty.SelectedIndex == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You Must Choose A Dealer')", true);
                            cekSum += 1;
                            return;
                        }
                    if (procentage1 + procentage2 + procentage3 > 100)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Percentage not more than 100%')", true);
                        cekSum += 1;
                        return;
                    }
                    if (cekSum == 0)
                    {
                        CekSessions.BlockUI(this.Page, this.UpdatePanel2, ScriptManager1);
                        SaveEntertainment SaveEntertainment = new SaveEntertainment();
                        SaveEntertainment.AppName = TxtApplName.Text;
                        SaveEntertainment.BankName = TxtBankName.Text;
                        SaveEntertainment.AccName = TxtAccName.Text;
                        SaveEntertainment.AccNo = TxtAccNo.Text;
                        SaveEntertainment.Branch = ddlBranch.SelectedItem.ToString();
                        SaveEntertainment.AcceptanceOffer = rdAcceptanceOffer.Text;
                        SaveEntertainment.LineBussines = txtLineBussines.Text;
                        SaveEntertainment.CounterParty = rdCounterparty.SelectedIndex;
                        SaveEntertainment.CPartyName = cPartyName;
                        SaveEntertainment.Purpose = txtPurpose.Text;
                        SaveEntertainment.Events = RdEvents.SelectedIndex;
                        SaveEntertainment.Place = txtPlace.Text;
                        SaveEntertainment.Date = datepicker.Text;
                        SaveEntertainment.Time = txtTime.Text;
                        SaveEntertainment.OurAttendee = txtOurAttendee.Text;
                        SaveEntertainment.CounterAttendee = txtCounterAttendee.Text;
                        SaveEntertainment.EstBudget = txtEstBudget.Text == "" ? 0 : Convert.ToDecimal(txtEstBudget.Text);
                        SaveEntertainment.TotalAmount = txtTotalAmount.Text == "" ? 0 : Convert.ToDecimal(txtTotalAmount.Text);
                        SaveEntertainment.Reason = txtReason.Text;
                        SaveEntertainment.ReceiptNo = txtReceiptNo.Text;
                        SaveEntertainment.Participant1 = TxtParticipant1.Text;
                        SaveEntertainment.Percentage1 = procentage1;
                        SaveEntertainment.Participant2 = TxtParticipant2.Text;
                        SaveEntertainment.Percentage2 = procentage2;
                        SaveEntertainment.Participant3 = TxtParticipant3.Text;
                        SaveEntertainment.Percentage3 = procentage3;
                        SaveEntertainment.AntiSocialCheck = rdAntiSocialCheck.SelectedIndex;
                        SaveEntertainment.ReasonAnti = txtReasonAnti.Text;
                        SaveEntertainment.UserName = Session["UserName"].ToString();
                        SaveEntertainment.Dept = ddlDept.Text;
                        SaveEntertainment.RegulerSudden = rdlRegulerSudden.Text;
                        SaveEntertainment.CompanyJPN = TxtCompanyJPN.Text;
                        SaveEntertainment.Comments = TxtComments.Text;
                        SaveEntertainment.OriReceipt = ORrece1;
                        SaveEntertainment.InputDate = DateTime.Now.ToString("M/d/yyyy");
                        if (hdAction.Value == "New")
                        {
                            string[] arr = SaveEntertainment.Save();
                            lblNo.Text = arr[0].ToString();
                            Session["keyId"] = arr[1].ToString();
                        }
                        else
                        {
                            SaveEntertainment.KeyId =  Convert.ToInt16(Session["keyId"].ToString());
                            SaveEntertainment.Edit();
                        }
                    }
                    btnSave.Enabled = false;
                    btnPrint.Enabled = true;
                    CekSessions.UnBlockUI(this.Page, this.UpdatePanel2, ScriptManager1);
                    AppMessage.SetMessage(this.Page,this.UpdatePanel2,ScriptManager1,"Data Already Saved");
                    UpdatePanel2.Update();
                }
                catch(Exception ex)
                {
                    CekSessions.UnBlockUI(this.Page, this.UpdatePanel2, ScriptManager1);
                    AppMessage.SetMessage(this.Page,this.UpdatePanel2,ScriptManager1,ex.Message);
                }
            }
        }
        protected void btnPrint_Click1(object sender, EventArgs e)
        {
            string keyId;
            string user;
            keyId = Session["keyId"].ToString();
            user = Session["UserName"].ToString();
            string ReportPath = USoft.Common.Setting.SystemSetting.ReportPath;
            string str = ReportPath + "PrintFormGiftUsoft&rs:Command=Render&keyId=" + keyId + "&username=" + user;
            str = "window.open(\'" + str + "\')";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", str, true);
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            
        }
        private void ShowEditData()
        {
            Session["keyId"] = KeyId;
            SearchHistory.KeyId = KeyId;
            DataRow dr = SearchHistory.SearchEdit();
            lblNo.Text = dr["Nomor"].ToString();
            rdAcceptanceOffer.SelectedIndex = dr["AcceptanceOffer"].ToString() == "Acceptance" ? 0 : 1;
            if (dr["AcceptanceOffer"].ToString() == "Offer")
            {
                trRegulerSudden.Attributes.Clear();
                trRegulerSudden.Attributes.Add("CssClass", "show");
            }
            else
            {
                trTotalAmount.Attributes.Clear();
                trTotalAmount.Attributes.Add("class", "show");
            }
            rdlRegulerSudden.SelectedIndex = dr["EntertainmentType"].ToString() == "Reguler" ? 0 : 1;
            if ((dr["EntertainmentType"].ToString() == "Reguler" ? 0 : 1) == 0)
            {
                txtAcceptance.Value = "Acceptance";
                trTotalAmount.Attributes.Clear();
                trTotalAmount.Attributes.Add("class", "show");
                trEstimated.Attributes.Clear();
                trEstimated.Attributes.Add("class", "show");
                txtEstBudget.Attributes.Add("class", "validate[required,funcCall[CekAmount]] text-input");
                txtTotalAmount.Attributes.Add("class", "validate[required,funcCall[CekAmount]] text-input");
            }
            else
            {
                txtOffer.Value = "Offer";
                trTotalAmount.Attributes.Clear();
                trTotalAmount.Attributes.Add("class", "show");
                trEstimated.Attributes.Clear();
                trEstimated.Attributes.Add("class", "hide");
            }
            TxtApplName.Text = dr["ApplName"].ToString();
            TxtBankName.Text = dr["BankName"].ToString();
            TxtAccNo.Text = dr["AccNo"].ToString();
            TxtAccName.Text = dr["AccName"].ToString();
            ddlBranch.ClearSelection();
            ddlBranch.Items.FindByText(dr["Branch"].ToString().ToUpper()).Selected = true;
            ddlDept.ClearSelection();
            ddlDept.Items.FindByValue(dr["dept"].ToString().ToUpper()).Selected = true;
            TxtCompanyJPN.Text = dr["companyJPN"].ToString();
            rdCounterparty.SelectedIndex = Convert.ToInt16(dr["CountPartyType"].ToString());
            if (Convert.ToInt16(dr["CountPartyType"].ToString()) == 0)
            {
                ddlCompanyNa.ClearSelection();
                if (ddlCompanyNa.Items.FindByText(dr["CountpartyName"].ToString()) != null)
                {
                    ddlCompanyNa.Items.FindByText(dr["CountpartyName"].ToString()).Selected = true;
                    txtCounterPartyAddOthers.Attributes.Clear();
                    txtCounterPartyAddOthers.Attributes.Add("class", "hide");
                    txtCounterParty.Value = dr["CountpartyName"].ToString();
                    txtCountpartyType.Attributes.Add("class", "validate[condRequired[txtCounterParty]] text-input hide");
                }
                else
                {
                    ddlCompanyNa.Items.FindByText("Not In The Lists...").Selected = true;
                    txtCounterPartyAddOthers.Attributes.Clear();
                    txtCountpartyType.Attributes.Clear();
                    txtCounterPartyAddOthers.Attributes.Add("class", "show");
                    txtCounterParty.Attributes.Add("class", "hide");
                    txtCountpartyType.Attributes.Add("class", "validate[condRequired[txtCounterParty]] text-input");
                }
            }
            if (Convert.ToInt16(dr["CountPartyType"].ToString()) == 0)
            { 
                txtCounterPartyAddOthers.Text = dr["CountpartyName"].ToString();
                ddlCompanyNa.CssClass = "show";
            }
            else if (Convert.ToInt16(dr["CountPartyType"].ToString()) == 1)
            {
                txtCountpartyType.Text = dr["CountpartyName"].ToString();
                ddlCompanyNa.CssClass = "hide";
            }
            else
            {
                txtCounterPartyAddOthers.CssClass = "hide";
                txtCounterParty.Value = dr["CountpartyName"].ToString();
                txtCountpartyType.Text = dr["CountpartyName"].ToString();
                txtCounterParty.Attributes.Add("class", "show");
                ddlCompanyNa.CssClass = "hide";
            }
            txtLineBussines.Text = dr["BussinessLine"].ToString();
            txtPurpose.Text = dr["Purpose"].ToString();
            RdEvents.SelectedIndex = Convert.ToInt16(dr["EventItems"].ToString());
            txtPlace.Text = dr["Place"].ToString();
            datepicker.Text = dr["Datetime"].ToString();
            txtTime.Text = dr["Time"].ToString();
            txtOurAttendee.Text = dr["OurAtt"].ToString();
            txtCounterAttendee.Text = dr["CountPartyAtt"].ToString();
            txtEstBudget.Text = dr["EstimatedBgt"].ToString();
            txtTotalAmount.Text = dr["TotalAmount"].ToString();
            txtReason.Text = dr["ReasonExceedingBgt"].ToString();
            txtReceiptNo.Text = dr["OriReceiptNo"].ToString();
            ChkOriReceiptAttach.Checked = Convert.ToBoolean(dr["OriReceiptAttach"].ToString());
            TxtParticipant1.Text = dr["Participant1"].ToString();
            TxtParticipant2.Text = dr["Participant2"].ToString();
            TxtParticipant3.Text = dr["Participant3"].ToString();
            TxtPercentage1.Text = dr["Percentage1"].ToString();
            TxtPercentage2.Text = dr["Percentage2"].ToString();
            TxtPercentage3.Text = dr["Percentage3"].ToString();
            rdAntiSocialCheck.SelectedIndex = Convert.ToInt16(dr["AntiSocialCheck"].ToString());
            txtAnti.Value = dr["AntiSocialCheck"].ToString();
            txtReasonAnti.Text = dr["ReasonAntiSocialCheck"].ToString();
            TxtComments.Text = dr["comments"].ToString();
            UpdatePanel2.Update();
        }
        private void disableField()
        {
            if (FormSecurity.isUpdateAllowed(Session["UserId"].ToString() + '~' + validate(0)) == false)
            {
                TxtApplName.Enabled = false;
                TxtBankName.Enabled = false;
                TxtAccName.Enabled = false;
                TxtAccNo.Enabled = false;
                rdAcceptanceOffer.Enabled = false;
                rdlRegulerSudden.Enabled = false;
                txtLineBussines.Enabled = false;
                rdCounterparty.Enabled = false;
                ddlCompanyNa.Enabled = false;
                txtCounterPartyAddOthers.Enabled = false;
                txtPurpose.Enabled = false;
                RdEvents.Enabled = false;
                txtPlace.Enabled = false;
                datepicker.Enabled = false;
                txtTime.Enabled = false;
                txtOurAttendee.Enabled = false;
                txtCounterAttendee.Enabled = false;
                txtEstBudget.Enabled = false;
                txtReasonAnti.Enabled = false;
                TxtParticipant1.Enabled = false;
                TxtParticipant2.Enabled = false;
                TxtParticipant3.Enabled = false;
                TxtPercentage1.Enabled = false;
                TxtPercentage2.Enabled = false;
                TxtPercentage3.Enabled = false;
                rdAntiSocialCheck.Enabled = false;
                ddlBranch.Enabled = false;
                ddlDept.Enabled = false;
                TxtCompanyJPN.Enabled = false;
            }
        }
    }
}
