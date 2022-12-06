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


namespace USoft.Classes
{
    using USoft.DataAccess;
    public class BasePage: System.Web.UI.Page
    {
        private const string SCRIPT_SET_PARENT_VALUE = "LOOKUP_SCRIPT_SET_PARENT_VALUE";
        //#region declared property
        //protected USoft.DataAccess.General.UserInfo GetUserInfo
        //{
        //    get
        //    {
        //        USoft.DataAccess.Entities.UserInfo enUI = new USoft.DataAccess.Entities.UserInfo();
        //        enUI.UserId = Session["UserId"].ToString();
        //        GetUserInfo.getUserInfo(ref enUI);
        //        return GetUserInfo;
        //    }
        //}
        //#endregion

        public bool IsActive, CanView, CanInsert, CanUpdate, CanDelete, IsApprove = false;
        public int ApprovalState;
        public string MenuId, Status, CreatedBy;
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
        public string WhereIs
        {
            set { ViewState["WhereIs"] = value; }
            get { return (ViewState["WhereIs"] != null) ? ViewState["WhereIs"].ToString() : ""; }
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

        public string validate(int pos)
        {
            string result;
            string str = Request.QueryString["validate"];

            if (pos == 0) { result = str; }
            else
            {
                string[] value;
                value = Request.QueryString["validate"].Split('~');

                result = value[pos-1].ToString();
            }
            return result;
        }

        public void getUserInfo()
        {
            enUI.UserId = Session["UserId"].ToString();

            daUI.getUserInfo(ref enUI);
        }
        public void callLookupPage(string jsScriptName, string popupPage,string ParamNameList, string ParamValueList, string ParamTypeList)
        {
            string jFuncScript = "";
            if (!ClientScript.IsStartupScriptRegistered(jsScriptName))
            {
                //string jParam = "";
                //if (jparam.Length > 0)
                //{
                //  //foreach (string param in jparam)
                //  //{
                //  //  //if (0 < jparam.Length) jparam += ",";
                //  //  //if (0 < ctrl.Length) jparam += string.Format("{0}", "val" + ctrl.ToLower());
                //  //}
                //    jParam = 
                //}
                //jFuncScript += "\r\ntry{var sData;\nif((window.navigator.appName.toLowerCase().indexOf('netscape') > -1)|| (window.navigator.appName.toLowerCase().indexOf('mozilla') > -1)){sData=window.opener;}\nelse{sData = dialogArguments;}";
                //jFuncScript += string.Format("\r\nsData.{0}({1});}} catch(e){{ShowMessage('Fail to select record.\\nOriginal message:'+e.message);}}", "lookup", jparam);
                //jFuncScript += "\r\nwindow.close();return false;";
                string str = "../../../Popup/" + popupPage + "?ParamNameList=" + ParamNameList + 
                             "&ParamValueList=" + ParamValueList + "&ParamTypeList=" + ParamTypeList;
                       str += "','','directories=no,titlebar=no,toolbar=no,location=no,";
                       str += "status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=500";
                jFuncScript = "window.open(\'" + str + "\');";
                //jFuncScript = string.Format("function " + jsScriptName + " ({0})\r\n{{{1}}}","", jFuncScript);
                //jFuncScript = string.Format("<SCRIPT language=javascript>\r\n{0}\r\n</SCRIPT>", jFuncScript);
                ClientScript.RegisterStartupScript(this.GetType(), jsScriptName, jFuncScript,true);
            }
           // return jFuncScript;
        }
    }
}
