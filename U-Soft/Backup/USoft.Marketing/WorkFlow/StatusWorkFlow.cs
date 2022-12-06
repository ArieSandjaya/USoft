using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Web;
using System.Web.Caching;

namespace USoft.Marketing.WorkFlow
{
    public class StatusWorkFlow
    {
        public StatusWorkFlow()
        { }
        public Boolean SetWFStatus(List<KeyValuePair<string, object>> ParameterCollection)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                HttpContext.Current.Cache.Insert("WORKFLOW_UPD", sqlHandler.ExecuteAsDataTable("WORKFLOW_UPDATE", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
