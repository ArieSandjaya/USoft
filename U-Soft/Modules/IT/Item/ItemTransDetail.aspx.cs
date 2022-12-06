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
using USoft.Common.Security;

namespace USoft.Modules.IT.Item
{
    public partial class ItemTransDetail : USoft.Modules.PageBase
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
            ucHeaderPage.Text = "Item Transfer";
            ucHeaderPage.CssClass = "divHeader1";

            ucHeaderDetail.Text = "Item Transfer Detail";
            ucHeaderDetail.CssClass = "divHeader2";

            //ddlSearchBy = (DropDownList)ucSearch.FindControl("ddlFieldSearch");
            //txtSearchBy = (TextBox)ucSearch.FindControl("txtFieldSearch");
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemTransCode = editID;

            da.getItemTransView(ref info);

            lblStatus.Text = cf.DocStatus(info.Status);
            lblItemTransCode.Text = info.ItemTransCode;
            lblBranchFrom.Text = info.BranchNameFrom;
            lblBranchTo.Text = info.BranchNameTo;
            lblTransDate.Text = cf.DateFormatDDMMYYYY(info.TransDate);
            lblCreatedName.Text = info.CreatedName;

            Status = info.Status;
            CreatedBy = info.CreatedBy;
            IsApprove = (info.Status == "A");
            //ApprovalState = info.ApprovalState;

            enUI.State = info.ApprovalState;
            enUI.DataBranchId = info.BranchId;
        }

        private void LoadDataDetail()
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemTransCode = editID;
            info.WhereBy = ""; //WhereBy;

            gvItemTransDetail.DataSource = da.getItemTransDetail(info);
            gvItemTransDetail.DataBind();
        }

        private void LoadAllData()
        {
            LoadData();
            LoadDataDetail();
        }

        protected void gvItemTransDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!IsApprove)
                {
                    //reference the Delete LinkButton
                    LinkButton db = (LinkButton)e.Row.Cells[10].Controls[2];
                    db.OnClientClick = "return confirm('Are you certain you want to delete this Item Detail ?');";
                }
            }
        }

        protected void gvItemTransDetail_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow rows = gvItemTransDetail.Rows[Convert.ToInt32(e.CommandArgument.ToString())];

            if (e.CommandName == "Edit")
            {
                Response.Redirect("ItemTransDetailAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&editDetailID=" + rows.Cells[0].Text + "&state=edit");
            }
        }

        protected void gvItemTransDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvItemTransDetail.Rows[e.RowIndex];

            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemTransCode = editID;
            info.ItemTransDetailCode = rows.Cells[0].Text;

            lblMessage.Text = da.ItemTransDetailDelete(info);
            LoadAllData();
        }

        private bool ProcessData(string Status)
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemTransCode = editID;
            info.Status = Status;
            info.ApprovalState = enUI.State;
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.ItemTransUpdateStatus(info);

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
            string MailSubject = "U-Soft - Item Transfer #" + editID + " (" + cf.DocStatus(Status) + ")";
            string MailBody = "U-Soft - Item Transfer<br /><br />Item Transfer Code : " + editID + "<br /><br />";
            List<USoft.DataAccess.Entities.Email> UserMailFrom = new List<USoft.DataAccess.Entities.Email>();
            List<USoft.DataAccess.Entities.Email> UserMailTo = new List<USoft.DataAccess.Entities.Email>();
            List<USoft.DataAccess.Entities.Email> UserMailCC = new List<USoft.DataAccess.Entities.Email>();
            USoft.DataAccess.General.Email da2 = new USoft.DataAccess.General.Email();

            //da2.getUserEmail(ref UserMailFrom, enUI.UserId);
            da2.getMappingApprovalEmailTo(ref UserMailTo, MenuId, StateApproval);
            da2.getMappingApprovalEmailTo(ref UserMailCC, MenuId, StateApproval);
            //da2.getUserEmail(ref UserMailTo, CreatedBy);

            if (Status == "D") // Reject
            {
                //StateApproval = 0;
                MailSubject = "U-Soft - Item Transfer #" + editID + " (" + cf.DocStatus("X") + ")";
                MailBody += "Status : " + cf.DocStatus("X");
            }
            else if ((Status == "R") || (Status == "A")) // RFA or Approve
            {
                //StateApproval = 1 or 2;
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

            if (ProcessData((enUI.State < (enUI.MaxState - 1)) ? "R" : "A"))
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

        //protected void imbSearch_Click(object sender, ImageClickEventArgs e)
        //{
        //    CekSessions.BlockUI(this.Page);

        //    WhereBy = cf.SearchText(ddlSearchBy.SelectedValue, txtSearchBy.Text);
        //    LoadDataDetail();
        //    pnlDataTable.Update();

        //    CekSessions.UnBlockUI(this.Page, this.pnlDataTable, ScriptManager1);
        //}

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemTrans.aspx?validate=" + validate(0));
        }

        protected void imbEditHeader_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemTransAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&from=detail&state=edit");
        }

        protected void imbAddDetail_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemTransDetailAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&state=add");
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

            gvItemTransDetail.Columns[10].Visible = false;

            if ((Status == "D") && (CreatedBy == enUI.UserId))
            {
                imbRFA.Visible = true;
                imbEditHeader.Visible = true;
                imbAddDetail.Visible = true;
                gvItemTransDetail.Columns[10].Visible = true;
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
