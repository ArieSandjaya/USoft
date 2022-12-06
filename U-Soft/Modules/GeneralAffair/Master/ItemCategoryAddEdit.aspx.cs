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

namespace USoft.Modules.GeneralAffair.Master
{
    public partial class ItemCategoryAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                if (this.state == "add")
                {
                    imbUpdate.Enabled = false;
                    imbUpdate.Visible = false;
                }
                else
                {
                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadData();
                    txtItemCategoryCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Item Category";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Master.ItemCategory info = new USoft.DataAccess.Entities.General_Affair.Master.ItemCategory();
            USoft.DataAccess.General_Affair.Master.ItemCategory da = new USoft.DataAccess.General_Affair.Master.ItemCategory();

            info.ItemCategoryCode = editID;

            da.getItemCategoryView(ref info);

            txtItemCategoryCode.Text = info.ItemCategoryCode;
            txtItemCategoryName.Text = info.ItemCategoryName;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.General_Affair.Master.ItemCategory info = new USoft.DataAccess.Entities.General_Affair.Master.ItemCategory();
            USoft.DataAccess.General_Affair.Master.ItemCategory da = new USoft.DataAccess.General_Affair.Master.ItemCategory();

            info.ItemCategoryCode = txtItemCategoryCode.Text;
            info.ItemCategoryName = txtItemCategoryName.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.ItemCategoryUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.ItemCategoryInsert(info);
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
                    //mbAdd.Visible = false;
                    Response.Redirect("ItemCategoryAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtItemCategoryCode.Text + "&state=edit&msg=" + lblMessage.Text);
                }
            }
            else
            {
                ProcessData("U");
            }

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
            Response.Redirect("ItemCategory.aspx?validate=" + validate(0));
        }
    }
}
