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

namespace USoft.Modules.IT.Master
{
    public partial class ProblemTypeAddEdit : USoft.Modules.PageBase
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
                    txtProblemTypeCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " IT Problem Type";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.Master.ProblemType info = new USoft.DataAccess.Entities.IT.Master.ProblemType();
            USoft.DataAccess.IT.Master.ProblemType da = new USoft.DataAccess.IT.Master.ProblemType();

            info.ProblemTypeCode = editID;

            da.getITProblemTypeView(ref info);

            txtProblemTypeCode.Text = info.ProblemTypeCode;
            txtProblemTypeName.Text = info.ProblemTypeName;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.IT.Master.ProblemType info = new USoft.DataAccess.Entities.IT.Master.ProblemType();
            USoft.DataAccess.IT.Master.ProblemType da = new USoft.DataAccess.IT.Master.ProblemType();

            info.ProblemTypeCode = txtProblemTypeCode.Text;
            info.ProblemTypeName = txtProblemTypeName.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.ITProblemTypeUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.ITProblemTypeInsert(info);
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
                    Response.Redirect("ProblemTypeAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtProblemTypeCode.Text + "&state=edit&msg=" + lblMessage.Text);
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
            Response.Redirect("ProblemType.aspx?validate=" + validate(0));
        }
    }
}
