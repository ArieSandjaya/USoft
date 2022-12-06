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

namespace USoft.Modules.Marketing.CashReward
{
    public partial class CashRewardPerApplDetail : USoft.Classes.BasePageSearch
    {
        //private string ContractId = editID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                GetHeader();
            }
        }
        private void LoadData()
        {
            //DataAccess.Entities.Marketing.CashReward domain = new DataAccess.Entities.Marketing.CashReward();
            //DataAccess.Marketing.CashReward SQLDomain = new DataAccess.Marketing.CashReward();
            //WhereIs = cf.SearchValue("ContractNumber", editID);
            //domain.MyQuery = "CashRewardGetDetail";
            //domain.WhereIs = WhereIs;
            //domain.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            //domain.PageSize = PagingSize;
            //this.SearchData(domain,SQLDomain,"getCashReward", this.gvCashRewardDetail,this.ucGridPager);
        }
        private void GetHeader()
        {
            DataAccess.Entities.Marketing.CashReward domain = new DataAccess.Entities.Marketing.CashReward();
            DataAccess.Marketing.CashReward SQLDomain = new DataAccess.Marketing.CashReward();
            domain.WhereIs = cf.SearchValue("ContractNumber", editID);
            domain.MyQuery = "CashRewardGetHeader";

            List<KeyValuePair<string, object>> objectCollection = new List<KeyValuePair<string, object>>();
            objectCollection.Add(new KeyValuePair<string, object>("contract_number", lblContractNumber));
            objectCollection.Add(new KeyValuePair<string, object>("CustomerName", lblCustomerName));
            objectCollection.Add(new KeyValuePair<string, object>("brand_name", lblBrandName));
            objectCollection.Add(new KeyValuePair<string, object>("supplier_name", lblSupplierName));
            objectCollection.Add(new KeyValuePair<string, object>("AmountReward", lblAmountReward));
            domain.ObjectCollection = objectCollection;
            this.SearchHeaderData(domain, SQLDomain, "getCashRewardHeader");
        }

        protected void gvInsentif_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
        protected void PagerClick(object sender, EventArgs e)
        {
            LoadData();
        }

        protected void imbAdd_Click(object sender, ImageClickEventArgs e)
        {
            this.pnlData.Visible = false;
            this.pnlDetail.Visible = true;
        }

        protected void Add_Clicked(object sender, EventArgs e)
        {
            string parameter = "ContractNumber";
            string ParamNameList = "ContractNumber";
            string ParamValueList = this.lblContractNumber.Text;
            string ParamTypeList = "System.String";
            callLookupPage("getCashRewardRecipient", "CashRewardRecipients.aspx", ParamNameList, ParamValueList, ParamTypeList);
        }

        protected void Save_Clicked(object sender, EventArgs e)
        {

        }
    }
}
