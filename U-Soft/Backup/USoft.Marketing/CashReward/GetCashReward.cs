using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Web.UI.WebControls;
using System.Web;
using System.Data;
using System.Web.Caching;
using System.Web.UI;
using USoft.Common.CommonFunction;
using System.Data.SqlClient;


namespace USoft.Marketing.CashReward
{
    public class GetCashReward
    {
        public GetCashReward()
        { }
        public static void Show(List<KeyValuePair<string, object>> ParameterCollection,GridView gridview,UserControl ucontrol, int minRow,bool NewSearch)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                DataSet ds = new DataSet();
                DataSet ds2 = new DataSet();
                DataTable dt = new DataTable();
                if (NewSearch == true)
                {
                    HttpContext.Current.Cache.Insert("CASH_REWARD", sqlHandler.ExecuteAsDataTable("CASH_REWARD_SHOW", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
                    Label lblCurrPage = (Label)ucontrol.FindControl("lblCurrent");
                    Label lblMaxPage = (Label)ucontrol.FindControl("lblMaxRow");
                    lblCurrPage.Text = "0";
                    lblMaxPage.Text = "0";
                }
                dt = (DataTable)HttpContext.Current.Cache["CASH_REWARD"];
                string filter = "Row >= " + (((minRow - 1) * gridview.PageSize) + 1) + " AND Row <= " + (minRow * gridview.PageSize);
                DataTable dt2 = new DataTable();
                dt2 = dt.Clone();
                DataRow[] dr = dt.Select(filter);
                foreach (DataRow row in dr)
                {
                    dt2.ImportRow(row);
                }
                gridview.DataSource = dt2;
                gridview.DataBind();
                SetPager(ucontrol, dt.Rows.Count, gridview.PageSize);
            }
            catch
            { throw; }
        }
        public static void ShowPaid(List<KeyValuePair<string, object>> ParameterCollection, GridView gridview, UserControl ucontrol, int minRow, bool NewSearch)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                DataSet ds = new DataSet();
                DataSet ds2 = new DataSet();
                DataTable dt = new DataTable();
                if (NewSearch == true)
                {
                    HttpContext.Current.Cache.Insert("CASH_REWARD_PAID", sqlHandler.ExecuteAsDataTable("CASH_REWARD_SHOW_PAID", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
                    Label lblCurrPage = (Label)ucontrol.FindControl("lblCurrent");
                    Label lblMaxPage = (Label)ucontrol.FindControl("lblMaxRow");
                    lblCurrPage.Text = "0";
                    lblMaxPage.Text = "0";
                }
                dt = (DataTable)HttpContext.Current.Cache["CASH_REWARD_PAID"];
                string filter = "Row >= " + (((minRow - 1) * gridview.PageSize) + 1) + " AND Row <= " + (minRow * gridview.PageSize);
                DataTable dt2 = new DataTable();
                dt2 = dt.Clone();
                DataRow[] dr = dt.Select(filter);
                foreach (DataRow row in dr)
                {
                    dt2.ImportRow(row);
                }
                gridview.DataSource = dt2;
                gridview.DataBind();
                SetPager(ucontrol, dt.Rows.Count, gridview.PageSize);
            }
            catch
            { throw; }
        }
        public static void ShowPaidLater(List<KeyValuePair<string, object>> ParameterCollection, GridView gridview, UserControl ucontrol, int minRow, bool NewSearch)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                DataSet ds = new DataSet();
                DataSet ds2 = new DataSet();
                DataTable dt = new DataTable();
                if (NewSearch == true)
                {
                    HttpContext.Current.Cache.Insert("CASH_REWARD_PAID_LATER", sqlHandler.ExecuteAsDataTable("CASH_REWARD_SHOW_PAID_LATER", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
                    Label lblCurrPage = (Label)ucontrol.FindControl("lblCurrent");
                    Label lblMaxPage = (Label)ucontrol.FindControl("lblMaxRow");
                    lblCurrPage.Text = "0";
                    lblMaxPage.Text = "0";
                }
                dt = (DataTable)HttpContext.Current.Cache["CASH_REWARD_PAID_LATER"];
                string filter = "Row >= " + (((minRow - 1) * gridview.PageSize) + 1) + " AND Row <= " + (minRow * gridview.PageSize);
                DataTable dt2 = new DataTable();
                dt2 = dt.Clone();
                DataRow[] dr = dt.Select(filter);
                foreach (DataRow row in dr)
                {
                    dt2.ImportRow(row);
                }
                gridview.DataSource = dt2;
                gridview.DataBind();
                SetPager(ucontrol, dt.Rows.Count, gridview.PageSize);
            }
            catch
            { throw; }
        }
        private static void SetPager(UserControl uControl,int maxRows,int GridSize)
        {
            TextBox txtValue = (TextBox)uControl.FindControl("txtValue");
            Label lblCurrPage = (Label)uControl.FindControl("lblCurrent");
            Label lblMaxPage = (Label)uControl.FindControl("lblMaxRow");
            Button btnNext = (Button)uControl.FindControl("btnNext");
            int CurrPage = Convert.ToInt16(lblCurrPage.Text);
            int MaxPage = Convert.ToInt16(lblMaxPage.Text);
            lblCurrPage.Text = Convert.ToString(CurrPage = CurrPage == 0 ? 1 : CurrPage);
            lblMaxPage.Text = Convert.ToString(MaxPage = MaxPage == 0 ? maxRows : MaxPage);
            btnNext.Visible = (Convert.ToDouble(MaxPage) / GridSize) > 1 ? true : false;
            btnNext.Visible = (Convert.ToDouble(MaxPage) / GridSize) <= CurrPage ? false : true;
        }
        
        public static void PaidConvertXls(List<KeyValuePair<string, object>> ParameterCollection)
        {
            try
            {
                CommonFunction cf = new CommonFunction();
                SQLHandler sqlHandler = new SQLHandler();
                DataTable dt = new DataTable();
                dt = sqlHandler.ExecuteAsDataTable("CASH_REWARD_SHOW_PAID", ParameterCollection);
                cf.ExportDataTableToXLS(dt, "CRPaidInSamePeriod_" + DateTime.Now.ToString());
            }
            catch
            { throw; }
        }
        public static void PaidLaterConvertXls(List<KeyValuePair<string, object>> ParameterCollection)
        {
            try
            {   CommonFunction cf = new CommonFunction();
                SQLHandler sqlHandler = new SQLHandler();
                DataTable dt = new DataTable();
                 dt =   sqlHandler.ExecuteAsDataTable("CASH_REWARD_SHOW_PAID_LATER", ParameterCollection);
                 cf.ExportDataTableToXLS(dt, "CRPaidNotInSamePeriod_" + DateTime.Now.ToString());          
            }
            catch
            { throw; }
        }

        public static void insertCRHeader_WF(List<KeyValuePair<string, object>> ParameterCollection)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                HttpContext.Current.Cache.Insert("CASH_REWARD_HEADER_INS", sqlHandler.ExecuteAsDataTable("CASH_REWARD_HEADER_INSERT", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);
            }
            catch
            { throw; }
        }

        public String CheckCR_WF_status(List<KeyValuePair<string, object>> ParameterCollection)
        {
            string status = "";
            SQLHandler shand = new SQLHandler();
            HttpContext.Current.Cache.Insert("CASH_REWARD_CHECK_WF", shand.ExecuteAsDataReader("CASH_REWARD_CHECK_WF_STATUS", ParameterCollection), null, Cache.NoAbsoluteExpiration, TimeSpan.Zero);    
            SqlDataReader sdr;
            sdr = shand.ExecuteAsDataReader("CASH_REWARD_CHECK_WF_STATUS", ParameterCollection);
            
            while (sdr.Read())
            {
                status = sdr[0].ToString();
            }
            return status;
        }
    }
}
