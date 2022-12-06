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

namespace USoft.Modules.Master
{
    public partial class DepartementAddEdit : USoft.Modules.PageBase
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
                    txtDepartementCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Departement";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.Master.Departement info = new USoft.DataAccess.Entities.Master.Departement();
            USoft.DataAccess.Master.Departement da = new USoft.DataAccess.Master.Departement();

            info.DepartementCode = editID;

            da.getDepartementView(ref info);

            txtDepartementCode.Text = info.DepartementCode;
            txtDepartementName.Text = info.DepartementName;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.Master.Departement info = new USoft.DataAccess.Entities.Master.Departement();
            USoft.DataAccess.Master.Departement da = new USoft.DataAccess.Master.Departement();

            info.DepartementCode = txtDepartementCode.Text;
            info.DepartementName = txtDepartementName.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.DepartementUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.DepartementInsert(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }
        
        protected void ProcessForm()
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.blockUI();", true);

            CekSessions.BlockUI(this.Page);

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //imbSubmit.Visible = false;
                    Response.Redirect("DepartementAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtDepartementCode.Text + "&state=edit&msg=" + lblMessage.Text);
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
            Response.Redirect("Departement.aspx?validate=" + validate(0));
        }
    }
}
