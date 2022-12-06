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
using System.Drawing;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;
using USoft.Globalization;
using USoft.DataAccess;
using USoft.Globalization.Classes;

namespace USoft.Modules.GeneralAffair
{
    public partial class Item : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                //Binding Filter
                ControlBindingHelper.BindDataSetToCombo(ddlFBranch, "All", "spGetBranchToCombo ''", "BranchId", "BranchName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFItemCategory, "All", "spGetGAItemCategoryToCombo ''", "ItemCategoryCode", "ItemCategoryName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFItemGroup, "All", "spGetGAItemGroupToCombo ''", "ItemGroupCode", "ItemGroupName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFItemType, "All", "spGetGAItemTypeToCombo ''", "ItemTypeCode", "ItemTypeName", null);

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
            ucHeaderPage.Text = "Item Warehouse";
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
            USoft.DataAccess.Entities.General_Affair.Item info = new USoft.DataAccess.Entities.General_Affair.Item();
            USoft.DataAccess.General_Affair.Item da = new USoft.DataAccess.General_Affair.Item();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getItem(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvItem.DataSource = ds;
            gvItem.DataBind();
            pnlDataTable.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
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

            if (ddlFItemCategory.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " d.ItemCategoryCode = '" + ddlFItemCategory.SelectedValue + "'";
            }

            if (ddlFItemGroup.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " c.ItemGroupCode = '" + ddlFItemGroup.SelectedValue + "'";
            }

            if (ddlFItemType.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " b.ItemTypeCode = '" + ddlFItemType.SelectedValue + "'";
            }

            ShowData();
            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }
    }
}
