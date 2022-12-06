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
using USoft.Common.CommonFunction;
using USoft.DataAccess;

namespace USoft.Modules.IT.Item
{
    public partial class ItemDetail : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                //LoadData();
                //LoadDataHistory();
                //imbEdit.Visible = IsActive;

                ucGridPager.Visible = false;
            }
            else
            {
                lblMessage.Text = "";
            }

            LoadData();
            LoadDataHistory();

            imbEdit.Visible = IsActive;
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Item Detail";
            ucHeaderPage.CssClass = "divHeader1";

            ucHeaderHistory.Text = "Item Detail History";
            ucHeaderHistory.CssClass = "divHeader2";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemCode = editID;

            da.getItemView(ref info);

            lblItemCode.Text = info.ItemCode;
            lblItemInDtlCode.Text = info.ItemInDetailCode;
            lblItemTransDtlCode.Text = (info.ItemTransDetailCode != "") ? info.ItemTransDetailCode : "-";
            lblItemOutDtlCode.Text = (info.ItemOutDetailCode != "") ? info.ItemOutDetailCode : "-";
            lblType.Text = info.ItemTypeName;
            lblSerialNo.Text = info.SerialNo;
            lblBarcode.Text = info.Barcode;
            lblDescription.Text = info.Description;
            lblCondition.Text = info.ConditionName;
            lblStatusIn.Text = (info.StatusIn != 0) ? cf.ItemStatusIn(info.StatusIn.ToString()) : "-";
            lblStatusOut.Text = (info.StatusOut != 0) ? cf.ItemStatusOut(info.StatusOut.ToString()) : "-";
            lblBranch.Text = info.BranchName;
            lblUsedBy.Text = (info.UsedBy != "") ? info.UsedBy : "-";
            lblPrivilege.Text = (info.PrivilegeName != "") ? info.PrivilegeName : "-";
            lblIsActive.Text = (info.IsActive == true) ? "Active" : "Non Active";

            IsActive = Convert.ToBoolean(info.IsActive);
        }

        private void LoadDataHistory()
        {
            DataSet ds = new DataSet();
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();
            
            info.ItemCode = editID;
            info.ItemInDetailCode = lblItemInDtlCode.Text;
            
            info.PageNo = (ucGridPager.Visible) ? ucGridPager.PageNo : 1;
            info.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;

            ds = da.getItemHistory(ref info);

            ucGridPager.CurrPage = info.PageNo.ToString();
            ucGridPager.TotalPage = info.TotalPage.ToString();
            ucGridPager.TotalData = info.TotalData.ToString();
            ucGridPager.ButtonState();
            ucGridPager.Visible = (ds.Tables[0].Rows.Count > 0);

            gvItemHistory.DataSource = ds;
            gvItemHistory.DataBind();
            pnlDataTable.Update();
        }

        protected void PagerClick(object sender, EventArgs e)
        {
            LoadDataHistory();
        }

        protected void gvItemHistory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Reguler Data
                e.Row.Cells[0].Text = cf.DateFormatDDMMYYYYTime(e.Row.Cells[0].Text);
            }   
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemList.aspx?validate=" + validate(0));
        }

        protected void imbEdit_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&state=edit");
        }
    }
}
