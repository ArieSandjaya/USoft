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

namespace USoft.Modules.Master
{
    public partial class Branch : USoft.Modules.PageBase
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
            ucHeaderPage.Text = "Branch";
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
            USoft.DataAccess.Entities.Master.Branch info = new USoft.DataAccess.Entities.Master.Branch();
            USoft.DataAccess.Master.Branch da = new USoft.DataAccess.Master.Branch();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getBranch(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvBranch.DataSource = ds;
            gvBranch.DataBind();

            pnlDataTable.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void gvBranch_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvBranch.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("BranchAddEdit.aspx?validate=" + validate(0) + "&editID=" + rows.Cells[0].Text + "&state=edit");
            }
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            ShowData();
        }

        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("BranchAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }
    }
}
