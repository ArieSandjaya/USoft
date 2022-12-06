
namespace USoft.Classes
{
    public class LookupPage : BasePageSearch
    {
        protected string SearchKey;
        protected string ParamNameList;
        protected string ParamValueList;
        protected string ParamTypeList;

        #region Constants
        private const string CONTROL_LIST = "LOOKUP_CONTROL_LIST";
        private const string MAPPING_LIST = "LOOKUP_MAPPING_LIST";
        private const string SEARCH_KEY = "LOOKUP_SEARCH_KEY";
        private const string SET_FUNCTION_NAME = "LOOKUP_SET_FUNCTION_NAME";
        private const string SCRIPT_SET_PARENT_VALUE = "LOOKUP_SCRIPT_SET_PARENT_VALUE";
        private const string SCRIPT_ON_LOAD = "LOOKUP_SCRIPT_ON_LOAD";
        private const string IS_INITIALIZED = "LOOKUP_IS_INITIALIZED";
        private const string ADDITIONAL_PARAM_NAME_LIST = "ADDITIONAL_PARAM_NAME_LIST";
        private const string ADDITIONAL_PARAM_VALUE_LIST = "ADDITIONAL_PARAM_VALUE_LIST";
        private const string ADDITIONAL_PARAM_TYPE_LIST = "ADDITIONAL_PARAM_TYPE_LIST";
        #endregion

        protected virtual void ShowData() 
        { }
        protected void ProcessQueryString()
        {
            //string control = Request.QueryString["control"];
            //string mapping = Request.QueryString["map"];
            //string query = Request.QueryString["map"];
            //string searchCode = Request.QueryString["code"];
            //Set FunctionName = Request.QueryString["func"];
            ParamNameList = Request.QueryString["ParamNameList"];
            ParamValueList = Request.QueryString["ParamValueList"];
            ParamTypeList = Request.QueryString["ParamTypeList"];
            ScriptParentValue();
            ShowData();
        }
        protected string ScriptParentValue()
        {
            string jFuncScript = "";
            if (!ClientScript.IsClientScriptBlockRegistered(SCRIPT_SET_PARENT_VALUE))
            {
                //string jparam = "";
                //foreach (string ctrl in ControlList)
                //{
                //    if (0 < jparam.Length) jparam += ",";
                //    if (0 < ctrl.Length) jparam += string.Format("{0}", "val" + ctrl.ToLower());
                //}
                jFuncScript += "\r\ntry{var sData;\nif((window.navigator.appName.toLowerCase().indexOf('netscape') > -1)|| (window.navigator.appName.toLowerCase().indexOf('mozilla') > -1)){sData=window.opener;}\nelse{sData = dialogArguments;}";
                jFuncScript += string.Format("\r\nsData.{0}({1});}} catch(e){{ShowMessage('Fail to select record.\\nOriginal message:'+e.message);}}", "ParentName", "");
                jFuncScript += "\r\nwindow.close();return false;";
                jFuncScript = string.Format("function jsSetParentValue({0})\r\n{{{1}}}", "", jFuncScript);
                jFuncScript = string.Format("<SCRIPT language=javascript>\r\n{0}\r\n</SCRIPT>", jFuncScript);
                ClientScript.RegisterClientScriptBlock(this.Page.GetType(),SCRIPT_SET_PARENT_VALUE, jFuncScript);
            }
            return jFuncScript;
        }
    }
}
