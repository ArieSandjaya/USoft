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
    public partial class ctrlUserId : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        private void LoadUserId()
        {
            if (HttpContext.Current.Cache["USERID"] == null)
            {
                AppStart.GetUserid();
            }
            DataSet ds = new DataSet();
            ds = (DataSet)HttpContext.Current.Cache["USERID"];
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ListItem lstItem = new ListItem();
                lstItem.Text = dr["UserName"].ToString();
                lstItem.Value = dr["UserId"].ToString();
                //lstItem.Attributes.Add("code", dr["PriviledgeCode"].ToString()); //////
                lstItem.Attributes.Add("code", dr["PrivilegeCode"].ToString());
                ddlUserId.Items.Add(lstItem);
            }
        }


        protected void ddlUserId_Init(object sender, EventArgs e)
        {
            LoadUserId();
        }
    }
}