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
using USoft.Common.Security;

namespace USoft.Modules.Compliance.Entertainment
{
    public partial class EntHistoryPage : System.Web.UI.Page
    {
        public string validate { get { return Session["UserId"].ToString() + '~' + Request.QueryString["validate"]; } }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            { }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "History Entertainment";
            ucHeaderPage.CssClass = "divHeader2";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getData();
        }
        private void getData()
        {
            DataSet ds = new DataSet();
            try
            {
                string dtFrom;
                string dtTo;
                dtFrom = dtpickerFrom.Text;
                dtTo = dtpickerTo.Text;
                if (dtFrom == "" || dtFrom == "Click Here") { dtFrom = "1900-01-01"; }
                if (dtTo == "" || dtTo == "Click Here") { dtTo = "1900-01-01"; }
                    SearchHistory.DateStart = Convert.ToDateTime(dtFrom);
                    SearchHistory.DateEnd = Convert.ToDateTime(dtTo);
                    SearchHistory.SeqId = txtSeq.Text;
                    SearchHistory.UserName = FormSecurity.isUpdateAllowed(validate) == true ? "admin" : Session["UserName"].ToString();
                    gvHistory.DataSource = SearchHistory.search();
                    gvHistory.DataBind();
                    updApp.Update();
            }
            catch
            {
                gvHistory.DataSource = null;
                gvHistory.DataBind();
            }
        }
        protected void gvHistory_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string KeyId;
            KeyId = gvHistory.Rows[e.NewEditIndex].Cells[0].Text;
            Response.Redirect("EntPage.aspx?action=Edit&KeyId=" + KeyId + "&validate=112201");
        }

        protected void gvHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string keyId;
            string user;
            if (e.CommandName == "Select")
            {
                keyId = ((System.Web.UI.WebControls.WebControl)(((System.Web.UI.WebControls.LinkButton)(e.CommandSource)))).Attributes["keyID"];
                user = Session["UserName"].ToString();
                string ReportPath = USoft.Common.Setting.SystemSetting.ReportPath;
                string str = ReportPath + "PrintFormGiftUsoft&rs:Command=Render&keyId=" + keyId + "&username=" + user;
                str = "window.open(\'" + str + "\')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", str, true);
            }
        }

        protected void gvHistory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lbEdit = (LinkButton)e.Row.FindControl("lbEdit");
                LinkButton lbCancel = (LinkButton)e.Row.FindControl("lbCancel");
                LinkButton lbPrint = (LinkButton)e.Row.FindControl("lbPrint");

                if (e.Row.Cells[11].Text != "OPEN")
                {
                    lbEdit.Enabled = false;
                    lbCancel.Enabled = false;
                }
                else
                {
                    lbEdit.Enabled = true;
                    lbCancel.Enabled = true;
                }
                lbPrint.Attributes.Add("KeyID", e.Row.Cells[0].Text);
            }
        }

        protected void gvHistory_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

        }

        protected void gvHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvHistory.PageIndex = e.NewPageIndex;
            getData();
        }

    }
}
