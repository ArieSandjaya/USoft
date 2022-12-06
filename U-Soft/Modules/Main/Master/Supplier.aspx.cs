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
    public partial class Supplier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Label lbl = (Label)CtrlFormHeader.FindControl("lblHeader");
                lbl.Text = "Items";
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static object GetSuppliers()
        {
            Suppliers sup = new Suppliers();
            return sup.Select();
        }
        [WebMethod]
        public static bool UpdateSuppliers(string supplier_id,string supplier_name,string address,string city,string zipcode,string phone,string npwp,string Active)
        {
            string session = CekSessions.getUserId();
            Suppliers sup = new Suppliers();
            return sup.Update(supplier_id,supplier_name,address,city,zipcode,phone,npwp,Active,session);
        }
        [WebMethod]
        public static bool InsertSuppliers(string supplier_id,string supplier_name,string address,string city,string zipcode,string phone,string npwp,string Active)
        {
            string session = CekSessions.getUserId();
            Suppliers sup = new Suppliers();
            return sup.Insert(supplier_id,supplier_name,address,city,zipcode,phone,npwp,Active,session);
        }
    }
}
