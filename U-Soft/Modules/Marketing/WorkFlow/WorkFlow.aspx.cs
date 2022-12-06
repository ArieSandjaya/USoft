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
using USoft.Marketing.WorkFlow;
using USoft.Marketing.CashReward;
using System.Collections.Specialized;
using USoft.Globalization;

namespace USoft.Modules.Marketing.WorkFlow
{
    public partial class WorkFlow : System.Web.UI.Page
    {
        private decimal TotalAmount = 0, TotalAmountTax = 0, TotalAmountNet = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            if (!IsPostBack)
            {
                ShowWorkFlow();
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "WorkFlow";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void ShowWorkFlow()
        {
            string UID = Session["UserId"].ToString();
            //string PrivCode = Session["PriviledgeCode"].ToString();
            
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@userID", UID));
            GetWorkFlow.ShowWorkFlow(ParameterCollection, gvWorkflow);
        }

        protected void gvWorkflow_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "Edit") //View Workflow Detail
            {
                string wfID = gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[0].Text;
                string detailID = gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text;
                string paramCode = gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[2].Text;

                List<KeyValuePair<string, object>> ParCollection = new List<KeyValuePair<string, object>>();
                ParCollection.Add(new KeyValuePair<string, object>("@WF_id", wfID));
                ParCollection.Add(new KeyValuePair<string, object>("@DetailID", detailID));
                ParCollection.Add(new KeyValuePair<string, object>("@ParameterCode", paramCode));
                
                if(paramCode == "CASH_APPR")
                {
                    GetWorkFlow.ViewWorkFlow(ParCollection, gvCashRewardShow);
                    UpdatePanel1.Update();
                    tblView.Attributes.Add("class", "show");
                }
            }
            else if (e.CommandName == "Select") //Approve Workflow
            {
                string wfID = gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[0].Text;
                string detailID = gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text;
                string updBy = Session["UserId"].ToString();
                int rowId = Convert.ToInt32(e.CommandArgument.ToString());
                if (gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text != "")
                {
                    StatusWorkFlow WFstatus = new StatusWorkFlow();
                    List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                    ParameterCollection.Add(new KeyValuePair<string, object>("@wfID", wfID));
                    ParameterCollection.Add(new KeyValuePair<string, object>("@detailID", detailID));
                    ParameterCollection.Add(new KeyValuePair<string, object>("@status", "APPROVED"));
                    ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", updBy));

                    if (WFstatus.SetWFStatus(ParameterCollection) == true)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have Approved this application');", true);
                        gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].CssClass = "hide";
                        updPanel.Update();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Approved This Application');", true);
                    }
                }
            }
            else if (e.CommandName == "Delete") //Reject Workflow
            {
                string wfID = gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[0].Text;
                string detailID = gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text;
                string updBy = Session["UserId"].ToString();
                int rowId = Convert.ToInt32(e.CommandArgument.ToString());
                if (gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text != "")
                {
                    StatusWorkFlow WFstatus = new StatusWorkFlow();
                    List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                    ParameterCollection.Add(new KeyValuePair<string, object>("@wfID", wfID));
                    ParameterCollection.Add(new KeyValuePair<string, object>("@detailID", detailID));
                    ParameterCollection.Add(new KeyValuePair<string, object>("@status", "REJECTED"));
                    ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", updBy));

                    if (WFstatus.SetWFStatus(ParameterCollection) == true)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have Rejected this application');", true);
                        gvWorkflow.Rows[Convert.ToInt32(e.CommandArgument.ToString())].CssClass = "hide";
                        updPanel.Update();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Rejected This Application');", true);
                    }
                }
            }
        } 
        //view
        protected void gvWorkflow_RowEditing(object sender, GridViewEditEventArgs e)
        {
           
        }
        protected void gvWorkflow_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
        protected void img_close_Click(object sender, ImageClickEventArgs e)
        {
            tblView.Attributes.Add("class", "hide");
        }

        protected void gvCashRewardShow_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TotalAmount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
                TotalAmountTax = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalTax"));
                TotalAmountNet = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalNet"));
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotal = (Label)e.Row.FindControl("lblTotalAmount");
                lblTotal.Text = TotalAmount.ToString("Rp, 0,0.00");
                Label lblTotalTax = (Label)e.Row.FindControl("lblTotalTax");
                lblTotalTax.Text = TotalAmountTax.ToString("0,0.00");
                Label lblTotalNet = (Label)e.Row.FindControl("lblTotalNet");
                lblTotalNet.Text = TotalAmountNet.ToString("0,0.00");
            }
        }

    }
}
