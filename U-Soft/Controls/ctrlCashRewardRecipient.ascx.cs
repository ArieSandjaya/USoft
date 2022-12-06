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
    public partial class ctrlCashRewardRecipient : System.Web.UI.UserControl
    {
        public event EventHandler AddClicked;
        public event EventHandler SaveClicked;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void imgAdd_Click(object sender, ImageClickEventArgs e)
        {
            AddClicked(this, EventArgs.Empty);
        }

        protected void imgSave_Click(object sender, ImageClickEventArgs e)
        {
            SaveClicked(this, EventArgs.Empty);
        }

    }
}