using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Data;
using System.Web;

namespace USoft.AccordionMenu.DataProvider
{
    public class AccordionMenuData
    {
        public AccordionMenuData()
        { }
        public static void GetAllMenu()
        {

        }
        public static void GetAllMenu(String UserId)
        {
            DataSet ds = new DataSet();
            SQLHandler Handler = new SQLHandler();
            HttpRuntime.Cache["MenuCache"] = Handler.ExecuteAsDataSet("spGetMenuUsers '" + UserId + "'");
        }
    }
}
