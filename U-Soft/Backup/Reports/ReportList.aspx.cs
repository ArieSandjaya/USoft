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
using USoft.Reports.List;
using USoft.Globalization.Reports;

namespace USoft.Reports
{
    public partial class ReportList : System.Web.UI.Page
    {
        // Property
        public string validate { get { return Session["UserId"].ToString() + '~' + Request.QueryString["validate"]; } }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                GetReportLists(validate);
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = ReportGroup.GetReportGroup(validate) + " REPORTS";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void GetReportLists(string Group)
        {
            ReportLists reportLists = new ReportLists();
            gViewLists.DataSource = reportLists.GetReportLists(ReportGroup.GetReportGroup(Group));
            gViewLists.DataBind();
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {

        }

        protected void gViewLists_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string ReportCode;
            string ReportName;
            string ReportFileName;
            string ReportParameter;
            string ReportParameterType;
            string ReportParameterComponent;
            GridViewRow row;
            row = gViewLists.Rows[Convert.ToInt16(e.CommandArgument.ToString())];
            ReportCode = gViewLists.Rows[row.DataItemIndex].Cells[0].Text;
            ReportName = gViewLists.Rows[row.DataItemIndex].Cells[1].Text;
            ReportFileName = gViewLists.Rows[row.DataItemIndex].Cells[2].Text;
            ReportParameter = gViewLists.Rows[row.DataItemIndex].Cells[3].Text;
            ReportParameterType = gViewLists.Rows[row.DataItemIndex].Cells[4].Text;
            ReportParameterComponent = gViewLists.Rows[row.DataItemIndex].Cells[5].Text;
            Response.Redirect("ReportCaller.aspx?ReportCode=" + ReportCode + "&ReportName=" + ReportName + "&ReportFileName=" + ReportFileName + "&ReportParameter=" + ReportParameter + "&ReportParameterType=" + ReportParameterType + "&ReportParameterComponent=" + ReportParameterComponent);
        }
    }
}
