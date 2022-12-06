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

namespace USoft.Modules.IT.Master
{
    public partial class ItemType : USoft.Modules.PageBase
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
            ucHeaderPage.Text = "IT Item Type";
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
            USoft.DataAccess.Entities.IT.Master.ItemType info = new USoft.DataAccess.Entities.IT.Master.ItemType();
            USoft.DataAccess.IT.Master.ItemType da = new USoft.DataAccess.IT.Master.ItemType();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getITItemType(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvITItemType.DataSource = ds;
            gvITItemType.DataBind();
            pnlDataTable.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        private void FilterSearch()
        {
            CekSessions.BlockUI(this.Page);
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            
            ShowData();
            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            FilterSearch();
        }

        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemTypeAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }

        protected void gvITItemType_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvITItemType.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("ItemTypeAddEdit.aspx?validate=" + validate(0) + "&editID=" + rows.Cells[0].Text + "&state=edit");
            }
        }
    }
}