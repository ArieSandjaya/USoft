using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using USoft.DataAccess.Entities;


namespace USoft.Classes
{
    public class PageManager
    {
        public PageManager()
        {}
        //public static UserInfo GetPageProperty(UserInfo baseDomain)
        //    {
        //      IPropertyPage pageProperty = !overRide ? PageManager.PageConfig[pageId.ToUpper()] : PageManager.PageConfigOverride[pageId.ToUpper()];
        //      if (pageProperty == null)
        //        return (BaseDomain) null;
        //      try
        //      {
        //        if (baseDomain == null)
        //          baseDomain = PageManager.GetDomain(pageProperty.Domain);
        //        PageManager.GetProperty(pageProperty, webPage, baseDomain);
        //        return baseDomain;
        //      }
        //      catch (MyException ex)
        //      {
        //        throw new MyException(Firium.Base.Web.Resources.ResourceManager.FormatMessage("RES_ExceptionFailedToGetPageProperty", (object) pageId, (object) ex));
        //      }
        //    }
    }
}
