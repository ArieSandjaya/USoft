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
    public partial class ItemEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!IsPostBack)
            {
                //Binding
                ControlBindingHelper.BindDataSetToCombo(ddlCondition, "- Select One -", "spGetITConditionToCombo ''", "ConditionCode", "ConditionName", null);

                lblItemCode.Text = editID;

                LoadData();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Item Detail";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();

            info.ItemCode = editID;
            
            da.getItemView(ref info);

            lblItemCode.Text = info.ItemCode;
            lblItemType.Text = info.ItemTypeName;
            lblSerialNo.Text = info.SerialNo;
            lblBarcode.Text = info.Barcode;
            txtDescription.Text = info.Description;
            ddlCondition.SelectedValue = info.ConditionCode.ToString();
            lblBranchName.Text = info.BranchName;
            lblUsedBy.Text = info.UsedBy;
            lblPrivilege.Text = info.PrivilegeName;
        }

        protected void ProcessData()
        {
            USoft.DataAccess.Entities.IT.Item info = new USoft.DataAccess.Entities.IT.Item();
            USoft.DataAccess.IT.Item da = new USoft.DataAccess.IT.Item();


            info.ItemCode = editID;
            info.Description = txtDescription.Text;
            info.ConditionCode = Convert.ToInt32(ddlCondition.SelectedValue);
            info.InputBy = Session["UserId"].ToString();

            lblMessage.Text = da.ItemUpdate(info);
        }

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            ProcessData();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ItemDetail.aspx?validate=" + validate(0) + "&editID=" + editID);
        }
    }
}
