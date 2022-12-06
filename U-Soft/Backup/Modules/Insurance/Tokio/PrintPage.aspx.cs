using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Globalization;


namespace USoft.Insurance.Tokio
{
    public partial class PrintPage : System.Web.UI.Page
    {
        //string BranchCode;
        //DateTime dtFrom;
        //DateTime dtTo;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            //Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
            //BranchCode = Convert.ToString(Request.QueryString["BranchCode"]);
            //dtFrom = Convert.ToDateTime(Request.QueryString["dtFrom"]);
            //dtTo = Convert.ToDateTime(Request.QueryString["dtTo"]);
            //string ConnString = ConfigurationManager.ConnectionStrings["tokio"].ConnectionString;
            //SqlConnection sConn = new SqlConnection();
            //sConn.ConnectionString = ConnString;
            //try
            //{
            //    sConn.Open();
            //    string SQLString = "EXEC ToxioExcel '" + BranchCode + "','" + dtFrom + "','" + dtTo + "'";
            //    string style = @"<style>.text{ mso-number-format:\@; } </style>"; 
            //    SqlDataAdapter sDa = new SqlDataAdapter(SQLString, sConn);
            //    DataTable dtDetail = new DataTable();
            //    //dtDetail.Locale = new CultureInfo("en-US");
            //    sDa.Fill(dtDetail);

            //    gdView.DataSource = dtDetail;
            //    gdView.DataBind();
            //    HttpContext.Current.Response.AppendHeader("Content-Disposition", string.Format("attachment;filename=Tokio.xls"));
            //    HttpContext.Current.Response.Charset = "UTF-8";
            //    HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
            //    HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            //    HttpContext.Current.Response.Write(style);
            //    gdView.Page.EnableViewState = false;
            //    System.IO.StringWriter tw = new System.IO.StringWriter();
            //    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            //    gdView.RenderControl(hw);
            //    HttpContext.Current.Response.Write(tw.ToString());
            //    HttpContext.Current.Response.End();
                

            //    sConn.Close();
            //}
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
            try 
            {
                string style = @"<style>.text{ mso-number-format:\@; } </style>";
                gdView.DataSource = (DataSet)Session["Tokio"];
                gdView.DataBind();
                HttpContext.Current.Response.AppendHeader("Content-Disposition", string.Format("attachment;filename=Tokio" + DateTime.Now.ToString() + ".xls"));
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
                HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.Write(style);
                gdView.Page.EnableViewState = false;
                System.IO.StringWriter tw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
                gdView.RenderControl(hw);
                HttpContext.Current.Response.Write(tw.ToString());
                HttpContext.Current.Response.End();
            }
            catch (InvalidCastException ex)
            { }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {

        }

        protected void gdView_DataBound(object sender, EventArgs e)
        {
            
        }

        protected void gdView_RowCreated(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gdView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[2].Attributes.Add("class", "text");
            e.Row.Cells[14].Attributes.Add("class", "text");
            e.Row.Cells[15].Attributes.Add("class", "text");
        }
    }
}
