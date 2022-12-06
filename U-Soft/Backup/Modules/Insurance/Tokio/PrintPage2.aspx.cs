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
using System.Threading;
using System.Globalization;

namespace USoft.Insurance.Tokio
{
    public partial class PrintPage2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
            try
            {
                string style = @"<style>.text{ mso-number-format:\@; } </style>";
                gdView.DataSource = (DataSet)Session["Tokio"];
                gdView.DataBind();
                HttpContext.Current.Response.AppendHeader("Content-Disposition", string.Format("attachment;filename=Tokio" + DateTime.Now.ToString()+ ".xls"));
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
            catch
            {
 
            }
        }
        protected void gdView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[2].Attributes.Add("class", "text");
            e.Row.Cells[14].Attributes.Add("class", "text");
            e.Row.Cells[15].Attributes.Add("class", "text");
        }
    }
}
