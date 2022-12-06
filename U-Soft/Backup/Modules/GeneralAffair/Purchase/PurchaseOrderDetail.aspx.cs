using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using USoft.Globalization;
using USoft.Common.CommonFunction;
using USoft.DataAccess;

namespace USoft.Modules.GeneralAffair.Purchase
{
    public partial class PurchaseOrderDetail : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                lblMessage.Text = msg;
            }
            else
            {
                lblMessage.Text = "";
            }

            LoadAllData();
            FormState();
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Purchase Order Detail";
            ucHeaderPage.CssClass = "divHeader1";

            ucHeaderDetail.Text = "Request Detail";
            ucHeaderDetail.CssClass = "divHeader2";

            ucHeaderItemDetail.Text = "Item Detail";
            ucHeaderItemDetail.CssClass = "divHeader2";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.OrderId = editID;

            da.getPurchaseOrderView(ref info);

            lblOrderID.Text = info.OrderId;
            lblOrderDate.Text = cf.DateFormatDDMMYYYY(info.OrderDate);
            lblSupplier.Text = info.SupplierName;
            lblCurrency.Text = info.CurrencyCode;
            lblTotal.Text = cf.NumberFormatDecimal(info.Total);
            lblPIC.Text = info.PIC;
            lblDeliveryDate.Text = (info.DeliveryDate.Year.ToString() != "1") ? cf.DateFormatYYYYMMDD(info.DeliveryDate) : "";
            lblDescription.Text = info.Description;
            lblOfferFrom.Text = info.OfferFrom;
            lblOfferNo.Text = info.OfferNo;
            lblOfferDate.Text = (info.OfferDate.Year.ToString() != "1") ? cf.DateFormatYYYYMMDD(info.OfferDate) : "";
            lblCreatedBy.Text = info.CreatedName;
            lblUpdateBy.Text = info.UpdateName;
            lblStatus.Text = cf.DocStatus(info.Status);

            Status = info.Status;
            CreatedBy = info.CreatedBy;
            IsApprove = (info.Status == "A");

            enUI.State = info.ApprovalState;
            enUI.DataBranchId = info.BranchId;
        }

        private void LoadDataDetail()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.OrderId = editID;
            info.WhereBy = "";

            gvPurchaseDetail.DataSource = da.getPurchaseOrderDetail(info);
            gvPurchaseDetail.DataBind();
        }

        private void LoadDataItemDetail()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.RequestId = "%";
            info.WhereBy = editID;

            gvPurchaseItemDetail.DataSource = da.getPurchaseRequestDetail(info,2);
            gvPurchaseItemDetail.DataBind();
        }

        private void LoadAllData()
        {
            LoadData();
            LoadDataDetail();
            LoadDataItemDetail();
        }

        protected void gvPurchaseItemDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Reguler Data
                e.Row.Cells[6].Text = cf.NumberFormatDecimal(e.Row.Cells[6].Text);
                e.Row.Cells[7].Text = cf.NumberFormatDecimal(e.Row.Cells[7].Text);
            }
        }

        private bool ProcessData(string Status)
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.OrderId = editID;
            info.Status = Status;
            info.ApprovalState = enUI.State;
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.PurchaseOrderUpdateStatus(info);

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        private string SendEmail(int StateApproval)
        {
            /* Status
                D = Draft
                R = RFA
                A = Approve
            */

            string SendMailStatus = "";
            string MailSubject = "U-Soft - Purchase Order #" + editID + " (" + cf.DocStatus(Status) + ")";
            string MailBody = "U-Soft - Purchase Order<br /><br />Order ID : " + editID + "<br /><br />";
            List<USoft.DataAccess.Entities.Email> UserMailFrom = new List<USoft.DataAccess.Entities.Email>();
            List<USoft.DataAccess.Entities.Email> UserMailTo = new List<USoft.DataAccess.Entities.Email>();
            List<USoft.DataAccess.Entities.Email> UserMailCC = new List<USoft.DataAccess.Entities.Email>();
            USoft.DataAccess.General.Email da2 = new USoft.DataAccess.General.Email();

            //da2.getUserEmail(ref UserMailFrom, enUI.UserId);
            da2.getMappingApprovalEmailTo(ref UserMailTo, MenuId, StateApproval);
            da2.getMappingApprovalEmailTo(ref UserMailCC, MenuId, StateApproval);
            da2.getUserEmail(ref UserMailTo, CreatedBy);

            if (Status == "D") // Reject
            {
                //StateApproval = 1;
                MailSubject = "U-Soft - Purchase Order #" + editID + " (" + cf.DocStatus("X") + ")";
                MailBody += "Status : " + cf.DocStatus("X");
            }
            else if ((Status == "R") || (Status == "A")) // RFA or Approve
            {
                //StateApproval = 2 ~ 5;
                MailBody += "Status : " + cf.DocStatus(Status);
            }
            SendMailStatus = ", " + da2.sendEmail(UserMailFrom, UserMailTo, UserMailCC, MailSubject, MailBody, true);

            return SendMailStatus;
        }

        private void ResponseProcess()
        {
            LoadAllData();
            FormState();
            lblMessage.Text += SendEmail(enUI.State);
            pnlDataPage.Update();
        }

        protected void gvPurchaseDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Reguler Data
                e.Row.Cells[3].Text = cf.DateFormatDDMMYYYY(e.Row.Cells[3].Text);
                e.Row.Cells[6].Text = cf.NumberFormatDecimal(e.Row.Cells[6].Text);

                // reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[7].Controls[0];
                db.OnClientClick = "return confirm('Are you certain you want to delete this Purchase Request Detail ?');";
            }
        }

        protected void gvPurchaseDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvPurchaseDetail.Rows[e.RowIndex];

            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.OrderId = editID;
            info.OrderDetailId = rows.Cells[0].Text;

            lblMessage.Text = da.PurchaseOrderDetailDelete(info);
            LoadAllData();
        }

        protected void imbRFA_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessData("R"))
            {
                ResponseProcess();
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbApprove_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessData((enUI.State < enUI.MaxState) ? "R" : "A"))
            {
                ResponseProcess();
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbReject_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessData("D"))
            {
                ResponseProcess();
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PurchaseOrder.aspx?validate=" + validate(0));
        }

        protected void imbEditHeader_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PurchaseOrderAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&from=detail");
        }

        protected void imbAddDetail_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PurchaseOrderDetailAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&state=add");
        }

        private void FormState()
        {
            imbRFA.Attributes.Add("onclick", "return confirm('Are you certain you want to Request For Approval ?');");
            imbApprove.Attributes.Add("onclick", "return confirm('Are you certain you want to Approve ?');");
            imbReject.Attributes.Add("onclick", "return confirm('Are you certain you want to Reject ?');");

            imbApprove.Visible = false;
            imbReject.Visible = false;
            imbRFA.Visible = false;
            imbEditHeader.Visible = false;
            imbAddDetail.Visible = false;

            gvPurchaseDetail.Columns[7].Visible = false;

            if ((Status == "D") && (CreatedBy == enUI.UserId))
            {
                imbRFA.Visible = !fromApprove;
                imbEditHeader.Visible = !fromApprove;
                imbAddDetail.Visible = !fromApprove;
                gvPurchaseDetail.Columns[7].Visible = !fromApprove;
            }
            else
            {
                daUI.getApprovalState(ref enUI);

                if ((Status == "R") && (enUI.ApprovalState)) // RFA
                {
                    imbApprove.Visible = true;
                    imbReject.Visible = true;
                }
            }
        }
    }
}
