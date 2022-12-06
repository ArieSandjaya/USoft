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
using USoft.Marketing.Master;
using USoft.Common.Shared;
using System.Collections.Generic;
using USoft.Globalization;
using USoft.Globalization.Classes;

namespace USoft.Modules.Marketing.Master
{
    public partial class CashReward_Dealer : System.Web.UI.Page
    {
        private static int ID;

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            if (!IsPostBack)
            {
                gvDealer.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                ControlBindingHelper.BindMyDropDownListAsBrand(ddlBrand, false);
                ControlBindingHelper.BindMyDropDownListAsBrand(ddlAddBrand, false);
                ControlBindingHelper.BindMyDropDownListAsBrand(ddlEditBrandName, false);
                ControlBindingHelper.BindMyDropDownListAsBrand(ddlDeleteBrandName, false);
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Cash Reward Dealer";
            ucHeaderPage.CssClass = "divHeader1";
        }

        //search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ShowMRDealer();
            CekSessions.UnBlockUI(this.Page, this.UpdatePanel1, ScriptManager1);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.unblockUI();", true);
        }
        private void ShowMRDealer()
        {
            CR_Dealer crp = new CR_Dealer();
            DropDownList ddlSearchArea = (DropDownList)CtrlArea3.FindControl("ddlArea");
            gvDealer.DataSource = crp.showMRDealer(TxtSearchDealer.Text, ddlBrand.SelectedItem.Text, ddlSearchArea.SelectedValue);
            gvDealer.DataBind();
            UpdatePanel1.Update();
        }
        protected void gvDealer_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDealer.PageIndex = e.NewPageIndex;
            ShowMRDealer();
        }
        //input
        protected void BtnAddNew_Click(object sender, EventArgs e)
        {
            MpeAddDealer.Show();
        }
        private void AddNewDealer()
        {
            Boolean status;
            CR_Dealer cMR = new CR_Dealer();
            DropDownList ddlArea = (DropDownList)CtrlArea.FindControl("ddlArea");
            string useArea = chkUseArea.Checked == true ? "Y" : "N";
            string updateBy = (string)Session["UserId"];
            status = cMR.MRAddNewDealer(TxtBrandCode.Text, ddlAddBrand.SelectedItem.Text, ddlArea.SelectedValue, TxtDealerCode.Text, TxtDealerName.Text, Convert.ToDecimal(TxtAmount.Text), useArea, updateBy);
            if (status == true)
            {
                TxtBrandCode.Enabled = false;
                ddlAddBrand.Enabled = false; //
                ddlArea.Enabled = false;
                TxtDealerCode.Enabled = false;
                TxtDealerName.Enabled = false;
                TxtAmount.Enabled = false;
                chkUseArea.Enabled = false; //
                btnCreate.Enabled = false;
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
                AppMessage.SetMessage(this.Page, "Data Already Saved");
                UpdatePanel1.Update();
            }
            else
            {
                AppMessage.SetMessage(this.Page, "Cannot Save Data");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Data');", true);
            }
        }
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            AddNewDealer();
        }
        protected void ImageButton_Close_Click(object sender, ImageClickEventArgs e)
        {
            TxtBrandCode.Enabled = true;
            TxtBrandCode.Text = "";
            ddlAddBrand.Enabled = true; //
            DropDownList ddlArea = (DropDownList)CtrlArea.FindControl("ddlArea");
            ddlArea.Enabled = true;
            ddlArea.SelectedValue = "";
            TxtDealerCode.Enabled = true;
            TxtDealerCode.Text = "";
            TxtDealerName.Enabled = true;
            TxtDealerName.Text = "";
            TxtAmount.Enabled = true;
            TxtAmount.Text = "";
            chkUseArea.Enabled = true; //
            chkUseArea.Checked = false; //
            btnCreate.Enabled = true;
            UpdatePanel1.Update();
            MpeAddDealer.Hide();
            ShowMRDealer();
        }
        //edit or delete
        protected void gvDealer_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridViewRow rows2;
                rows2 = gvDealer.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

                ID = Convert.ToInt32(rows2.Cells[0].Text);
                TxtEditBrandCode.Text = rows2.Cells[1].Text;
                ddlEditBrandName.SelectedIndex = ddlEditBrandName.Items.IndexOf(ddlEditBrandName.Items.FindByText(rows2.Cells[2].Text)); //
                DropDownList ddlEditArea = (DropDownList)CtrlArea1.FindControl("ddlArea");
                ddlEditArea.SelectedIndex = ddlEditArea.Items.IndexOf(ddlEditArea.Items.FindByText(rows2.Cells[3].Text));
                TxtEditDealerCode.Text = rows2.Cells[4].Text;
                TxtEditDealerName.Text = rows2.Cells[5].Text;
                TxtEditAmount.Text = rows2.Cells[6].Text;
                string chkUseArea = rows2.Cells[7].Text; //
                if (chkUseArea == "Y") chkEditUseArea.Checked = true; //
                else chkEditUseArea.Checked = false; //
                ddlEditActive.SelectedIndex = ddlEditActive.Items.IndexOf(ddlEditActive.Items.FindByText(rows2.Cells[10].Text));
                UpdatePanelEdit.Update();
                MpeEditDealer.Show();
            }
            else if (e.CommandName == "Delete")
            {
                GridViewRow rows3;
                rows3 = gvDealer.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

                ID = Convert.ToInt32(rows3.Cells[0].Text);
                TxtDeleteBrandCode.Text = rows3.Cells[1].Text;
                ddlDeleteBrandName.SelectedIndex = ddlDeleteBrandName.Items.IndexOf(ddlDeleteBrandName.Items.FindByText(rows3.Cells[2].Text)); //
                DropDownList ddlDeleteArea = (DropDownList)CtrlArea2.FindControl("ddlArea");
                ddlDeleteArea.SelectedIndex = ddlDeleteArea.Items.IndexOf(ddlDeleteArea.Items.FindByText(rows3.Cells[3].Text));
                ddlDeleteArea.Enabled = false;
                TxtDeleteDealerCode.Text = rows3.Cells[4].Text;
                TxtDeleteDealerName.Text = rows3.Cells[5].Text;
                TxtDeleteAmount.Text = rows3.Cells[6].Text;
                string chkUseArea = rows3.Cells[7].Text; //
                if (chkUseArea == "Y") chkEditUseArea.Checked = true; //
                else chkEditUseArea.Checked = false; //
                ddlDeleteActive.SelectedIndex = ddlDeleteActive.Items.IndexOf(ddlDeleteActive.Items.FindByText(rows3.Cells[10].Text));
                UpdatePanelDelete.Update();
                MpeDeleteDealer.Show();
            }
        }
        //edit
        protected void gvDealer_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }
        protected void BtnSave_Click(object sender, EventArgs e)
        {
            EditDealer();
        }
        private void EditDealer()
        {
            Boolean status;
            CR_Dealer crp = new CR_Dealer();
            DropDownList ddlEditArea = (DropDownList)CtrlArea1.FindControl("ddlArea");
            string useArea = chkEditUseArea.Checked == true ? "Y" : "N"; //
            string updateBy = (string)Session["UserId"];

            status = crp.MRSaveEditDealer(ID, TxtEditBrandCode.Text, ddlEditBrandName.SelectedItem.Text, ddlEditArea.SelectedValue, TxtEditDealerCode.Text, TxtEditDealerName.Text, Convert.ToDecimal(TxtEditAmount.Text), useArea, updateBy, ddlEditActive.Text);
            if (status == true)
            {
                TxtEditBrandCode.Enabled = false;
                ddlEditBrandName.Enabled = false; //
                ddlEditArea.Enabled = false;
                TxtEditDealerCode.Enabled = false;
                TxtEditDealerName.Enabled = false;
                TxtEditAmount.Enabled = false;
                chkEditUseArea.Enabled = false; //
                ddlEditActive.Enabled = false;
                BtnSave.Enabled = false;
                UpdatePanel1.Update();
                AppMessage.SetMessage(this.Page, "Data Already Updated");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
                
            }
            else
            {
                AppMessage.SetMessage(this.Page, "Cannot Update Data");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Data');", true);
            }
        }
        protected void ImgBtnEdit_Close_Click(object sender, ImageClickEventArgs e)
        {
            TxtEditBrandCode.Enabled = true;
            ddlEditBrandName.Enabled = true; //
            DropDownList ddlEditArea = (DropDownList)CtrlArea1.FindControl("ddlArea");
            ddlEditArea.Enabled = true;
            TxtEditDealerCode.Enabled = true;
            TxtEditDealerName.Enabled = true;
            TxtEditAmount.Enabled = true;
            chkEditUseArea.Enabled = true; //
            ddlEditActive.Enabled = true;
            BtnSave.Enabled = true;
            UpdatePanel1.Update();
            MpeEditDealer.Hide();
            ShowMRDealer();
        }
        //delete
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            DeleteDealer();
            CekSessions.UnBlockUI(this.Page, this.UpdatePanel1, ScriptManager1);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.unblockUI();", true);
        }
        private void DeleteDealer()
        {
            CR_Dealer crd = new CR_Dealer();
            if (crd.MRDeleteDealer(ID) == true)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Has been Delete');", true);
                AppMessage.SetMessage(this.Page, "Data Has been Delete");
                MpeDeleteDealer.Hide();
                ShowMRDealer();
            }
            else
            {
                AppMessage.SetMessage(this.Page, "Cannot Delete Data");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Delete Data');", true);
            }
        }
        protected void gvDealer_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
        protected void imgBtnDel_Close_Click(object sender, ImageClickEventArgs e)
        {
            MpeDeleteDealer.Hide();
        }
        

    }
}
