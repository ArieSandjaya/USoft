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

namespace USoft.Modules.Compliance.Terorist
{
    public partial class HighRiskCountry : Classes.BasePageSearch
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
            DataAccess.Entities.Compliance.HRiskCountry domain = new DataAccess.Entities.Compliance.HRiskCountry();
            DataAccess.Compliance.HRiskCountry SQLDomain = new DataAccess.Compliance.HRiskCountry();
            WhereIs = cf.SearchList(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            domain.MyQuery = "HIGH_RISK_COUNTRY_GET";
            domain.WhereIs = WhereIs;
            domain.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            domain.PageSize = PagingSize;
            
           this.SearchData(domain,SQLDomain,"GetHRiskCountryLists", this.gvInsentif,this.ucGridPager);
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
    }
}
