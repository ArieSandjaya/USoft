using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using USoft.AccordionMenu;
using AjaxControlToolkit;
using System.Collections.Generic;

namespace USoft.Controls
{
    public partial class ctlAccordionMenu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null) // 20130514 add dwi prevent error empty session
            {
                List<object> apObj = new List<object>();
                AccordionMenuController accMenu = new AccordionMenuController();
                apObj = accMenu.GetTreeMenu(Session["UserId"].ToString());
                foreach (AccordionPane ap in apObj)
                {
                    MenuAccordion.Panes.Add(ap);
                    MenuAccordion.ContentCssClass = "ui-widget-content";
                    MenuAccordion.HeaderCssClass = "ui-widget-header";
                }
            }
        }

    }
}