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
using USoft.Marketing.AdminFee;
using USoft.Globalization;
using USoft.Common.Security;


namespace USoft.Modules.Marketing
{
    public partial class AdmSearchContract : System.Web.UI.Page
    {
        // Property
        public string validate { get { return Session["UserId"].ToString() + '~' + Request.QueryString["validate"]; } }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                gvContract.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                gvContract.DataSource = Blank();
                gvContract.DataBind();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Admin Search Contract";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private DataSet Blank()
        {
            List<string> ColumName = new List<string>();
            ColumName.Add("Contract_Number");
            ColumName.Add("Name");
            ColumName.Add("Asset_Cost_Amount");
            ColumName.Add("contract_term");
            ColumName.Add("Input");
            ColumName.Add("paid");
            EmptyData DataSource = new EmptyData();
            return DataSource.emptyData(ColumName);
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Label lblMaxPage = (Label)this.CtrlPager1.FindControl("lblMaxRow");
            Label lblCurrPage = (Label)this.CtrlPager1.FindControl("lblCurrent");
            lblMaxPage.Text = "0";
            lblCurrPage.Text = "0";
            NextPager(this, EventArgs.Empty);
            Button btnNext = (Button)this.CtrlPager1.FindControl("btnNext");
            int MaxPage = Convert.ToInt16(lblMaxPage.Text);
            btnNext.Visible = MaxPage > 1 ? true : false;
        }
        public void SearchContract(string value, int startIndex, int maxIndex)
        {
            GetContract DoContract = new GetContract();
            gvContract.DataSource = DoContract.getContract(value, startIndex, maxIndex) ;
            gvContract.DataBind();
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
            GetContract DoContract = new GetContract();
            Label lblCurrPage = (Label)this.CtrlPager1.FindControl("lblCurrent");
            Label lblMaxPage = (Label)this.CtrlPager1.FindControl("lblMaxRow");
            int CurrPage = Convert.ToInt16(lblCurrPage.Text);
            int MaxPage = Convert.ToInt16(lblMaxPage.Text);
            lblCurrPage.Text = Convert.ToString(CurrPage = CurrPage == 0 ? 1 : CurrPage);
            lblMaxPage.Text = Convert.ToString(MaxPage = MaxPage == 0 ? DoContract.getContractCount(txtContractNo.Text) : MaxPage);
            SearchContract(txtContractNo.Text, gvContract.PageSize * (CurrPage - 1), gvContract.PageSize * CurrPage);
        }

        protected void gvContract_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType== DataControlRowType.DataRow)
            {
                Button btnInsert = (Button)e.Row.FindControl("btnInsert");
                Button btnDelete = (Button)e.Row.FindControl("btnDelete");
                Button btnSelect = (Button)e.Row.FindControl("btnSelect");
                if (e.Row.Cells[4].Text == "Y")
                {
                    if (e.Row.Cells[5].Text == "Y")
                    {
                        btnInsert.Enabled = false;
                        btnDelete.Enabled = false;
                        btnSelect.Enabled = FormSecurity.isViewAllowed(validate);
                    }
                    else
                    {
                        btnInsert.Enabled = false;
                        btnDelete.Enabled = FormSecurity.isDeleteAllowed(validate);
                        btnSelect.Enabled = FormSecurity.isViewAllowed(validate);
                    }
                }
                else
                {
                    btnInsert.Enabled = FormSecurity.isInsertAllowed(validate);
                    btnDelete.Enabled = false;
                    btnSelect.Enabled = FormSecurity.isViewAllowed(validate);
                }
            }
        }

        protected void gvContract_DataBound(object sender, EventArgs e)
        {
            
        }

        protected void gvContract_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string ContractNo = gvContract.Rows[e.NewEditIndex].Cells[0].Text;
            Response.Redirect("AdmSearchContractEdit.aspx?ContractNo=" + ContractNo);
        }
    }
}
