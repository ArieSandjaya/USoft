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
    public partial class ScheduleTask : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                gvScheduleTaskNext.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                ucGridPager.Visible = false;
            }
            else
            {
                lblMessage.Text = "";
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Schedule Task";
            ucHeaderPage.CssClass = "divHeader1";

            ucSearch.PageID = validate(1);
            ucSearch.SearchTitleText = "Search";
            ucSearch.SearchTitleCssClass = "divHeader2";

            ucHeaderPageNext.Text = "Next Schedule Task";
            ucHeaderPageNext.CssClass = "divHeader1";

            ucHeaderPageData.Text = "List Schedule Task";
            ucHeaderPageData.CssClass = "divHeader1";

            ddlSearchBy = (DropDownList)ucSearch.FindControl("ddlFieldSearch");
            txtSearchBy = (TextBox)ucSearch.FindControl("txtFieldSearch");
        }

        private void ShowData()
        {
            DataSet ds = new DataSet();
            USoft.DataAccess.Entities.IT.ScheduleTask info = new USoft.DataAccess.Entities.IT.ScheduleTask();
            USoft.DataAccess.IT.ScheduleTask da = new USoft.DataAccess.IT.ScheduleTask();

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getScheduleTask(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvScheduleTask.DataSource = ds;
            gvScheduleTask.DataBind();
        }

        private void ShowDataNext()
        {
            USoft.DataAccess.Entities.IT.ScheduleTask info = new USoft.DataAccess.Entities.IT.ScheduleTask();
            USoft.DataAccess.IT.ScheduleTask da = new USoft.DataAccess.IT.ScheduleTask();

            info.WhereBy = WhereBy;

            gvScheduleTaskNext.DataSource = da.getScheduleTaskNext(info);
            gvScheduleTaskNext.DataBind();
        }

        private void ShowDataAll()
        {
            CekSessions.BlockUI(this.Page);

            ShowData();
            ShowDataNext();
            pnlDataTable.Update(); 

            CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void gvScheduleTaskNext_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvScheduleTaskNext.PageIndex = e.NewPageIndex;
            ShowDataAll();
        }

        protected void gvScheduleTask_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //// Reguler Data
                e.Row.Cells[1].Text = cf.ScheduleType(e.Row.Cells[1].Text);
                e.Row.Cells[3].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[3].Text);
                e.Row.Cells[4].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[4].Text);
                e.Row.Cells[7].Text = cf.ScheduleStatus(e.Row.Cells[7].Text);

                //// reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[8].Controls[2];
                db.OnClientClick = "return confirm('Are you certain you want to delete this Schedule Task ?');";
            }
        }

        protected void gvScheduleTaskNext_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //// Reguler Data
                e.Row.Cells[1].Text = cf.ScheduleType(e.Row.Cells[1].Text);
                e.Row.Cells[3].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[3].Text);
                e.Row.Cells[4].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[4].Text);
                e.Row.Cells[7].Text = cf.ScheduleStatus(e.Row.Cells[7].Text);

                //// reference the Finish LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[8].Controls[0];
                db.OnClientClick = "return confirm('Are you certain you want to finish this Schedule Task ?');";
            }
        }

        protected void gvScheduleTask_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvScheduleTask.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("ScheduleTaskAddEdit.aspx?validate=" + validate(0) + "&editID=" + rows.Cells[0].Text + "&state=edit");
            }
        }

        protected void gvScheduleTask_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvScheduleTask.Rows[e.RowIndex];

            USoft.DataAccess.Entities.IT.ScheduleTask info = new USoft.DataAccess.Entities.IT.ScheduleTask();
            USoft.DataAccess.IT.ScheduleTask da = new USoft.DataAccess.IT.ScheduleTask();

            info.ScheduleNo = rows.Cells[0].Text;

            lblMessage.Text = da.ScheduleTaskDelete(info);
            ShowDataAll();
        }

        protected void gvScheduleTaskNext_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvScheduleTaskNext.Rows[e.RowIndex];

            USoft.DataAccess.Entities.IT.ScheduleTask info = new USoft.DataAccess.Entities.IT.ScheduleTask();
            USoft.DataAccess.IT.ScheduleTask da = new USoft.DataAccess.IT.ScheduleTask();

            info.ScheduleNo = rows.Cells[0].Text;

            lblMessage.Text = da.ScheduleTaskFinish(info);
            ShowDataAll();
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            ShowDataAll();
        }

        protected void imbCreate_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ScheduleTaskAddEdit.aspx?validate=" + validate(0) + "&state=add");
        }
    }
}
