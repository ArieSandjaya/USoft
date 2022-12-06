using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using USoft.Globalization;
using USoft.Common.CommonFunction;
using USoft.DataAccess;
using USoft.Common.Security;

namespace USoft.Modules
{
    public partial class PageBase : System.Web.UI.Page
    {
        // Variable Declaration
        public bool IsActive, CanView, CanInsert, CanUpdate, CanDelete, IsApprove = false;
        public int Branchid, ApprovalState;
        public string MenuId, Status, CreatedBy;
        public string[] MenuURL;
        public DropDownList ddlSearchBy;
        public TextBox txtSearchBy;
        public CommonFunction cf = new CommonFunction();
        public FormSecurity fs = new FormSecurity();
        public USoft.DataAccess.Entities.UserInfo enUI = new USoft.DataAccess.Entities.UserInfo();
        public USoft.DataAccess.General.UserInfo daUI = new USoft.DataAccess.General.UserInfo();

        // Property
        public string WhereBy
        {
            set { ViewState["WhereBy"] = value; }
            get { return (ViewState["WhereBy"] != null) ? ViewState["WhereBy"].ToString() : ""; }
        }
        public string ReturnID
        {
            set { ViewState["ReturnID"] = value; }
            get { return ViewState["ReturnID"].ToString(); }
        }
        public string state { get { return Request.QueryString["state"]; } }
        public string from { get { return Request.QueryString["from"]; } }
        public string msg { get { return Request.QueryString["msg"]; } }
        public string editID { get { return Request.QueryString["editID"]; } }
        public string editDetailID { get { return Request.QueryString["editDetailID"]; } }
        public bool fromApprove { get { return (Request.QueryString["from"] == "approve"); } }
        
        public void URLParse()
        {
            MenuURL = Request.QueryString["validate"].Split('~');
            MenuId = MenuURL[0].ToString();
        }

        
        public string validate(int pos)
        {
            string result;

            if (pos == 0) { result = Request.QueryString["validate"];  }
            else
            {
                result = MenuURL[pos - 1].ToString();
            }
            return result;
        }

        public void getUserInfo()
        {
            URLParse();

            enUI.UserId = Session["UserId"].ToString();
            enUI.MenuId = Convert.ToInt32(MenuId);

            daUI.getUserInfo(ref enUI);
        }
    }
}
