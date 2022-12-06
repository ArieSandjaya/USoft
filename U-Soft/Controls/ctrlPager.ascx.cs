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
    public partial class ctrlPager : System.Web.UI.UserControl
    {
        public event EventHandler NextClicked;
        public event EventHandler PrevClicked;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            int CurrPage;
            int MaxPage;
            if (NextClicked != null)
            {
                lblCurrent.Text = Convert.ToString(Convert.ToInt16(lblCurrent.Text) + 1);
                CurrPage = Convert.ToInt16(lblCurrent.Text);
                MaxPage = Convert.ToInt16(lblMaxRow.Text);
                if (CurrPage >= MaxPage)
                {
                    btnNext.Visible = false;
                    btnPrev.Visible = true;
                    CurrPage = MaxPage;
                }
                else
                {
                    btnNext.Visible = true;
                    btnPrev.Visible = true;
                }
                NextClicked(this, EventArgs.Empty);
            }
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            int CurrPage;
            int MaxPage;
            if (PrevClicked != null)
            {
                lblCurrent.Text = Convert.ToString(Convert.ToInt16(lblCurrent.Text) - 1);
                CurrPage = Convert.ToInt16(lblCurrent.Text);
                MaxPage = Convert.ToInt16(lblMaxRow.Text);
                if (CurrPage <= 1)
                {
                    btnPrev.Visible = false;
                    CurrPage = 1;
                }
                else
                {
                    btnPrev.Visible = true;
                    btnNext.Visible = true;
                }
                PrevClicked(this, EventArgs.Empty);
            }
        }
    }
}