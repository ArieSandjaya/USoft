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
using USoft.Globalization;
using USoft.Globalization.Classes;

namespace USoft.Modules.Main.Master
{
    public partial class Measurement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Label lbl = (Label)CtrlFormHeader.FindControl("lblHeader");
                lbl.Text = "Measurements";
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static object GetMasurement()
        {
            Measurements mst = new Measurements();
            return mst.Select();
        }
        [WebMethod]
        public static bool UpdateMasurement(string MeasurementCode,string MeasurementName)
        {
            string session = CekSessions.getUserId();
            Measurements mst = new Measurements();
            return mst.Update(MeasurementCode,MeasurementName,session);
        }
        [WebMethod]
        public static bool InsertMasurement(string MeasurementCode,string MeasurementName)
        {
            string session = CekSessions.getUserId();
            Measurements mst = new Measurements();
            return mst.Insert(MeasurementCode,MeasurementName,session);
        }
    }
}
