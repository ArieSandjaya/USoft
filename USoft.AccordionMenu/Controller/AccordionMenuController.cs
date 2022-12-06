using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web.UI.WebControls;
using USoft.AccordionMenu.DataProvider;
using System.Web;
using AjaxControlToolkit;
using System.Web.UI;

namespace USoft.AccordionMenu
{
    public class AccordionMenuController
    {
        public AccordionMenuController()
        {}
        public List<object> GetTreeMenu(string uname)
        {
            List<object> apObj = new List<object>();
            if (uname != "")
            {
                Accordion accordion = new Accordion();
                AccordionMenuDataProvider AccordionDataProvider = new AccordionMenuDataProvider();
                List<object> tr = AccordionDataProvider.AccordionInfo(uname);
                AccordionPane ap;
                foreach (object obj in tr)
                {
                    ap = new AccordionPane();
                    TreeNode trNode = (TreeNode)obj;
                    ap.HeaderContainer.Controls.Add(new LiteralControl(trNode.Text));
                    TreeView trView = new TreeView();
                    trView.ExpandDepth = 0;
                    trView.NodeIndent = 2;
                    
                    List<object> trChild = new List<object>();
                    foreach (TreeNode nodes in trNode.ChildNodes)
                    {
                        trChild.Add(nodes);
                    }
                    foreach (object objChild in trChild)
                    {
                        TreeNode trNodeChild = (TreeNode)objChild;
                        trView.Nodes.Add(trNodeChild);
                    }
                    ap.ContentContainer.Controls.Add(trView);
                    apObj.Add(ap);
                }
                return apObj;
            }
            else
            {
                return null;
            }
        }      
    }
}
