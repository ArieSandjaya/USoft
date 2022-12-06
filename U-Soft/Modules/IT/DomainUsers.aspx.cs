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

namespace USoft.Modules.IT
{
    public partial class DomainUsers : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!IsPostBack)
            {
                ControlBindingHelper.BindDataSetToCombo(ddlBranch, null, "spGetBranchDomainToCombo ''", "Branch_Code", "Branch_Name", null);
                
                gvDomainUsers.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

                imbUpdate.Visible = false;
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Domain Users";
            ucHeaderPage.CssClass = "divHeader1";

            ucHeaderPage2.Text = "Search";
            ucHeaderPage2.CssClass = "divHeader2";
        }

        private void ShowData()
        {
            //CekSessions.BlockUI(this.Page);

            USoft.DataAccess.Entities.IT.DomainUsers info = new USoft.DataAccess.Entities.IT.DomainUsers();
            USoft.DataAccess.IT.DomainUsers da = new USoft.DataAccess.IT.DomainUsers();

            info.BranchCode = ddlBranch.SelectedValue;

            gvDomainUsers.DataSource = da.getDomainUsers(info);
            gvDomainUsers.DataBind();
            pnlDataTable.Update();

            //CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1); 
        }

        

        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("DomainUsersAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("DomainUsersAddEdit.aspx?validate=" + validate(0) + "&editID=" + ddlBranch.SelectedValue + "&state=edit");
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            FilterSearch();
        }

        private void FilterSearch()
        {
            //CekSessions.BlockUI(this.Page);
            //WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);

            if (ddlBranch.SelectedValue != "")
            {
                WhereBy = " Branch_Code = " + ddlBranch.SelectedValue;
            }

            
            ShowData();
            //CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "imb", "$.unblockUI();", true);

            imbUpdate.Visible = (ddlBranch.SelectedValue != "") ? true : false;
        }
    }
}
