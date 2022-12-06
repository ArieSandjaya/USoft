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

namespace USoft.Popup
{
    public partial class CashRewardRecipients : Classes.LookupPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            if (!IsPostBack)
            {
                ProcessQueryString();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Cash Reward Recipients";
            ucHeaderPage.CssClass = "divHeader1";

            //ucSearch.PageID = validate(1);
            //ucSearch.SearchTitleText = "Search";
            //ucSearch.SearchTitleCssClass = "divHeader2";

            //ddlSearchBy = (DropDownList)ucSearch.FindControl("ddlFieldSearch");
            //txtSearchBy = (TextBox)ucSearch.FindControl("txtFieldSearch");
        }

        protected void gvCashRewardRecipient_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvInsentif.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Select")
            {
                //Response.Redirect("CashRewardPerApplDetail.aspx?validate=" + validate(0) + "&editID=" + rows.Cells[0].Text + "&state=edit");
            }
        }

        protected void gvCashRewardRecipient_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }
        protected override void ShowData()
        {
            DataAccess.Entities.Marketing.CashRewardDetail domain = new DataAccess.Entities.Marketing.CashRewardDetail();
            DataAccess.Marketing.CashReward SQLDomain = new DataAccess.Marketing.CashReward();
            //WhereIs = cf.SearchList(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            WhereIs = "";
            domain.MyQuery = "test_Detail";
            domain.WhereIs = WhereIs;
            domain.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            domain.PageSize = PagingSize;

            this.SearchData(domain, SQLDomain, "getCashRewardRecipients", this.gvCashRewardRecipient, this.ucGridPager);
        }
    }
}
