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
using USoft.Compliance.Entertainment;

namespace USoft.Modules.Compliance.Entertainment
{
    public partial class EntApproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                NextPager(this, EventArgs.Empty);
                Label lblMaxPage = (Label)this.CtrlPager.FindControl("lblMaxRow");
                Button btnNext = (Button)this.CtrlPager.FindControl("btnNext");
                int MaxPage = Convert.ToInt16(lblMaxPage.Text);
                btnNext.Visible = MaxPage > 1 ? true : false;
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Approval Entertainment";
            ucHeaderPage.CssClass = "divHeader2";
        }

        protected void gvApprove_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvApprove.PageIndex = e.NewPageIndex;
            //getdata(0, 50);
        }
        protected void gvApprove_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int i;
                i = Convert.ToInt32(((System.Web.UI.WebControls.WebControl)(((System.Web.UI.WebControls.LinkButton)(e.CommandSource)))).Attributes["keyID"]);
                if (e.CommandName == "Select")
                {
                    Status(i, "REJECTED");
                }
                else if (e.CommandName == "Edit")
                {
                    Status(i, "APPROVED");
                }
                else if (e.CommandName == "New")
                {
                    Status(i, "CANCEL");
                }
        }
        protected void gvApprove_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lbApproved = (LinkButton)e.Row.FindControl("LinkButton1");
                LinkButton lbReject = (LinkButton)e.Row.FindControl("LinkButton3");
                LinkButton lbCancel = (LinkButton)e.Row.FindControl("LinkButton2");

                lbApproved.Attributes.Add("KeyID", e.Row.Cells[0].Text);
                lbReject.Attributes.Add("KeyID", e.Row.Cells[0].Text);
                lbCancel.Attributes.Add("KeyID", e.Row.Cells[0].Text);
            }
        }
        protected void Status(int KeyId, string Status)
        {
            try
            {
                Approval app = new Approval();
                app.ApprovalUpdate(KeyId, Status);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Updated');", true);
                Label lblCurrPage = (Label)this.CtrlPager.FindControl("lblCurrent");
                Label lblMaxPage = (Label)this.CtrlPager.FindControl("lblMaxRow");
                int CurrPage = Convert.ToInt16(lblCurrPage.Text);
                getdata(gvApprove.PageSize * (CurrPage - 1), gvApprove.PageSize * CurrPage);
                updApp.Update();
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Update Data');", true);
            }
        }
        public void NextPager(object sender, EventArgs e)
        {
            GetPager();
        }
        public void PrevPager(object sender, EventArgs e)
        {
            GetPager();
        }
        public void GetPager()
        {
            Approval app = new Approval();
            Label lblCurrPage = (Label)this.CtrlPager.FindControl("lblCurrent");
            Label lblMaxPage = (Label)this.CtrlPager.FindControl("lblMaxRow");
            int CurrPage = Convert.ToInt16(lblCurrPage.Text);
            int MaxPage = Convert.ToInt16(lblMaxPage.Text);
            lblCurrPage.Text = Convert.ToString(CurrPage = CurrPage == 0 ? 1 : CurrPage);
            lblMaxPage.Text = Convert.ToString(MaxPage = MaxPage == 0 ? app.ApprovalAppsCount(0, gvApprove.PageSize) : MaxPage);
            getdata(gvApprove.PageSize * (CurrPage - 1), gvApprove.PageSize * CurrPage);
        }
        private void getdata(int startIndex, int maxIndex)
        {
            try
            {
                Approval app = new Approval();
                gvApprove.DataSource = app.ApprovalApps(startIndex, maxIndex);
                gvApprove.DataBind();
            }
            catch
            {
                gvApprove.DataSource = null;
                gvApprove.DataBind();
            }
        }

        protected void gvApprove_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }
    }
}
