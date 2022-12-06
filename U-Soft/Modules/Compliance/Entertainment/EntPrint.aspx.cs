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
using USoft.Compliance.Entertainment;
using USoft.Globalization.Classes;

namespace USoft.Modules.Compliance.Entertainment
{
    public partial class EntPrint : System.Web.UI.Page
    {
        private string dtFrom;
        private string dtTo;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                ControlBindingHelper.BindMyDropDownListAsBranch(ddlBranch, true);
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Recapitulation Entertainment";
            ucHeaderPage.CssClass = "divHeader2";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                Label lblMaxPage = (Label)this.CtrlPager.FindControl("lblMaxRow");
                Label lblCurrPage = (Label)this.CtrlPager.FindControl("lblCurrent");
                Button btnNext = (Button)this.CtrlPager.FindControl("btnNext");
                Button btnPrev = (Button)this.CtrlPager.FindControl("btnPrev");
                lblMaxPage.Text = "0";
                lblCurrPage.Text = "0";
                btnNext.Visible = false;
                btnPrev.Visible = false;
                NextPager(this, EventArgs.Empty);
                int MaxPage = Convert.ToInt16(lblMaxPage.Text);
                btnNext.Visible = MaxPage > 1 ? true : false;
                updPaging.Update();
            }
            catch
            {
            }
        }
        protected void gvPrint_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvPrint_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            string user;
            user = Session["UserName"].ToString();
            dtFrom = dtpickerFrom.Text;
            dtTo = dtpickerTo.Text;
            if (dtFrom == "" || dtFrom == "Click Here") { dtFrom = "1900-01-01"; }
            if (dtTo == "" || dtTo == "Click Here") { dtTo = "2999-01-01"; }
            string ReportPath = USoft.Common.Setting.SystemSetting.ReportPath;
            string str = ReportPath + "FormGiftReport2&rs:Command=Render&StartDate=" + dtFrom + "&EndDate=" + dtTo + "&Branch=" + ddlBranch.SelectedItem.Text + "&Status=" + ddlStatus.Text + "&UserName=" + user;
            str = "window.open(\'" + str + "\')";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", str, true);
        }
        public void NextPager(object sender, EventArgs e)
        {
            GetPager();
        }
        public void PrevPager(object sender, EventArgs e)
        {
            GetPager();
        }
        public void GetPager()
        {
            dtFrom = dtpickerFrom.Text;
            dtTo = dtpickerTo.Text;
            if (dtFrom == "" || dtFrom == "Click Here") { dtFrom = "1900-01-01"; }
            if (dtTo == "" || dtTo == "Click Here") { dtTo = "2999-01-01"; }
            Recap recap = new Recap();
            Label lblCurrPage = (Label)this.CtrlPager.FindControl("lblCurrent");
            Label lblMaxPage = (Label)this.CtrlPager.FindControl("lblMaxRow");
            int CurrPage = Convert.ToInt16(lblCurrPage.Text);
            int MaxPage = Convert.ToInt16(lblMaxPage.Text);
            recap.DateStart = Convert.ToDateTime(dtFrom.ToString());
            recap.EndDate = Convert.ToDateTime(dtTo.ToString());
            recap.Branch = ddlBranch.SelectedItem.Text;
            recap.Status = ddlStatus.Text;
            recap.MaxRow = gvPrint.PageSize;
            recap.RowIndex = 0;
            recap.Type = 1;
            lblCurrPage.Text = Convert.ToString(CurrPage = CurrPage == 0 ? 1 : CurrPage);
            lblMaxPage.Text = Convert.ToString(MaxPage = MaxPage == 0 ? Convert.ToInt16((Convert.ToDouble(recap.SearchTotal()) / gvPrint.PageSize) + 0.5): MaxPage);
            getdata(gvPrint.PageSize * (CurrPage - 1), gvPrint.PageSize * CurrPage);
        }
        private void getdata(int startIndex, int maxIndex)
        {
            try
            {
                Recap recap = new Recap();
                recap.DateStart = Convert.ToDateTime(dtFrom);
                recap.EndDate = Convert.ToDateTime(dtTo);
                recap.Branch = ddlBranch.SelectedItem.Text;
                recap.Status = ddlStatus.Text;
                recap.RowIndex = startIndex;
                recap.MaxRow = maxIndex;
                recap.Type = 0;
                gvPrint.DataSource = recap.Search();
                gvPrint.DataBind();
                updPanel.Update();
            }
            catch
            {
                gvPrint.DataSource = null;
                gvPrint.DataBind();
            }
        }
    }
}
