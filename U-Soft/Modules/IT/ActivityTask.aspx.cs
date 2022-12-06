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

namespace USoft.Modules.IT
{
    public partial class ActivityTask : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                //Binding Filter
                ControlBindingHelper.BindDataSetToCombo(ddlFBranch, "All", "spGetBranchToCombo ''", "BranchId", "BranchName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFItemType, "All", "spGetITItemTypeToCombo ''", "ItemTypeCode", "ItemTypeName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFPIC, "All", "spGetMappingUsersToCombo 'State = 1'", "UserId", "UserName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFTerminatedBy, "All", "spGetMappingUsersToCombo 'State = 1'", "UserId", "UserName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlFProblemType, "All", "spGetITProblemTypeToCombo ''", "ProblemTypeCode", "ProblemTypeName", null);

                ucGridPager.Visible = false;
            }
            else
            {
                lblMessage.Text = "";
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Activity Task";
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
            USoft.DataAccess.Entities.IT.ActivityTask info = new USoft.DataAccess.Entities.IT.ActivityTask();
            USoft.DataAccess.IT.ActivityTask da = new USoft.DataAccess.IT.ActivityTask();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getActivityTask(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvActivityTask.DataSource = ds;
            gvActivityTask.DataBind();
            pnlDataTable.Update();

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void gvActivityTask_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink hypView = new HyperLink();
                
                // View Link
                hypView.Text = e.Row.Cells[0].Text;
                hypView.NavigateUrl = "ActivityTaskDetail.aspx?validate=" + validate(0) + "&editID=" + e.Row.Cells[0].Text + "&state=view";
                hypView.CssClass = "MenuLink";
                e.Row.Cells[0].Controls.Add(hypView);
                
                // reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[10].Controls[2];
                db.OnClientClick = "return confirm('Are you certain you want to delete this Activity Task ?');";
                db.Visible = (e.Row.Cells[7].Text == "0");

                // Reguler Data
                e.Row.Cells[1].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[1].Text);

                Label lblPriority = new Label();
                switch (e.Row.Cells[6].Text)
                {
                    case "0": lblPriority.CssClass = "lblGreen";
                                break;
                    case "1": lblPriority.CssClass = "lblBlue";
                        break;
                    case "2": lblPriority.CssClass = "lblRed";
                        break;
                }
                lblPriority.Text = cf.ActivityPriority(e.Row.Cells[6].Text);
                e.Row.Cells[6].Controls.Add(lblPriority);

                Label lblStatus = new Label();
                switch (e.Row.Cells[7].Text)
                {
                    case "0": lblStatus.CssClass = "lblBlack";
                        break;
                    case "1": lblStatus.CssClass = "lblRed";
                        break;
                    case "2": 
                    case "3": lblStatus.CssClass = "lblBlue";
                        break;
                    case "4": lblStatus.CssClass = "lblGreen";
                        break;
                }
                lblStatus.Text = cf.ActivityStatus(e.Row.Cells[7].Text);
                e.Row.Cells[7].Controls.Add(lblStatus);
            }
        }

        protected void gvActivityTask_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvActivityTask.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("ActivityTaskDetail.aspx?validate=" + validate(1) + "&editID=" + rows.Cells[0].Text + "&state=edit");
            }
        }

        protected void gvActivityTask_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvActivityTask.Rows[e.RowIndex];

            USoft.DataAccess.Entities.IT.ActivityTask info = new USoft.DataAccess.Entities.IT.ActivityTask();
            USoft.DataAccess.IT.ActivityTask da = new USoft.DataAccess.IT.ActivityTask();

            info.ActivityNo = rows.Cells[0].Text;

            lblMessage.Text = da.ActivityTaskDelete(info);
            ShowData();
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            FilterSearch();
        }

        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ActivityTaskAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }

        private void FilterSearch()
        {
            CekSessions.BlockUI(this.Page);
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);

            if (ddlFBranch.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.BranchId = " + ddlFBranch.SelectedValue;               
            }

            if (ddlFProblemType.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.ProblemTypeCode = '" + ddlFProblemType.SelectedValue + "'";
            }

            if (ddlFItemType.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.ItemTypeCode = '" + ddlFItemType.SelectedValue + "'";
            }

            if (ddlFPriority.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.Priority = '" + ddlFPriority.SelectedValue + "'";
            }

            if (ddlFPIC.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.PIC = '" + ddlFPIC.SelectedValue + "'";
            }

            if (ddlFTerminatedBy.SelectedValue != "")
            {
                WhereBy += cf.SqlAndOr(WhereBy, true) + " a.TerminatedBy = '" + ddlFTerminatedBy.SelectedValue + "'";
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
