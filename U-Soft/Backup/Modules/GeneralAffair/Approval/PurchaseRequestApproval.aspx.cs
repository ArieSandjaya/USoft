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
using System.Collections.Generic;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;
using USoft.Globalization;
using USoft.DataAccess;
using USoft.Globalization.Classes;

namespace USoft.Modules.GeneralAffair.Approval
{
    public partial class PurchaseRequestApproval : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                ucGridPager.Visible = false;
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Purchase Request Approval";
            ucHeaderPage.CssClass = "divHeader1";

            ucSearch.PageID = validate(1);
            ucSearch.SearchTitleText = "Search";
            ucSearch.SearchTitleCssClass = "divHeader2";

            ddlSearchBy = (DropDownList)ucSearch.FindControl("ddlFieldSearch");
            txtSearchBy = (TextBox)ucSearch.FindControl("txtFieldSearch");
        }

        private void ShowData()
        {
            CekSessions.BlockUI(this.Page);

            DataSet ds = new DataSet();
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getPurchase(ref info, 4);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvPurchase.DataSource = ds;
            gvPurchase.DataBind();

            pnlDataTable.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void gvPurchase_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink hypView = new HyperLink();

                // View Link
                hypView.Text = e.Row.Cells[0].Text;
                hypView.NavigateUrl = "../Purchase/PurchaseRequestDetail.aspx?validate=" + validate(0) + "&state=view&from=approve&editID=" + e.Row.Cells[0].Text;
                hypView.CssClass = "MenuLink";
                e.Row.Cells[0].Controls.Add(hypView);

                // Reguler Data
                e.Row.Cells[1].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[1].Text);
                e.Row.Cells[5].Text = cf.NumberFormatDecimal(e.Row.Cells[5].Text);
                e.Row.Cells[7].Text = cf.DocStatus(e.Row.Cells[7].Text);
            }
        }

        protected void gvPurchase_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvPurchase.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("../Purchase/PurchaseRequestDetail.aspx?validate=" + validate(0) + "&state=edit&from=approve&editID=" + rows.Cells[0].Text);
            }
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            FilterSearch();
        }

        private void FilterSearch()
        {
            CekSessions.BlockUI(this.Page);
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);

            if (ddlFStatus.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.Status = '" + ddlFStatus.SelectedValue + "'";
            }

            ShowData();
            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }
    }
}
