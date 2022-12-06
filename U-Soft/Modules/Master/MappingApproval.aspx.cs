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
    public partial class MappingApproval : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!IsPostBack)
            {
                ucGridPager.Visible = false;
            }
            else
            {
                lblMessage.Text = "";
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Mapping Approval";
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
            USoft.DataAccess.Entities.Master.MappingApproval info = new USoft.DataAccess.Entities.Master.MappingApproval();
            USoft.DataAccess.Master.MappingApproval da = new USoft.DataAccess.Master.MappingApproval();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getMappingApproval(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvMappingApproval.DataSource = ds;
            gvMappingApproval.DataBind();
            pnlDataTable.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void gvMappingApproval_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[9].Controls[2];
                db.OnClientClick = "return confirm('Are you certain you want to delete this Mapping Approval ?');";
            }
        }

        protected void gvMappingApproval_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvMappingApproval.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("MappingApprovalAddEdit.aspx?validate=" + validate(0) + "&editID=" + rows.Cells[0].Text + "&state=edit");
            }
        }

        protected void gvMappingApproval_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvMappingApproval.Rows[e.RowIndex];

            USoft.DataAccess.Entities.Master.MappingApproval info = new USoft.DataAccess.Entities.Master.MappingApproval();
            USoft.DataAccess.Master.MappingApproval da = new USoft.DataAccess.Master.MappingApproval();

            info.ApprovalId = Convert.ToInt32(rows.Cells[0].Text);

            lblMessage.Text = da.MappingApprovalDelete(info);
            ShowData();
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            ShowData();
        }

        protected void imbAdd_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("MappingApprovalAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }
    }
}
