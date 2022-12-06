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
using System.Reflection;

namespace USoft.Controls
{
    public partial class ctrlGridPager : System.Web.UI.UserControl
    {
        // Event Handler
        public event EventHandler PagerClicked;

        // Property
        public int PageNo
        {
            get { return Convert.ToInt32(CurrPage); }
            set { CurrPage = value.ToString(); }
        }

        public string CurrPage
        {
            get { return lblCurrPage.Text; }
            set { lblCurrPage.Text = value; }
        }

        public string TotalPage
        {
            get { return lblTotalPage.Text; }
            set { lblTotalPage.Text = value; }
        }

        public string TotalData
        {
            get { return lblTotalData.Text; }
            set { lblTotalData.Text = value; }
        }

        // Procedure
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void imbFirst_Click(object sender, ImageClickEventArgs e)
        {
            if (PagerClicked != null)
            {
                PageNo = 1;
                PagerClicked(this, EventArgs.Empty);
            }
        }

        protected void imbPrev_Click(object sender, ImageClickEventArgs e)
        {
            if (PagerClicked != null)
            {
                PageNo--;
                PagerClicked(this, EventArgs.Empty);
            }
        }

        protected void imbNext_Click(object sender, ImageClickEventArgs e)
        {
            if (PagerClicked != null)
            {
                PageNo++;
                PagerClicked(this, EventArgs.Empty);
            }
        }

        protected void imbLast_Click(object sender, ImageClickEventArgs e)
        {
            if (PagerClicked != null)
            {
                PageNo = Convert.ToInt32(lblTotalPage.Text);
                PagerClicked(this, EventArgs.Empty);
            }
        }

        protected void imbGo_Click(object sender, ImageClickEventArgs e)
        {
            if (PagerClicked != null)
            {
                int GoPage;

                if (int.TryParse(txtPageGo.Text, out GoPage))
                {
                    PageNo = GoPage;
                }
                PagerClicked(this, EventArgs.Empty);
            }
        }

        public void ButtonState()
        {
            imbFirst.Enabled = (PageNo > 1);
            imbPrev.Enabled = (PageNo > 1);
            imbNext.Enabled = (PageNo < Convert.ToInt32(TotalPage));
            imbLast.Enabled = (PageNo < Convert.ToInt32(TotalPage));

            tdPagerNav.Visible = (Convert.ToInt32(TotalPage) != 1);
        }
    }
}