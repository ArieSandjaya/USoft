using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using USoft.Globalization.Classes;
using USoft.Globalization;

namespace USoft.Modules.Main.Master
{
    public partial class Currency : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Label lbl = (Label)CtrlFormHeader.FindControl("lblHeader");
                lbl.Text = "Currency";
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static object GetCurrency()
        {
            currency ccy = new currency();
            return ccy.Select();
        }
        [WebMethod]
        public static bool UpdateCurrency(string CcyCode,string CcyName)
        {
            string session = CekSessions.getUserId();
            currency ccy = new currency();
            return ccy.Update(CcyCode,CcyName,session);
        }
        [WebMethod]
        public static bool InsertCurrency(string CcyCode,string CcyName)
        {
            string session = CekSessions.getUserId();
            currency ccy = new currency();
            return ccy.Insert(CcyCode,CcyName,session);
        }
    }
}
