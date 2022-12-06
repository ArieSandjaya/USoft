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
    public partial class ctrlBranch : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }
        private void LoadBranch()
        {
            if (HttpContext.Current.Cache["BRANCH"] == null)
            {
                AppStart.GetBranch();
            }
            DataSet ds = new DataSet();
            ds = (DataSet)HttpContext.Current.Cache["BRANCH"];
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ListItem lstItem = new ListItem();
                lstItem.Text = dr["BranchName"].ToString();
                lstItem.Value = dr["BranchId"].ToString();
                ddlBranch.Items.Add(lstItem);
            }
        }

        protected void ddlBranch_Init(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
                LoadBranch();
            //}

        }
    }
}