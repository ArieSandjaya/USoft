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
    public partial class ItemTrans : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                //Binding Filter
                ControlBindingHelper.BindDataSetToCombo(ddlFBranchFrom, "All", "spGetBranchToCombo ''", "BranchId", "BranchName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFBranchTo, "All", "spGetBranchToCombo ''", "BranchId", "BranchName", null);
                
                ddlFBranchFrom.Items.Add(new ListItem("Warehouse", "WH"));
                ddlFBranchTo.Items.Add(new ListItem("Warehouse", "WH"));

                ucGridPager.Visible = false;
            }
            else
            {
                lblMessage.Text = "";
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + "Item Transfer";
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

            ds = da.getItemTrans(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvItemTransfer.DataSource = ds;
            gvItemTransfer.DataBind();
            pnlDataTable.Update();
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void gvItemTransfer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink hypView = new HyperLink();
                HyperLink hypDetail = new HyperLink();

                // View Link
                hypView.Text = e.Row.Cells[0].Text;
                hypView.NavigateUrl = "ItemTransDetail.aspx?validate=" + validate(0) + "&state=view&editID=" + e.Row.Cells[0].Text;
                hypView.CssClass = "MenuLink";
                e.Row.Cells[0].Controls.Add(hypView);

                // Action Link
                hypDetail.Text = "Detail";
                hypDetail.NavigateUrl = "ItemTransDetail.aspx?validate=" + validate(0) + "&editID=" + e.Row.Cells[0].Text;
                hypDetail.CssClass = "MenuLink";
                e.Row.Cells[5].Controls.Add(hypDetail);

                // Reguler Data
                e.Row.Cells[1].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[1].Text);
                e.Row.Cells[4].Text = cf.DocStatus(e.Row.Cells[4].Text);
            }
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            FilterSearch();
        }

        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemTransAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }

        private void FilterSearch()
        {
            CekSessions.BlockUI(this.Page);
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);

            if (txtDateTrf.Text != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " CONVERT(VARCHAR(8),a.DateTrans,112) = CONVERT(VARCHAR(8),CONVERT(DATETIME,'" + txtDateTrf.Text + "'),112)";
            }

            if (ddlFBranchFrom.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true);

                if (ddlFBranchFrom.SelectedValue == "WH") // Warehouse
                {
                    WhereBy += " a.BranchId_From IS NULL";
                }
                else
                {
                    WhereBy += " a.BranchId_From = " + ddlFBranchFrom.SelectedValue;
                }
            }

            if (ddlFBranchTo.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true);

                if (ddlFBranchTo.SelectedValue == "WH") // Warehouse
                {
                    WhereBy += " a.BranchId_To IS NULL";
                }
                else
                {
                    WhereBy += " a.BranchId_To = " + ddlFBranchTo.SelectedValue;
                }
            }

            if (ddlFStatus.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.Status = '" + ddlFStatus.SelectedValue + "'";
            }

            ShowData();
            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }
    }
}
