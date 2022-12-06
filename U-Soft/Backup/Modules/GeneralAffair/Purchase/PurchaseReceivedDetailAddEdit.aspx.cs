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
    public partial class PurchaseReceivedDetailAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            txtQuantity.Attributes["onkeyup"] = "formatNumber(this);"; 
            
            if (!Page.IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Purchase Received Detail";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedId = editID; 
            info.ReceivedDetailId = editDetailID;

            da.getPurchaseReceivedDetailView(ref info);

            lblRequestID.Text = info.RequestId;
            lblItemCategory.Text = info.ItemCategoryName;
            lblItemGroup.Text = info.ItemGroupName;
            lblItemType.Text = info.ItemTypeName;
            lblRequestQty.Text = cf.NumberFormatDecimal(info.RequestQty);
            lblMeasurementReq.Text = info.MeasurementCode;
            lblCurrentQty.Text = cf.NumberFormatDecimal(info.CurrentQty);
            lblMeasurementCurr.Text = info.MeasurementCode;
            txtQuantity.Text = info.Quantity.ToString();
            lblMeasurementRec.Text = info.MeasurementCode;

            CreatedBy = info.CreatedBy;
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedId = editID;
            info.Quantity = Convert.ToDouble(txtQuantity.Text);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                info.ReceivedDetailId = editDetailID;
                lblMessage.Text = da.PurchaseReceivedDetailUpdate(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        protected void ProcessForm()
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessData("U"))
            {
                LoadData();
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            ProcessForm();
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PurchaseReceivedDetail.aspx?validate=" + validate(0) + "&from=" + from + "&editID=" + editID);
        }
    }
}
