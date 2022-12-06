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
    public partial class ctrlFormHeader : System.Web.UI.UserControl
    {
        // Variable
        HtmlGenericControl divHeader = new HtmlGenericControl();
        
        // Property
        public String Text
        {
            set { lblHeader.Text = value; }
            get { return lblHeader.Text; }
        }
        
        public String CssClass
        {
            set {
                divHeader = (HtmlGenericControl)FindControl("divHeader");
                divHeader.Attributes["class"] = value;
            }
            get {
                divHeader = (HtmlGenericControl)FindControl("divHeader");
                return divHeader.Attributes["class"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}