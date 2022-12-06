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
using USoft.Globalization.Privilege;
using System.Collections.Generic;
using USoft.Common.Shared;

namespace USoft.Modules.Main
{
    public partial class PriviledgeSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetPriviledge();
            }
        }

        private DataSet EmptyData()
        {
            List<string> ColumName = new List<string>();
            ColumName.Add("PriveledgeCode");
            ColumName.Add("PriveledgeName");
            ColumName.Add("Active");
            SQLHelper helper = new SQLHelper();
            return helper.EmptyDataSet(ColumName);
        }

        private void GetPriviledge()
        {
            PrivSearch PSearch = new PrivSearch();
            
            gvPriv.DataSource = PSearch.GetPriviledge();
            gvPriv.DataBind();
            updPanel.Update();
        }

        protected void gvPriv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string privCode = gvPriv.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text;
                string privName = gvPriv.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[2].Text;
                CheckBox chk = (CheckBox)gvPriv.Rows[Convert.ToInt32(e.CommandArgument.ToString())].FindControl("CheckBox1");
                string status = chk.Checked == true ? "1" : "0";
                
                Response.Redirect("PriviledgeEdit.aspx?PrivCode=" + privCode +
                                             "&PrivName=" + privName +
                                             "&Active=" + status );
            }
        }
    }
}
