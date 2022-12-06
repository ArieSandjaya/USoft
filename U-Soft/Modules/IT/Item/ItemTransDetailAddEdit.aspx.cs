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
using USoft.Globalization.Classes;
using USoft.Common.CommonFunction;
using USoft.DataAccess;
using USoft.Globalization;

namespace USoft.Modules.IT.Item
{
    public partial class ItemTransDetailAddEdit : USoft.Modules.PageBase
    {
        //// Variable Declaration
        //CommonFunction cf = new CommonFunction();

        //// Property
        //public String validate { get { return Request.QueryString["validate"]; } }
        //public String state { get { return Request.QueryString["state"]; } }
        //public String editID { get { return Request.QueryString["editID"]; } }
        //public String editDetailID { get { return Request.QueryString["editDetailID"]; } }

        // Procedure
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                //Binding
                ControlBindingHelper.BindDataSetToCombo(ddlItemType, "- Select One -", "spGetITItemTypeToCombo ''", "ItemTypeCode", "ItemTypeName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlCondition, "- Select One -", "spGetITConditionToCombo ''", "ConditionCode", "ConditionName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlPrivilege, "- Select One -", "spGetPrivilegeToCombo ''", "PrivilegeCode", "PrivilegeName", null);

                lblItemTransCode.Text = editID;

                LoadData();

                if (this.state == "add")
                {
                    lblItemTransDetailCode.Text = "[Generated By System]";
                }
                else //edit
                {
                    LoadDataDetail();
                }
                FormState();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Item Transfer Detail";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemTransCode = editID;

            da.getItemTransView(ref info);

            lblItemTransCode.Text = info.ItemTransCode;
            lblBranchFrom.Text = info.BranchNameFrom;
            lblBranchTo.Text = info.BranchNameTo;
            CreatedBy = info.CreatedBy;
            Status = info.Status;
        }

        private void LoadDataDetail()
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemTransCode = editID;
            info.ItemTransDetailCode = editDetailID;

            da.getItemTransDetailView(ref info);

            lblItemTransDetailCode.Text = info.ItemTransDetailCode;
            ddlItemType.SelectedValue = info.ItemTypeCode;
            ControlBindingHelper.BindDataSetToCombo(ddlItemCode, "- Select One -", "spGetITItemTransByBranchTypeToCombo '" + editID + "','" + ddlItemType.SelectedValue + "','" + info.ItemCode + "'", "ITItemCode", "ItemName", info.ItemCode);
            ddlCondition.SelectedValue = info.ConditionCode.ToString();
            txtUsedBy.Text = info.UsedBy;
            ddlPrivilege.SelectedValue = info.PrivilegeCode;
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemTransCode = editID;
            info.ItemCode = ddlItemCode.SelectedValue;
            info.ConditionCode = Convert.ToInt32(ddlCondition.SelectedValue);
            info.UsedBy = txtUsedBy.Text;
            info.PrivilegeCode = ddlPrivilege.SelectedValue;
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                info.ItemTransDetailCode = editDetailID;
                lblMessage.Text = da.ItemTransDetailUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.ItemTransDetailInsert(info);
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

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //imbAdd.Visible = false;
                    ClearForm();
                }
            }
            else
            {
                ProcessData("U");
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }
       
        protected void getITItem(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            ddlItemCode.Items.Clear();

            if (ddlItemType.SelectedValue != "")
            {
                ControlBindingHelper.BindDataSetToCombo(ddlItemCode, "- Select One -", "spGetITItemTransByBranchTypeToCombo '" + editID + "','" + ddlItemType.SelectedValue + "',NULL", "ITItemCode", "ItemName", null);
            }
            pnlItemCode.Update();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbAdd_Click(object sender, ImageClickEventArgs e)
        {
            ProcessForm();
        }

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            ProcessForm();
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemTransDetail.aspx?validate=" + validate(0) + "&from=" + from + "&editID=" + editID);
        }

        protected void ClearForm()
        {
            ddlItemType.SelectedValue = "";
            ddlItemCode.SelectedValue = "";
            ddlCondition.SelectedValue = "";
            txtUsedBy.Text = "";
            ddlPrivilege.SelectedValue = "";
        }

        protected void FormState()
        {
            if (state == "add")
            {
                imbAdd.Visible = true;
                imbUpdate.Visible = false;
            }
            else
            {
                if ((Status == "D") || (CreatedBy == enUI.UserId))
                {
                    imbAdd.Visible = false;
                    imbUpdate.Visible = true;

                    ddlItemType.Enabled = true;
                    ddlItemCode.Enabled = true;
                    ddlCondition.Enabled = true;
                    txtUsedBy.Enabled = true;
                    ddlPrivilege.Enabled = true;
                }
                else
                {
                    ddlItemType.Enabled = false;
                    ddlItemCode.Enabled = false;
                    ddlCondition.Enabled = false;
                    txtUsedBy.Enabled = false;
                    ddlPrivilege.Enabled = false;
                }
            }
        }
    }
}