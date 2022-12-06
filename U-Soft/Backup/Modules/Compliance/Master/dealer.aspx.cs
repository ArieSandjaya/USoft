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
using USoft.Compliance.Master;
using System.Collections.Generic;
using USoft.Common.Shared;

namespace USoft.Modules.Compliance.Master
{
    public partial class dealer : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                gvDealer.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                gvDealer.DataSource = EmptyData();
                gvDealer.DataBind();
            }
        }
        private void LoadControl()
        {
            ucHeaderPage.Text = "Edit Dealer";
            ucHeaderPage.CssClass = "divHeader2";
        }
        private DataSet EmptyData()
        {
            List<string> ColumName = new List<string>();
            ColumName.Add("KodeDealer");
            ColumName.Add("NamaDealer");
            ColumName.Add("Status");
            SQLHelper helper = new SQLHelper();
            return helper.EmptyDataSet(ColumName);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetDealer(txtDealerCode.Text, txtDealerName.Text, ucIsActive.Value);
        }

        private void GetDealer(string code, string namaDealer, string status)
        {
            DealerSearch dSearch = new DealerSearch();
            dSearch.NamaDealer = namaDealer;
            dSearch.KodeDealer = code;
            if (status == "") { dSearch.Status = ""; }
            else
            {
                dSearch.Status = (status == "True") ? "1" : "0";
            }
            
            gvDealer.DataSource = dSearch.GetDealer();
            gvDealer.DataBind();
            updPanel.Update();
        }
        protected void gvDealer_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                string kodeDealer = gvDealer.Rows[index].Cells[1].Text;
                string namaDealer = gvDealer.Rows[index].Cells[2].Text;
                CheckBox chk = (CheckBox)gvDealer.Rows[index].FindControl("CheckBox1");
                string status = (chk.Checked) ? "1" : "0";

                Response.Redirect("EditDealer.aspx?KodeDealer=" + kodeDealer +
                                             "&NamaDealer=" + namaDealer +
                                             "&Status=" + status + 
                                             "&mode=edit" + 
                                             "&validate=" + validate(0));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddDealer.aspx");
        }

        protected void gvDealer_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDealer.PageIndex = e.NewPageIndex;
            GetDealer(txtDealerCode.Text, txtDealerName.Text, ucIsActive.Value);
        }
    }
}
