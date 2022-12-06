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
using USoft.Globalization.Classes;
using USoft.Common.CommonFunction;
using USoft.DataAccess;
using USoft.Globalization;
using USoft.Common.Security;

namespace USoft.Modules.IT
{
    public partial class ActivityTaskDetail : USoft.Modules.PageBase
    {
        // Variable Declaration
        bool ReOpen = false;
        bool IsAssign = false;
        string UserRequest; //,UserEmail;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlAssignTo, "- Select One -", "spGetMappingUsersToCombo 'State = 1'", "UserId", "UserName", null); 
                
                LoadData();
                LoadDataDetail();
                trAssignTo.Visible = false;
                trDescription.Visible = false;
                FormState();
                lblMessage.Text = msg;
            }
            else
            {
                lblMessage.Text = "";
            }
        }

        private void LoadControl()
        {
            MenuId = validate(0);
            
            ucHeaderPage.Text = "Activity Task Detail";
            ucHeaderPage.CssClass = "divHeader1";

            ucHeaderForm.Text = "Activity Task Assignment";
            ucHeaderForm.CssClass = "divHeader2";

            ucHeaderGrid.Text = "Assignment History";
            ucHeaderGrid.CssClass = "divHeader2";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.ActivityTask info = new USoft.DataAccess.Entities.IT.ActivityTask();
            USoft.DataAccess.IT.ActivityTask da = new USoft.DataAccess.IT.ActivityTask();

            info.ActivityNo = editID;
            
            da.getActivityTaskView(ref info);

            lblActivityNo.Text = info.ActivityNo;
            lblActivityDate.Text = cf.DateFormatDDMMYYYY(info.ActivityDate);
            lblRequestBy.Text = info.RequestBy;
            //lblEmail.Text = info.Email + "@ufindo.com";
            lblBranchName.Text = info.BranchName;
            lblDepartementName.Text = info.DepartementName;
            lblProblemTypeName.Text = info.ProblemTypeName;
            lblItemTypeName.Text = info.ItemTypeName;
            lblDescription.Text = info.Description;
            lblPriority.Text = cf.ActivityPriority(info.Priority);
            lblStatus.Text = cf.ActivityStatus(info.Status);

            IsAssign = ((info.Status != "") && (info.Status != "0"));
            StatusList();
            if ((Page.IsPostBack) && (info.Status != "0") && (info.Status != "4"))
            {
                ddlStatus.SelectedValue = info.Status;
            }

            UserRequest = info.RequestBy; 
            Status = info.Status;
            IsApprove = (info.Status == "A");
            //UserEmail = info.Email + "@ufindo.com";
            
            enUI.State = info.ApprovalState;
            enUI.DataBranchId = info.BranchId; 
        }

        private void LoadDataDetail()
        {
            USoft.DataAccess.Entities.IT.ActivityTask info = new USoft.DataAccess.Entities.IT.ActivityTask();
            USoft.DataAccess.IT.ActivityTask da = new USoft.DataAccess.IT.ActivityTask();

            info.ActivityNo = editID;
            info.WhereBy = WhereBy;

            gvAssignTask.DataSource = da.getActivityAssign(info);
            gvAssignTask.DataBind();
        }

        private void LoadAllData()
        {
            LoadData();
            LoadDataDetail();
        }

        private bool ProcessData()
        {
            USoft.DataAccess.Entities.IT.ActivityTask info = new USoft.DataAccess.Entities.IT.ActivityTask();
            USoft.DataAccess.IT.ActivityTask da = new USoft.DataAccess.IT.ActivityTask();

            info.ActivityNo = editID;
            info.Status = ddlStatus.SelectedValue;
            info.AssignTo = ddlAssignTo.SelectedValue;
            info.AssignDescription = txtAssignDesc.Text;
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.ActivityAssignInsert(info);

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                Status = info.Status;
                return true;
            }
            return false;
        }

        private bool ProcessDataStatus(string Status)
        {
            USoft.DataAccess.Entities.IT.ActivityTask info = new USoft.DataAccess.Entities.IT.ActivityTask();
            USoft.DataAccess.IT.ActivityTask da = new USoft.DataAccess.IT.ActivityTask();

            info.ActivityNo = editID;
            info.Status = Status;
            info.AssignTo = "";
            info.AssignDescription = "";
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.ActivityAssignInsert(info);

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                this.Status = Status;
                this.ReOpen = (Status == "0");
                return true;
            }
            return false;
        }

        private string SendEmail(int StateApproval)
        {
            /* Status
                0 = Open
                1 = Assign
                2 = Solved
                3 = Closed
                4 = Finish/Done
            */

            string SendMailStatus = "";
            string MailSubject = "U-Soft - Activity Task #" + editID + " (" + cf.ActivityStatus(Status) + ")";
            string MailBody = "U-Soft - Activity Task Notification<br /><br />Activity Task No : " + editID + "<br /><br />";
            List<USoft.DataAccess.Entities.Email> UserMailFrom = new List<USoft.DataAccess.Entities.Email>();
            List<USoft.DataAccess.Entities.Email> UserMailTo = new List<USoft.DataAccess.Entities.Email>();
            List<USoft.DataAccess.Entities.Email> UserMailCC = new List<USoft.DataAccess.Entities.Email>();
            USoft.DataAccess.General.Email da2 = new USoft.DataAccess.General.Email();

            //da2.getUserEmail(ref UserMailFrom, Session["UserId"].ToString());
            da2.getMappingApprovalEmailTo(ref UserMailTo, MenuId, StateApproval);
            da2.getMappingApprovalEmailTo(ref UserMailCC, MenuId, StateApproval);

            if (Status == "0") // Re-Open
            {
                //StateApproval = 0;
                MailBody += "Status : " + (ReOpen ? "RE-OPEN" : "OPEN");
            }
            else if (Status == "1") // Assign
            {
                //StateApproval = 1;
                da2.getUserEmail(ref UserMailTo, ddlAssignTo.SelectedValue);
                MailBody += "Assign To " + ddlAssignTo.SelectedItem.Text;
            }
            else if ((Status == "2") || (Status == "3"))// Solved - Closed
            {
                //StateApproval = 2;
                MailBody += "Status : " + ddlStatus.SelectedItem.Text;
            }
            else if (Status == "4") // Finish
            {
                //StateApproval = 3;
                //UserMailTo.Add(new USoft.DataAccess.Entities.Email(UserRequest, UserEmail.Trim()));
                MailBody += "Status : Done";
            }

            if ((Status == "1") || (Status == "2") || (Status == "3"))
            {
                MailBody += "<br />Description : " + txtAssignDesc.Text;
            }
            SendMailStatus = ", " + da2.sendEmail(UserMailFrom, UserMailTo, UserMailCC, MailSubject, MailBody, true);

            return SendMailStatus;
        }

        protected void gvAssignTask_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Reguler Data
                e.Row.Cells[0].Text = cf.DateFormatDDMMYYYYTime(e.Row.Cells[0].Text);
            }
        }

        protected void imbProcess_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessData())
            {
                ResponseProcess();
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbReOpen_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessDataStatus("0"))
            {
                ResponseProcess();
            }            

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbVerify_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ProcessDataStatus("4"))
            {
                ResponseProcess();
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        private void ResponseProcess()
        {
            FormState();
            LoadAllData();
            lblMessage.Text += SendEmail(enUI.State);
            pnlDataPage.Update();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            trAssignTo.Visible = (ddlStatus.SelectedValue == "1") ? true : false;
            trDescription.Visible = (ddlStatus.SelectedValue == "") ? false :true;
            pnlDataForm.Update();
        }

        protected void imbEditHeader_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ActivityTaskAddEdit.aspx?validate=" + validate(0) + "&editID=" + editID + "&state=edit&from=detail");
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ActivityTask.aspx?validate=" + validate(0));
        }

        private void StatusList()
        {
            ddlStatus.Items.Clear();
            ddlStatus.Items.Add(new ListItem("- Select One -", ""));
            ddlStatus.Items.Add(new ListItem("Assign", "1"));
            if (IsAssign) { ddlStatus.Items.Add(new ListItem("Solved", "2")); }
            ddlStatus.Items.Add(new ListItem("Closed", "3"));
        }

        private void FormState()
        {
            imbReOpen.Attributes.Add("onclick", "return confirm('Are you certain you want to Re-Open ?');");
            imbVerify.Attributes.Add("onclick", "return confirm('Are you certain you want to Verify ?');"); 
            
            imbEditHeader.Visible = false;
            trFormAssign.Visible = false;
            imbReOpen.Visible = false;
            imbVerify.Visible = false;

            if ((Status == "0") || (Status == "1")) // Open - Assign
            {
                imbEditHeader.Visible = true;
                trFormAssign.Visible = true;
            }
            else
            {
                daUI.getApprovalState(ref enUI);

                if (((Status == "2") || (Status == "3")) && (enUI.ApprovalState)) // RFA
                {
                    imbReOpen.Visible = true;
                    imbVerify.Visible = true;
                }
            }
        }
    }
}
