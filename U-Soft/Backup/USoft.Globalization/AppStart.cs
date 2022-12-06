using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Caching;
using USoft.AccordionMenu.DataProvider;
using USoft.Globalization.Privilege;
using USoft.Globalization.Users;
using USoft.Globalization.Dealer;
using USoft.Globalization.Classes;

namespace USoft.Globalization
{
    [Serializable]
    public class AppStart
    {
        public AppStart()
        {

        }
        public static void GetMenu()
        {
            if (HttpRuntime.Cache["MenuCache"] == null)
            {
                AccordionMenuData.GetAllMenu();
            }
        }
        public static void GetBranch()
        { 
            if (HttpRuntime.Cache["BRANCH"] == null)
            {
                Branch branch = new Branch();
                HttpContext.Current.Cache.Insert("BRANCH", branch.GetBranch(), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
            }
        }
        public static void GetPriviledge()
        {
            if (HttpRuntime.Cache["PRIVILEDGE"] == null)
            {
                Priviledge priv = new Priviledge();
                HttpContext.Current.Cache.Insert("PRIVILEDGE", priv.GetPriviledge(), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
            }
        }
        public static void GetUserid()
        {
            if (HttpRuntime.Cache["USERID"] == null)
            {
                UserId user = new UserId();
                HttpContext.Current.Cache.Insert("USERID", user.GetUserId(), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
            }
        }
        public static void GetEntCompanyName()
        {
            if (HttpRuntime.Cache["ENTDEALER"] == null)
            {
                EntertainmentDealer Dealer = new EntertainmentDealer();
                HttpContext.Current.Cache.Insert("ENTDEALER",Dealer.GetEntertainmentDealer(), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
            }
        }
        public static void GetEntDept()
        {
            if (HttpRuntime.Cache["ENTDEPT"] == null)
            {
                EntertainmentDept Dept = new EntertainmentDept();
                HttpContext.Current.Cache.Insert("ENTDEPT", Dept.GetEntertainmentDept(), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
            }
        }
        public static void GetBrand()
        {
            if (HttpRuntime.Cache["BRAND"] == null)
            {
                Brand brand = new Brand();
                HttpContext.Current.Cache.Insert("BRAND", brand.GetBrand(), null, DateTime.Now.AddMinutes(60), TimeSpan.Zero);
            }
        }
    }
}
