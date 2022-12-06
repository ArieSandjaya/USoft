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
    public partial class Items : System.Web.UI.Page
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
        public static object GetItems()
        {
            Item itm = new Item();
            return itm.Select();
        }
        [WebMethod]
        public static bool UpdateItems(string ItemCode,string ItemName,string CategoryCode,string Price,string Active)
        {
            string session = CekSessions.getUserId();
            Item itm = new Item();
            return itm.Update(ItemCode,ItemName,CategoryCode,Price,Active,session);
        }
        [WebMethod]
        public static bool InsertItems(string ItemCode,string ItemName,string CategoryCode,string Price,string Active)
        {
            string session = CekSessions.getUserId();
            Item itm = new Item();
            return itm.Insert(ItemCode,ItemName,CategoryCode,Price,Active,session);
        }
    }
}
