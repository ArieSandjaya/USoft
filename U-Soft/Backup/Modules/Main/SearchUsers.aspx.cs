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
using USoft.Globalization.Users;
using System.Collections.Generic;
using USoft.Common.Shared;

namespace USoft.Modules.Main
{
    public partial class SearchUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label lbl = (Label)CtrlFormHeader.FindControl("lblHeader");
                lbl.Text = "Search Users";
                gvUser.PageSize = USoft.Common.Setting.SystemSetting.PagingSize;
                gvUser.DataSource = EmptyData();
                gvUser.DataBind();
            }
        }

        private DataSet EmptyData()
        {
            List<string> ColumName = new List<string>();
            ColumName.Add("UserId");
            ColumName.Add("UserName");
            ColumName.Add("BranchName");
            ColumName.Add("Active");
            ColumName.Add("Email");
            ColumName.Add("ChangePass");
            ColumName.Add("CanSendMail");
            ColumName.Add("PriviledgeCode"); 
            
            SQLHelper helper = new SQLHelper();
            return helper.EmptyDataSet(ColumName);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DropDownList ddlIsActive = (DropDownList)CtrlIsActive.FindControl("ddlIsActive");
            string IsActive = ddlIsActive.SelectedItem.Value.ToString();
            string UserId = txtUserID.Text;
            string UserName = txtUserName.Text;
            GetUsers(IsActive, UserId, UserName);
        }

        private void GetUsers(string Status,string UserId,string UserName)
        {
            UserSearch USearch = new UserSearch();
            USearch.Status = Status;
            USearch.UserID = UserId;
            USearch.UserName = UserName;
            gvUser.DataSource= USearch.GetUser();
            gvUser.DataBind();
            updPanel.Update();
        }
        private void resetPassword(string userid)
        {
            UserSearch Usearch = new UserSearch();
            Usearch.UserID = userid;
            
            string newString = Usearch.resetPWD();
            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Password Has been Reset');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error When Reset Password');", true);
            }
        }


        protected void gvUser_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "Select") 
            {
                string userId = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text;
                string userName = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[2].Text;
                string branchName = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[3].Text;
                CheckBox chk = (CheckBox)gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].FindControl("CheckBox1");
                string status = chk.Checked == true ? "1" : "0";
                string email = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[5].Text;
                string chgPass = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[6].Text;
                string sendMail = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[7].Text;
                string privCode = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[8].Text; 

                Response.Redirect("EditUsers.aspx?UserId=" + userId +
                                             "&UserName=" + userName +
                                             "&BranchName=" + branchName +
                                             "&Active=" + status +
                                             "&Email=" + email +
                                             "&ChangePass=" + chgPass +
                                             "&CanSendMail=" + sendMail +
                                             "&PrivCode=" + privCode );
            }
            else if (e.CommandName == "Edit")
            {
                string userId = gvUser.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[1].Text;

                resetPassword(userId);
            }
        }

        protected void gvUser_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

    }
}
