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
using USoft.Common.Setting;
using USoft.Globalization;
using USoft.Globalization.Classes;

namespace USoft.Reports
{
    public partial class ReportCaller : System.Web.UI.Page
    {
        private string ReportParameter;
        private string ReportParameterType;
        private string ReportParameterComponent;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                ControlBindingHelper.BindMyDropDownListAsBranch(ddlBranch, true);
            }
                Session["ReportFileName"] = Request.QueryString["ReportFileName"];
                ReportParameter = Request.QueryString["ReportParameter"];
                ReportParameterType = Request.QueryString["ReportParameterType"];
                ReportParameterComponent = Request.QueryString["ReportParameterComponent"];
                
                GetParameter();
                GetParameterType();
                GetParameterComponent();
            
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = Request.QueryString["ReportName"];
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void GetParameter()
        {
            string[] ArrReportParameter =  ReportParameter.Split('~');
            Session["myParam"] = ArrReportParameter;
        }
        private void GetParameterType()
        {
            string[] ArrReportParameterType = ReportParameterType.Split('~');
            Session["myParamType"] = ArrReportParameterType;
        }
        private void GetParameterComponent()
        {
            int CtrlValueId = 0;
            int iCount = 0;
            string[] ArrReportParameterComponent = ReportParameterComponent.Split('~');
            string[] ArrReportParameter = (string[])Session["myParam"];
            Session["myParamComponent"] = ArrReportParameterComponent;
            foreach (string strComponent in ArrReportParameterComponent)
            {
                switch (strComponent)
                {
                    case "trValue":
                        HtmlTableRow myValueRow = (HtmlTableRow)this.FindControl("trValue" + CtrlValueId);
                        myValueRow.Visible = true;
                        Label lbl = (Label)myValueRow.FindControl("lblValue" + CtrlValueId);
                        lbl.Text = ArrReportParameter[iCount].ToString();
                        CtrlValueId += 1;
                        break;
                    case "trPeriod":
                        HtmlTableRow myPeriodRow = (HtmlTableRow)this.FindControl("trPeriod");
                        myPeriodRow.Visible = true;
                        iCount += 1;
                        break;
                    case "trBranch":
                        HtmlTableRow myBranchRow = (HtmlTableRow)this.FindControl("trBranch");
                        myBranchRow.Visible = true;
                        break;
                    case "trSingleDate":
                        HtmlTableRow mySingleDateRow = (HtmlTableRow)this.FindControl("trSingleDate");
                        mySingleDateRow.Visible = true;
                        break;
                    case "trTotal":
                        HtmlTableRow myTotalRow = (HtmlTableRow)this.FindControl("trTotal");
                        myTotalRow.Visible = true;
                        break;
                }
                iCount += 1;
            }
        }

        private string MapReportParameter()
        {
            string ReturnString="";
            string TextComponent="";
            string[] ParamStr = (string[])Session["myParam"];
            string[] ParamComponentStr = (string[])Session["myParamComponent"];
            string[] ParamComponentType = (string[])Session["myParamType"];
            int CtrlValueId = 0;
            int i = 0;
            Control UControl = new Control();
            //for (int i = 0; i < ParamStr.Length; i++)
            foreach (string strComponent in ParamComponentStr)
            {
                switch (strComponent)
                {
                    case "trValue":
                        UControl.Controls.Add((Control)this.FindControl("txtValue" + CtrlValueId));
                        CtrlValueId += 1;
                        break;
                    case "trBranch":
                        UControl.Controls.Add(ddlBranch);
                        break;
                    case "trPeriod":
                        UControl.Controls.Add((Control)this.FindControl("txtDateTo"));
                        UControl.Controls.Add((Control)this.FindControl("txtDateFrom"));
                        break;
                    case "trSingleDate":
                        UControl.Controls.Add((Control)this.FindControl("txtSingleDate"));
                        break;
                    case "trTotal":
                        UControl.Controls.Add((Control)this.FindControl("ddlTotal"));
                        break;
                }
            }
                foreach (Control ctrl in UControl.Controls)
                {
                    if (ctrl.GetType().ToString() == "System.Web.UI.WebControls.TextBox")
                    {
                        TextBox tBox = (TextBox)ctrl;
                        if (ParamComponentType[i].ToString().ToUpper() == "datetime")
                        {
                            TextComponent = Convert.ToString(Convert.ToDateTime(tBox.Text).Year) + "-"
                                          + Convert.ToString("00" + Convert.ToString(Convert.ToDateTime(tBox.Text).Month)).Remove(0, 1) + "-"
                                          + Convert.ToString("00" + Convert.ToString(Convert.ToDateTime(tBox.Text).Day)).Remove(0, 1);
                        }
                        else
                        {
                            TextComponent = tBox.Text;
                        }
                    }
                    else if (ctrl.GetType().ToString() == "System.Web.UI.WebControls.DropDownList")
                    {
                        DropDownList dList = (DropDownList)ctrl;
                        TextComponent = dList.SelectedValue;
                    }
                    ReturnString += ParamStr[i].ToString() + "=" + TextComponent + "&";
                    i += 1;
                }
            ReturnString = ReturnString.Substring(0, ReturnString.Length - 1);
            return ReturnString;
        }
        protected void btnPrint_Click(object sender, EventArgs e)
        {         
            string ReportString;
            
            ReportString = SystemSetting.ReportPath + Session["ReportFileName"].ToString() + "&rs:Command=Render&" + MapReportParameter();
            //ScriptManager.RegisterOnSubmitStatement(btnPrint, btnPrint.GetType(), "Report", "window.open('" + ReportString + "','','')");
            CekSessions.OpenWindow(this.Page, updPrint, this.ScriptManager1, ReportString);
        }
    }
}
