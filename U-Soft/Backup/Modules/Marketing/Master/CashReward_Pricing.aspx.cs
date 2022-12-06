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

namespace USoft.Modules.Marketing.Master
{
    public partial class CashReward_Pricing : System.Web.UI.Page
    {
        private static string Tipe;
        private static string BrandCd;
        private static string Area;////
        private static int Tenor;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            if (!IsPostBack)
            {
                gvPricing.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                //gvPricing.DataSource = EmptyData();
                //gvPricing.DataBind();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Cash Reward Pricing";
            ucHeaderPage.CssClass = "divHeader1";
        }

        //search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ShowCRPricing();
            CekSessions.UnBlockUI(this.Page, this.UpdatePanel1, ScriptManager1);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.unblockUI();", true);
        }
        private void ShowCRPricing()
        {
            CR_Pricing crp = new CR_Pricing();
            DropDownList ddlSearchArea = (DropDownList)CtrlArea.FindControl("ddlArea");
            DropDownList ddlSearchTenor = (DropDownList)CtrlTenor.FindControl("ddlTenor");
            gvPricing.DataSource = crp.getCRPricing(TxtSearchBrandCode.Text, ddlSearchArea.SelectedItem.Value, ddlSearchTenor.SelectedItem.Value);
            gvPricing.DataBind();
            UpdatePanel1.Update();
        }
        protected void gvPricing_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPricing.PageIndex = e.NewPageIndex;
            ShowCRPricing();
        }
        //input
        protected void BtnAddNew_Click(object sender, EventArgs e)
        {
            MpeAddPricing.Show();
        }       
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            AddNewPricing();
        }
        private void AddNewPricing()
        {
            Boolean status;
            CR_Pricing crp = new CR_Pricing();
            DropDownList ddlArea = (DropDownList)CtrlArea1.FindControl("ddlArea");
            DropDownList ddlTenor = (DropDownList)CtrlTenor1.FindControl("ddlTenor");
            string useArea = chkUseArea.Checked == true ? "Y" : "N";
            string updateBy = (string)Session["UserId"];

            status = crp.MRAddNewPricing(TxtType.Text, TxtBrandCode.Text, ddlArea.SelectedValue, ddlTenor.SelectedValue, Convert.ToDecimal(TxtAdminfee.Text), Convert.ToDecimal(TxtFlatInputAddm.Text), Convert.ToDecimal(TxtFlatInputAddb.Text), useArea, updateBy);
            if (status == true)
            {
                TxtType.Enabled = false;
                TxtBrandCode.Enabled = false;
                ddlArea.Enabled = false;
                ddlTenor.Enabled = false;
                TxtAdminfee.Enabled = false;
                TxtFlatInputAddm.Enabled = false;
                TxtFlatInputAddb.Enabled = false;
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
        protected void ImageButton_Close_Click(object sender, ImageClickEventArgs e)
        {
            //clear form
            TxtType.Enabled = true;
            TxtType.Text = "";
            TxtBrandCode.Enabled = true;
            TxtBrandCode.Text = "";
            DropDownList ddlArea = (DropDownList)CtrlArea1.FindControl("ddlArea");
            ddlArea.Enabled = true;
            ddlArea.SelectedValue = "";
            DropDownList ddlTenor = (DropDownList)CtrlTenor1.FindControl("ddlTenor");
            ddlTenor.Enabled = true;
            ddlTenor.SelectedValue = "";
            TxtAdminfee.Enabled = true;
            TxtAdminfee.Text = "";
            TxtFlatInputAddm.Enabled = true;
            TxtFlatInputAddm.Text = "";
            TxtFlatInputAddb.Enabled = true;
            TxtFlatInputAddb.Text = "";
            chkUseArea.Enabled = true; //
            chkUseArea.Checked = false; //
            UpdatePanel1.Update();
            MpeAddPricing.Hide();
            ShowCRPricing();
        }
        //edit or delete
        protected void gvPricing_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "Edit")
            {
                DropDownList ddlEditArea = (DropDownList)CtrlArea2.FindControl("ddlArea");
                DropDownList ddlEditTenor = (DropDownList)CtrlTenor2.FindControl("ddlTenor");
                GridViewRow rows;
                rows = gvPricing.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

                Tipe = rows.Cells[0].Text;
                BrandCd = rows.Cells[1].Text;
                Area = rows.Cells[2].Text;
                Tenor = Convert.ToInt32(rows.Cells[3].Text);

                TxtEditType.Text = rows.Cells[0].Text;
                TxtEditBrandCode.Text = rows.Cells[1].Text;
                ddlEditArea.SelectedIndex = ddlEditArea.Items.IndexOf(ddlEditArea.Items.FindByText(rows.Cells[2].Text));
                ddlEditTenor.SelectedIndex = ddlEditTenor.Items.IndexOf(ddlEditTenor.Items.FindByText(rows.Cells[3].Text));
                TxtEditAdminfee.Text = rows.Cells[4].Text;
                TxtEditFlatInputAddm.Text = rows.Cells[5].Text;
                TxtEditFlatInputAddb.Text = rows.Cells[6].Text;
                string chkUseArea = rows.Cells[7].Text; //
                if (chkUseArea == "Y") chkEditUseArea.Checked = true; //
                else chkEditUseArea.Checked = false; //
                ddlEditActive.SelectedIndex = ddlEditActive.Items.IndexOf(ddlEditActive.Items.FindByText(rows.Cells[10].Text));
                UpdatePanelEdit.Update();
                MpeEditPricing.Show();
            }
            else if(e.CommandName == "Delete")
            {
                DropDownList ddlDeleteArea = (DropDownList)CtrlArea3.FindControl("ddlArea");
                DropDownList ddlDeleteTenor = (DropDownList)CtrlTenor3.FindControl("ddlTenor");
                GridViewRow rowsS;
                rowsS = gvPricing.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

                Tipe = rowsS.Cells[0].Text;
                BrandCd = rowsS.Cells[1].Text;
                Area = rowsS.Cells[2].Text;
                Tenor = Convert.ToInt32(rowsS.Cells[3].Text);

                TxtDeleteType.Text = rowsS.Cells[0].Text;
                TxtDeleteBrandCode.Text = rowsS.Cells[1].Text;
                ddlDeleteArea.SelectedIndex = ddlDeleteArea.Items.IndexOf(ddlDeleteArea.Items.FindByText(rowsS.Cells[2].Text));
                ddlDeleteArea.Enabled = false;
                ddlDeleteTenor.SelectedIndex = ddlDeleteTenor.Items.IndexOf(ddlDeleteTenor.Items.FindByText(rowsS.Cells[3].Text));
                ddlDeleteTenor.Enabled = false;
                TxtDeleteAdminfee.Text = rowsS.Cells[4].Text;
                TxtDeleteFlatInputAddm.Text = rowsS.Cells[5].Text;
                TxtDeleteFlatInputAddb.Text = rowsS.Cells[6].Text;
                string chkUseArea = rowsS.Cells[7].Text; //
                if (chkUseArea == "Y") chkDeleteUseArea.Checked = true; //
                else chkDeleteUseArea.Checked = false; //
                ddlDeleteActive.SelectedIndex = ddlEditActive.Items.IndexOf(ddlEditActive.Items.FindByText(rowsS.Cells[10].Text));
                UpdatePanelDelete.Update();
                MpeDeletePricing.Show();
            }
        }
        //edit
        protected void gvPricing_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }        
        protected void BtnSave_Click(object sender, EventArgs e)
        {
            EditPricing();
        }
        private void EditPricing()
        {
            Boolean status;
            CR_Pricing crp = new CR_Pricing();
            DropDownList ddlEditArea = (DropDownList)CtrlArea2.FindControl("ddlArea");
            DropDownList ddlEditTenor = (DropDownList)CtrlTenor2.FindControl("ddlTenor");
            string useArea = chkEditUseArea.Checked == true ? "Y" : "N"; //
            string updateBy = (string)Session["UserId"];

            status = crp.MRSaveEditPricing(Tipe,BrandCd,Area,Tenor, TxtEditType.Text, TxtEditBrandCode.Text, ddlEditArea.SelectedValue, ddlEditTenor.SelectedValue, Convert.ToDecimal(TxtEditAdminfee.Text), Convert.ToDecimal(TxtEditFlatInputAddm.Text), Convert.ToDecimal(TxtEditFlatInputAddb.Text), useArea, updateBy, ddlEditActive.SelectedValue);
            if (status == true)
            {
                TxtEditType.Enabled = false;
                TxtEditBrandCode.Enabled = false;
                ddlEditArea.Enabled = false;
                ddlEditTenor.Enabled = false;
                TxtEditAdminfee.Enabled = false;
                TxtEditFlatInputAddm.Enabled = false;
                TxtEditFlatInputAddb.Enabled = false;
                chkEditUseArea.Enabled = false; //
                ddlEditActive.Enabled = false;
                BtnSave.Enabled = false;
                UpdatePanel1.Update();
                AppMessage.SetMessage(this.Page, "Data Already Updated");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Has been Updated');", true);
            }
            else
            {
                AppMessage.SetMessage(this.Page, "Cannot Update Data");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Update Data');", true);
            }
        }
        protected void ImgBtnEdit_Close_Click(object sender, ImageClickEventArgs e)
        {
            TxtEditType.Enabled = true;
            TxtEditBrandCode.Enabled = true;
            DropDownList ddlEditArea = (DropDownList)CtrlArea2.FindControl("ddlArea");
            ddlEditArea.Enabled = true;
            DropDownList ddlEditTenor = (DropDownList)CtrlTenor2.FindControl("ddlTenor");
            ddlEditTenor.Enabled = true;
            TxtEditAdminfee.Enabled = true;
            TxtEditFlatInputAddm.Enabled = true;
            TxtEditFlatInputAddb.Enabled = true;
            chkEditUseArea.Enabled = true; //
            ddlEditActive.Enabled = true;
            BtnSave.Enabled = true;
            UpdatePanel1.Update();
            MpeEditPricing.Hide();
            ShowCRPricing();
        }
        //delete
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            DeletePricing();
            CekSessions.UnBlockUI(this.Page, this.UpdatePanel1, ScriptManager1);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.unblockUI();", true);
        }
        private void DeletePricing()
        {
            CR_Pricing crd = new CR_Pricing();

            if (crd.MRDeletePricing(Tipe, BrandCd, Area, Tenor) == true)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Has been Delete');", true);
                AppMessage.SetMessage(this.Page, "Data Has been Deleted");
                MpeDeletePricing.Hide();
                ShowCRPricing();
            }
            else
            {
                AppMessage.SetMessage(this.Page, "Cannot Delete Data");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Delete Data');", true);
            }
        }
        protected void gvPricing_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
        protected void imgBtnDelete_Close_Click(object sender, ImageClickEventArgs e)
        {
            MpeDeletePricing.Hide();
        }
        
    }
}
