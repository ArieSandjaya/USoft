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

using USoft.Globalization;
using USoft.Globalization.Classes;
using USoft.Common.CommonFunction;

namespace USoft.Controls
{
    public partial class ctrlSearch : System.Web.UI.UserControl
    {
        // Variable
        String _PageID;

        // Property
        public String PageID
        {
            set { _PageID = value; }
            get { return _PageID; }
        }

        public String SearchTitleText
        {
            set { ucHeaderSearch.Text = value; }
            get { return ucHeaderSearch.Text; }
        }

        public String SearchTitleCssClass
        {
            set { ucHeaderSearch.CssClass = value; }
            get { return ucHeaderSearch.CssClass; }
        }

        // Procedure
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (PageID != "")
                {
                    ControlBindingHelper.BindDataSetToCombo(ddlFieldSearch, "All", "spGetParamFieldToCombo '" + PageID + "'", "ParamField", "ParamName", null);
                }
            }
            else
            {

            }
        }

        protected void LoadData()
        {

        }
    }
}