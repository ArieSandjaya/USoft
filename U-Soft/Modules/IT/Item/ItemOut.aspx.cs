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
using USoft.Common.Shared;
using USoft.Common.CommonFunction;
using USoft.Globalization;
using USoft.DataAccess;
using USoft.Globalization.Classes;

namespace USoft.Modules.IT.Item
{
    public partial class ItemOut : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                //Binding Filter
                ControlBindingHelper.BindDataSetToCombo(ddlFBranch, "All", "spGetBranchToCombo ''", "BranchId", "BranchName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFType, "All", "spGetITItemTypeToCombo ''", "ItemTypeCode", "ItemTypeName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFCondition, "All", "spGetITConditionToCombo ''", "ConditionCode", "ConditionName", null);

                ddlFBranch.Items.Add(new ListItem("Warehouse", "WH"));

                ucGridPager.Visible = false;
            }
            else
            {
                lblMessage.Text = "";
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Item Out";
            ucHeaderPage.CssClass = "divHeader1";

            ucSearch.PageID = validate(1);
            ucSearch.SearchTitleText = "Search";
            ucSearch.SearchTitleCssClass = "divHeader2";

            ddlSearchBy = (DropDownList)ucSearch.FindControl("ddlFieldSearch");
            txtSearchBy = (TextBox)ucSearch.FindControl("txtFieldSearch");
        }

        private void ShowData()
        {
            DataSet ds = new DataSet();
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getItemOut(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvItemOut.DataSource = ds;
            gvItemOut.DataBind();
            pnlDataTable.Update();
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void gvItemOut_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink hypView = new HyperLink();
                HyperLink hypDetail = new HyperLink();

                //// View Link
                //hypView.Text = e.Row.Cells[0].Text;
                //hypView.NavigateUrl = "ItemOutAddEdit.aspx?validate=" + validate(0) + "&state=view&editID=" + e.Row.Cells[0].Text;
                //hypView.CssClass = "MenuLink";
                //e.Row.Cells[0].Controls.Add(hypView);

                // Action Link
                hypDetail.Text = "Detail";
                hypDetail.NavigateUrl = "ItemOutAddEdit.aspx?validate=" + validate(0) + "&state=edit&editID=" + e.Row.Cells[0].Text;
                hypDetail.CssClass = "MenuLink";
                e.Row.Cells[10].Controls.Add(hypDetail);

                // Reguler Data
                e.Row.Cells[1].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[1].Text);
                e.Row.Cells[6].Text = cf.ItemStatusOut(e.Row.Cells[6].Text);
                e.Row.Cells[9].Text = cf.DocStatus(e.Row.Cells[9].Text);
            }
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            FilterSearch();
        }

        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemOutAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }

        private void FilterSearch()
        {
            CekSessions.BlockUI(this.Page);
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);

            if (txtDateOut.Text != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " CONVERT(VARCHAR(8),a.Date,112) = CONVERT(VARCHAR(8),CONVERT(DATETIME,'" + txtDateOut.Text + "'),112)";
            }

            if (ddlFBranch.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true);

                if (ddlFBranch.SelectedValue == "WH") // Warehouse
                {
                    WhereBy += " a.BranchId IS NULL";
                }
                else
                {
                    WhereBy += " a.BranchId = " + ddlFBranch.SelectedValue;
                }
            }

            if (ddlFType.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " d.ItemTypeCode = '" + ddlFType.SelectedValue + "'";
            }

            if (ddlFOutStatus.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.StatusOut = '" + ddlFOutStatus.SelectedValue + "'";
            }

            if (ddlFCondition.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.ConditionCode = " + ddlFCondition.SelectedValue;
            }

            if (ddlFRepairStatus.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.RepairStatus = '" + ddlFRepairStatus.SelectedValue + "'";
            }

            if (ddlFDocStatus.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.Status = '" + ddlFDocStatus.SelectedValue + "'";
            }

            ShowData();
            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }
    }
}
