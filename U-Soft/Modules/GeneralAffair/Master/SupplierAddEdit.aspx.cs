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
    public partial class SupplierAddEdit : USoft.Modules.PageBase
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
                    txtSupplierCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Supplier";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.General_Affair.Master.Supplier info = new USoft.DataAccess.Entities.General_Affair.Master.Supplier();
            USoft.DataAccess.General_Affair.Master.Supplier da = new USoft.DataAccess.General_Affair.Master.Supplier();

            info.SupplierCode = editID;

            da.getSupplierView(ref info);

            txtSupplierCode.Text = info.SupplierCode;
            txtSupplierName.Text = info.SupplierName;
            txtAddress.Text = info.Address;
            txtCity.Text = info.City;
            txtZipCode.Text = info.ZipCode;
            txtPhone.Text = info.Phone;
            txtNPWP.Text = info.NPWP;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.General_Affair.Master.Supplier info = new USoft.DataAccess.Entities.General_Affair.Master.Supplier();
            USoft.DataAccess.General_Affair.Master.Supplier da = new USoft.DataAccess.General_Affair.Master.Supplier();

            info.SupplierCode = txtSupplierCode.Text;
            info.SupplierName = txtSupplierName.Text;
            info.Address = txtAddress.Text;
            info.City = txtCity.Text;
            info.ZipCode = txtZipCode.Text;
            info.Phone = txtPhone.Text;
            info.NPWP = txtNPWP.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.SupplierUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.SupplierInsert(info);
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
                    Response.Redirect("SupplierAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtSupplierCode.Text + "&state=edit&msg=" + lblMessage.Text);
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
            Response.Redirect("Supplier.aspx?validate=" + validate(0));
        }
    }
}
