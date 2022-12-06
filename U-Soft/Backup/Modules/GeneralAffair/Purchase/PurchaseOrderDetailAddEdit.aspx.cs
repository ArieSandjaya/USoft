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

using USoft.Globalization;
using USoft.Globalization.Classes;
using USoft.Common.CommonFunction;
using USoft.DataAccess;

namespace USoft.Modules.GeneralAffair.Purchase
{
    public partial class PurchaseOrderDetailAddEdit : USoft.Modules.PageBase
    {
        // Property
        public string SupplierCode
        {
            set { ViewState["SupplierCode"] = value; }
            get { return ViewState["SupplierCode"].ToString(); }
        }
        public string CurrencyCode
        {
            set { ViewState["CurrencyCode"] = value; }
            get { return ViewState["CurrencyCode"].ToString(); }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                lblOrderID.Text = editID;
                LoadAllData();

                if (this.state == "add")
                {
                    
                }
                else
                {
                    //
                    //FormState();
                }
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Purchase Order Detail";
            ucHeaderPage.CssClass = "divHeader1";

            ucSearch.PageID = "115101";
            ucSearch.SearchTitleText = "Search";
            ucSearch.SearchTitleCssClass = "divHeader2";

            ddlSearchBy = (DropDownList)ucSearch.FindControl("ddlFieldSearch");
            txtSearchBy = (TextBox)ucSearch.FindControl("txtFieldSearch");
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.OrderId = editID;

            da.getPurchaseOrderView(ref info);

            lblOrderDate.Text = cf.DateFormatDDMMYYYY(info.OrderDate);
            lblSupplier.Text = info.SupplierName;
            lblCurrency.Text = info.CurrencyCode;

            SupplierCode = info.SupplierCode;
            CurrencyCode = info.CurrencyCode;
            CreatedBy = info.CreatedBy;
        }


        private void LoadDataDetail()
        {
            DataSet ds = new DataSet();
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            // Validation Data
            WhereBy += cf.SqlAndOr(WhereBy, true) +
                        " (a.Status = 'A')" +
                        " AND (ISNULL(a.OrderId,'') = '')" +
                        " AND (a.SupplierCode = '" + SupplierCode + "')" +
                        " AND (a.CurrencyCode = '" + CurrencyCode + "')" +
                        " AND (a.RequestId NOT IN (SELECT RequestId FROM GA_POrderDtl WITH(NOLOCK) WHERE OrderId = '" + editID + "'))";

            info.WhereBy = WhereBy;
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getPurchase(ref info, 1);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvPurchase.DataSource = ds;
            gvPurchase.DataBind();
        }

        private void LoadAllData()
        {
            LoadData();
            LoadDataDetail();
        }

        protected void gvPurchase_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Reguler Data
                e.Row.Cells[1].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[1].Text);
                e.Row.Cells[4].Text = cf.NumberFormatDecimal(e.Row.Cells[4].Text);

                // reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[5].Controls[0];
                db.OnClientClick = "return confirm('Are you certain you want to select this Purchase Request ?');";
            }
        }

        protected void gvPurchase_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string KeyId = gvPurchase.Rows[e.NewEditIndex].Cells[0].Text;
            if (ProcessData(KeyId))
            {
                LoadAllData();
            }
            pnlDataForm.Update();
        }

        protected bool ProcessData(string RequestId)
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.OrderId = editID;
            info.RequestId = RequestId;
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.PurchaseOrderDetailInsert(info);

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            LoadDataDetail();
            pnlDataTable.Update();
        }

        protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        {
            ucGridPager.PageNo = 1;
            WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);
            LoadDataDetail();
            pnlDataTable.Update();
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PurchaseOrderDetail.aspx?validate=" + validate(0) + "&from=" + from + "&editID=" + editID);
        }
    }
}
