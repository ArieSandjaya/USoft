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

namespace USoft.Modules.Marketing.CashReward
{
    public partial class CashRewardPerAppl : Classes.BasePageSearch
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!Page.IsPostBack)
            {
                ucGridPager.Visible = false;
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Cash Reward";
            ucHeaderPage.CssClass = "divHeader1";

            ucSearch.PageID = validate(1);
            ucSearch.SearchTitleText = "Search";
            ucSearch.SearchTitleCssClass = "divHeader2";

            ddlSearchBy = (DropDownList)ucSearch.FindControl("ddlFieldSearch");
            txtSearchBy = (TextBox)ucSearch.FindControl("txtFieldSearch");
        }

        private void ShowData()
        {
            DataAccess.Entities.Marketing.CashReward domain = new DataAccess.Entities.Marketing.CashReward();
            DataAccess.Marketing.CashReward SQLDomain = new DataAccess.Marketing.CashReward();
            WhereIs = cf.SearchList(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            domain.MyQuery = "CashRewardGetList";
            domain.WhereIs = WhereIs;
            domain.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            domain.PageSize = PagingSize;
            
            this.SearchData(domain,SQLDomain,"getCashReward", this.gvInsentif,this.ucGridPager);
        }
        protected void PagerClick(object sender, EventArgs e)
        {
            ShowData();
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            ShowData();
        }

        protected void gvInsentif_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvInsentif.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("CashRewardPerApplDetail.aspx?validate=" + validate(0) + "&editID=" + rows.Cells[0].Text + "&state=edit");
            }
        }
    }
}
