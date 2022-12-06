using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Web.UI.WebControls;
using System.Web;
using System.Data;
using System.Web.Caching;
using System.Web.UI;
using USoft.Common.CommonFunction;

namespace USoft.Marketing.WorkFlow
{
    public class GetWorkFlow
    {
        public GetWorkFlow()
        { }
        public static void ShowWorkFlow(List<KeyValuePair<string, object>> ParameterCollection, GridView gridview)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                HttpContext.Current.Cache.Insert("SHOW_WORKFLOW", sqlHandler.ExecuteAsDataTable("WORKFLOW_SHOW", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);

                DataTable dt = (DataTable)HttpContext.Current.Cache["SHOW_WORKFLOW"];

                gridview.DataSource = dt;
                gridview.DataBind();
            }
            catch
            { throw; }
        }

        public static void ViewWorkFlow(List<KeyValuePair<string, object>> ParameterCollection, GridView gridview)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                HttpContext.Current.Cache.Insert("VIEW_WORKFLOW", sqlHandler.ExecuteAsDataTable("WORKFLOW_VIEW_DETAIL", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);

                DataTable dt = (DataTable)HttpContext.Current.Cache["VIEW_WORKFLOW"];

                gridview.DataSource = dt;
                gridview.DataBind();
            }
            catch
            { throw; }
        }

    }
}
