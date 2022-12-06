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
using USoft.Insurance.Aswata;
using USoft.Globalization;

namespace USoft.Insurance.Aswata
{
    public partial class InsuranceAswata : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {
                
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "ASWATA";
            ucHeaderPage.CssClass = "divHeader1";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                GetDataToTable();
            }
            catch (Exception ex)
            {
                CekSessions.UnBlockUI(this.Page, this.updPanel, ScriptManager1);
                AppMessage.SetMessage(this.Page, ex.Message);
            }
            finally
            {
               CekSessions.UnBlockUI(this.Page,this.updPanel,ScriptManager1);
            }
        }

        protected void GetDataToTable()
        {
            try
            {
                TextBox txtDateFrom;
                TextBox txtDateTo;
                int BranchId;
                txtDateFrom = (TextBox)CtrlDatetimeRange1.FindControl("txtDateFrom");
                txtDateTo = (TextBox)CtrlDatetimeRange1.FindControl("txtDateTo");
                ViewState["txtDateFrom"] = txtDateFrom.Text;
                ViewState["txtDateTo"] = txtDateTo.Text;
                BranchId = Convert.ToInt32(Session["BranchId"].ToString());

                Aswata aswata = new Aswata();
                Session["Aswata"] = aswata.GetAswata(BranchId, Convert.ToDateTime(txtDateFrom.Text), Convert.ToDateTime(txtDateTo.Text));
                gvAswata.DataSource = (DataSet)Session["Aswata"];
                gvAswata.DataBind();
                if (gvAswata.Rows.Count > 0)
                {
                    btnConvert.Visible = true;
                }
                else
                {
                    btnConvert.Visible = false;
                }
                updPanel.Update();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnConvert_Click(object sender, EventArgs e)
        {
            Aswata aswata = new Aswata();
            DataSet ds = new DataSet();
            ds = (DataSet)Session["Aswata"];
            aswata.ConvertAswata(ds);
        }
    }
}
