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

namespace USoft.Controls
{
    public partial class ctrlPriviledge : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        private void LoadPriviledge()
        {
            if (HttpContext.Current.Cache["PRIVILEDGE"] == null)
            {
                AppStart.GetPriviledge();
            }
            DataSet ds = new DataSet();
            ds = (DataSet)HttpContext.Current.Cache["PRIVILEDGE"];
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ListItem lstItem = new ListItem();
                lstItem.Text = dr["PriveledgeName"].ToString();
                lstItem.Value = dr["PriveledgeCode"].ToString();
                ddlPriviledge.Items.Add(lstItem);
            }
        }

        protected void ddlPriviledge_Init(object sender, EventArgs e)
        {
            LoadPriviledge();
        }
    }
}