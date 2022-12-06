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
using System.Collections.Generic;
using USoft.Compliance.Teroris;
using USoft.Common.Setting;

namespace USoft.Modules.Compliance
{
    public partial class teroris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                gvTeroris.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                gvTeroris.DataSource = EmptyData();
                gvTeroris.DataBind();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Sanction Lists";
            ucHeaderPage.CssClass = "divHeader2";
        }

        public void NextPager(object sender, EventArgs e)
        {
            GetPager();
        }
        public void PrevPager(object sender, EventArgs e)
        {
            GetPager();
        }
        public void GetPager()
        {
            Teroris teror = new Teroris();
            TextBox txtValue = (TextBox)CtrlValue1.FindControl("txtValue");
            Label lblCurrPage = (Label)this.CtrlPager1.FindControl("lblCurrent");
            Label lblMaxPage = (Label)this.CtrlPager1.FindControl("lblMaxRow");
            int CurrPage = Convert.ToInt16(lblCurrPage.Text);
            int MaxPage = Convert.ToInt16(lblMaxPage.Text);
            lblCurrPage.Text=Convert.ToString( CurrPage = CurrPage == 0 ? 1 : CurrPage);
            lblMaxPage.Text=Convert.ToString(MaxPage = MaxPage == 0 ? teror.getTerorisCount(txtValue.Text, 0, gvTeroris.PageSize) : MaxPage);
            searchData(txtValue.Text, gvTeroris.PageSize * (CurrPage-1), gvTeroris.PageSize * CurrPage);
        }
        private DataSet EmptyData()
        {
            List<string> ColumName = new List<string>();
            ColumName.Add("ROW");
            ColumName.Add("Name");
            ColumName.Add("BIRTHDAYS");
            ColumName.Add("Address");
            ColumName.Add("Nationality");
            ColumName.Add("Other_Info");

            Teroris teror = new Teroris();
            return teror.emptyData(ColumName);
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            NextPager(this, EventArgs.Empty);
            Label lblMaxPage = (Label)this.CtrlPager1.FindControl("lblMaxRow");
            Button btnNext = (Button)this.CtrlPager1.FindControl("btnNext");
            int MaxPage = Convert.ToInt16(lblMaxPage.Text);
            btnNext.Visible = MaxPage > 1 ?  true :  false;
        }

        private void searchData(string value,int startIndex,int maxIndex)
        {
            Teroris teror = new Teroris();          
            DataSet ds = (DataSet)teror.getTerorisList(value, startIndex, maxIndex);
            gvTeroris.DataSource = ds.Tables[0].Rows.Count > 0 ? ds : EmptyData();
            gvTeroris.DataBind();
            updPanel.Update();
        }

        protected void btnConvert_Click(object sender, EventArgs e)
        {
            Teroris teror = new Teroris();
            TextBox txtValue = (TextBox)CtrlValue1.FindControl("txtValue");
            string name = txtValue.Text == "" ? "null" : txtValue.Text;
            string ReportPath = USoft.Common.Setting.SystemSetting.ReportPath;
            string str = ReportPath + "terorist_list&rs:Command=Render&name=" + name;
            str = "<script>window.open(\'"+str+"\')</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Journal Report", str);
        }

    }
}
