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
using USoft.Compliance;
using USoft.Compliance.Master;
using USoft.Globalization;

namespace USoft.Modules.Compliance.Master
{
    public partial class EditDepartment : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            
            if (!IsPostBack)
            {
                txtDeptCode1.Text = Request.QueryString["DeptCode"];
                txtDeptName1.Text = Request.QueryString["DeptName"];
                ucIsActive.SelectedValue((Request.QueryString["Status"] == "1") ? "True" : "False");
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Edit Department";
            ucHeaderPage.CssClass = "divHeader2";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateDepartment();
        }
        private void UpdateDepartment()
        {
            CekSessions.BlockUI(this.Page);

            DeptEdit dpt = new DeptEdit();
            dpt.DeptCode = txtDeptCode1.Text;
            dpt.DeptName = txtDeptName1.Text;
            dpt.Status = (ucIsActive.Value == "True") ? 1 : 0;

            string newString = dpt.EditDepartment();
            
            CekSessions.UnBlockUI(this.Page, ScriptManager1);
            
            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data has been Updated');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error When Update proses');", true);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("department.aspx?validate=" + validate(0));
        }
    }
}
