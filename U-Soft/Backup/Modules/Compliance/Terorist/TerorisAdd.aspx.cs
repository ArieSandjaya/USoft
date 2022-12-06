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
using System.IO;
using USoft.Compliance.Teroris;
using USoft.Globalization;

namespace USoft.Modules.Compliance
{
    public partial class TerorisAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label lbl = (Label)CtrlFormHeader1.FindControl("lblHeader");
                lbl.Text = "Add New Terorists";
            }
        }

        protected void btnProcess_Click(object sender, EventArgs e)
        {
            if (fuExcell.HasFile)
            {
                string strFileName = Server.HtmlEncode(fuExcell.FileName);
                string strExtension = Path.GetExtension(strFileName);
                if (strExtension != ".xls" && strExtension != ".xlsx")
                {
                    Response.Write("<script>alert('Please select a Excel spreadsheet to import!');</script>");
                    return;
                }
                string strUploadFileName = "~/Modules/Compliance/Data/" + DateTime.Now.ToString("yyyyMMddHHmmss") + strExtension;
                fuExcell.SaveAs(Server.MapPath(strUploadFileName));
                AddTerorist AddTerorist = new AddTerorist();
                gvTeroris.DataSource = AddTerorist.ExportToDb(strExtension, Server.MapPath(strUploadFileName));
                gvTeroris.DataBind();
                if (gvTeroris.Rows.Count > 0)
                {
                    btnSave.Visible = true;
                }
                else
                {
                    btnSave.Visible = false;
                }
            }
            btnSave.Visible = false;
            updTeroris.Update();
            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            AddTerorist AddTerorist = new AddTerorist();
            gvTeroris.DataSource = AddTerorist.SaveImportes();
            gvTeroris.DataBind();
            updTeroris.Update();
            CekSessions.UnBlockUI(this.Page, this.updTeroris, ScriptManager1);
        }

        protected void btnSaveManual_Click(object sender, EventArgs e)
        {

        }
    }
}
