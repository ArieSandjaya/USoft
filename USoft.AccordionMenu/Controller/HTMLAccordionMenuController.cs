using System;
using System.Collections.Generic;
using System.Text;
using AjaxControlToolkit;
using USoft.AccordionMenu.DataProvider;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace USoft.AccordionMenu.Controller
{
    public class HTMLAccordionMenuController
    {
        public StringBuilder GetTreeMenu(string uname, string privilige)
        {
            if (uname != "" && privilige != "")
            {
                StringBuilder htmlBuilder = new StringBuilder();
                Accordion accordion = new Accordion();
                HTMLAccordionMenuDataProvider AccordionDataProvider = new HTMLAccordionMenuDataProvider();
                StringBuilder str = AccordionDataProvider.AccordionInfo(uname, privilige);
                return str;
            }
            else
            {
                return null;
            }
        }
    }
}
