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
using USoft.Compliance.Master;
using System.Collections.Generic;
using USoft.Common.Shared;

namespace USoft.Modules.Compliance.Master
{
    public partial class department : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            
            if (!IsPostBack)
            {
                GetDepartment();
            }
        }
        private void LoadControl()
        {
            ucHeaderPage.Text = "Search / Add Department";
            ucHeaderPage.CssClass = "divHeader2";
        }
        private DataSet EmptyData()
        {
            List<string> ColumName = new List<string>();
            ColumName.Add("DeptCode");
            ColumName.Add("DeptName");
            ColumName.Add("Status");
            SQLHelper helper = new SQLHelper();
            return helper.EmptyDataSet(ColumName);
        }
        private void GetDepartment()
        {
            DeptSearch dSearch = new DeptSearch();
            dSearch.DeptName = "";
            dSearch.Status = "";
            gvDept.DataSource = dSearch.GetDepartment();
            gvDept.DataBind();
            updPanel.Update();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddDepartment.aspx");
        }

        protected void gvPriv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                string deptCode = gvDept.Rows[index].Cells[1].Text;
                string deptName = gvDept.Rows[index].Cells[2].Text;
                CheckBox chk = (CheckBox)gvDept.Rows[index].FindControl("CheckBox1");
                string status = chk.Checked == true ? "1" : "0";

                Response.Redirect("EditDepartment.aspx?DeptCode=" + deptCode +
                                             "&DeptName=" + deptName +
                                             "&Status=" + status +
                                             "&validate=" + validate(0));
            }
        }

    }
}
