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

namespace USoft.Modules.Master
{
    public partial class Users : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!IsPostBack)
            {
                //Binding Filter
                ControlBindingHelper.BindDataSetToCombo(ddlFBranch, "All", "spGetBranchToCombo ''", "BranchId", "BranchName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFDepartement, "All", "spGetDepartementToCombo ''", "DepartementCode", "DepartementName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFPrivilege, "All", "spGetPrivilegeToCombo ''", "PrivilegeCode", "PrivilegeName", null);

                ucGridPager.Visible = false;
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Users";
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
            USoft.DataAccess.Entities.Master.Users info = new USoft.DataAccess.Entities.Master.Users();
            USoft.DataAccess.Master.Users da = new USoft.DataAccess.Master.Users();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getUsers(ref info);
            
            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvUsers.DataSource = ds;
            gvUsers.DataBind();

            pnlDataTable.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvUsers.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("UsersAddEdit.aspx?validate=" + validate(0) + "&editID=" + rows.Cells[0].Text + "&state=edit");
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

            if (ddlFBranch.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.BranchId = " + ddlFBranch.SelectedValue;
            }

            if (ddlFDepartement.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " c.DepartementCode = " + ddlFDepartement.SelectedValue;
            } 
            
            if (ddlFPrivilege.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.PrivilegeCode = '" + ddlFPrivilege.SelectedValue + "'";
            }

            ShowData();
            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }
        
        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("UsersAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }
    }
}
