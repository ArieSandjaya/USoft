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
    public partial class PurchaseReceivedDetail : USoft.Modules.PageBase
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
            ucHeaderPage.Text = "Purchase Received Detail";
            ucHeaderPage.CssClass = "divHeader1";

            ucHeaderDetail.Text = "Received Detail";
            ucHeaderDetail.CssClass = "divHeader2";

            ucHeaderItemDetail.Text = "Item Order Detail";
            ucHeaderItemDetail.CssClass = "divHeader2";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedId = editID;

            da.getPurchaseReceivedView(ref info);

            lblReceivedID.Text = info.ReceivedId;
            lblReceivedDate.Text = cf.DateFormatDDMMYYYY(info.ReceivedDate);
            lblOrderID.Text = info.OrderId;
            lblOrderDate.Text = cf.DateFormatDDMMYYYY(info.OrderDate);
            lblSupplier.Text = info.SupplierName;
            lblCurrency.Text = info.CurrencyCode;
            lblPIC.Text = info.PIC;
            lblDescription.Text = info.Description;
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

            info.ReceivedId = editID;
            info.WhereBy = "";

            gvPurchaseDetail.DataSource = da.getPurchaseReceivedDetail(info);
            gvPurchaseDetail.DataBind();
        }

        private void LoadDataItemDetail()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.RequestId = "%";
            info.WhereBy = editID;

            gvPurchaseItemDetail.DataSource = da.getPurchaseRequestDetail(info, 3);
            gvPurchaseItemDetail.DataBind();
        }

        private void LoadAllData()
        {
            LoadData();
            LoadDataDetail();
            LoadDataItemDetail();
        }

        protected void gvPurchaseDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[9].Controls[2];
                db.OnClientClick = "return confirm('Are you certain you want to delete this Purchase Received Detail ?');";
            }
        }

        protected void gvPurchaseDetail_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvPurchaseDetail.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("PurchaseReceivedDetailAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&editDetailID=" + rows.Cells[0].Text + "&state=edit");
            }
        }

        protected void gvPurchaseDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvPurchaseDetail.Rows[e.RowIndex];

            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedId = editID;
            info.ReceivedDetailId = rows.Cells[0].Text;

            lblMessage.Text = da.PurchaseReceivedDetailDelete(info);
            LoadAllData();
        }
        
        protected void gvPurchaseItemDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Reguler Data
                //e.Row.Cells[7].Text = cf.NumberFormatDecimal(e.Row.Cells[7].Text);

                // reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[8].Controls[0];
                db.OnClientClick = "return confirm('Select this Purchase Request Detail ?');";

                if (Convert.ToDouble(e.Row.Cells[5].Text) <= Convert.ToDouble(e.Row.Cells[7].Text))
                {
                    db.Visible = false;
                }
            }
        }

        protected void gvPurchaseItemDetail_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string KeyId = gvPurchaseItemDetail.Rows[e.NewEditIndex].Cells[0].Text;
            if (ProcessDataDetail(KeyId))
            {
                LoadAllData();
            }
            pnlDataPage.Update();
        }

        private bool ProcessDataItem()
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();
            bool returnVal = true;

            info.ReceivedId = editID;
            info.InputBy = Session["UserId"].ToString();

            foreach (TableRow tr in gvPurchaseDetail.Rows)
            {
                TextBox txtQty = (TextBox)tr.FindControl("txtQty");

                info.ReceivedDetailId = tr.Cells[0].Text;
                info.Quantity = Convert.ToDouble(txtQty.Text);

                lblMessage.Text = da.PurchaseReceivedDetailUpdate(info);

                if (lblMessage.Text != "Process Success")   // Prevent Multiple Add
                {
                    returnVal = false; 
                    break;
                }
            }

            return returnVal;
        }

        private bool ProcessDataDetail(string RequestDetailId)
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedId = editID;
            info.RequestDetailId = RequestDetailId;
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.PurchaseReceivedDetailInsert(info);

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        private bool ProcessData(string Status)
        {
            USoft.DataAccess.Entities.General_Affair.Purchase info = new USoft.DataAccess.Entities.General_Affair.Purchase();
            USoft.DataAccess.General_Affair.Purchase da = new USoft.DataAccess.General_Affair.Purchase();

            info.ReceivedId = editID;
            info.Status = Status;
            info.ApprovalState = enUI.State;
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.PurchaseReceivedUpdateStatus(info);

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
            string MailSubject = "U-Soft - Purchase Received #" + editID + " (" + cf.DocStatus(Status) + ")";
            string MailBody = "U-Soft - Purchase Received<br /><br />Received ID : " + editID + "<br /><br />";
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
                MailSubject = "U-Soft - Purchase Received #" + editID + " (" + cf.DocStatus("X") + ")";
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
            LoadData(); 
            LoadAllData();
            FormState();
            lblMessage.Text += SendEmail(enUI.State);
            pnlDataPage.Update();
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

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessDataItem())
            {
                LoadAllData();
            }

            LoadData();
            FormState();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PurchaseReceived.aspx?validate=" + validate(0));
        }

        protected void imbEditHeader_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PurchaseReceivedAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&from=detail");
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

            gvPurchaseDetail.Columns[9].Visible = false;
            gvPurchaseItemDetail.Columns[8].Visible = false;
            trItemDetail.Visible = false;                
            
            if ((Status == "D") && (CreatedBy == enUI.UserId))
            {
                imbRFA.Visible = !fromApprove;
                imbEditHeader.Visible = !fromApprove;
                gvPurchaseDetail.Columns[9].Visible = !fromApprove;
                gvPurchaseItemDetail.Columns[8].Visible = !fromApprove;
                trItemDetail.Visible = !fromApprove;
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
