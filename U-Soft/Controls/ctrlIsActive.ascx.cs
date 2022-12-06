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

namespace USoft.Controls
{
    public partial class ctrlIsActive : System.Web.UI.UserControl
    {
        // Variable
        string FirstText = "";

        // Property
        public string FirstListText
        {
            set { FirstText = value; }
        }

        public string CssClass
        {
            set { ddlIsActive.CssClass = value; }
            get { return ddlIsActive.CssClass; }
        }

        public string Value
        {
            get { return ddlIsActive.SelectedValue; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SetItems();
            }
        }

        public void SelectedValue(string val)
        {
            SetItems();
            ddlIsActive.Items.FindByValue(val).Selected = true;
        }

        public void SetItems()
        {
            if (ddlIsActive.Items.Count == 0)
            {
                if (FirstText == "")
                {
                    ddlIsActive.Items.Add(new ListItem("All", ""));
                }
                else
                {
                    ddlIsActive.Items.Add(new ListItem(FirstText, ""));
                }
                ddlIsActive.Items.Add(new ListItem("Active", "True"));
                ddlIsActive.Items.Add(new ListItem("Non Active", "False"));
            }
        }
    }
}