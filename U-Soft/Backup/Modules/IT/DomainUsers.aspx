<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DomainUsers.aspx.cs" Inherits="USoft.Modules.IT.DomainUsers" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Domain Users</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/black-tie/jquery-ui-1.9.2.custom.css" />
    <link rel="stylesheet" type="text/css" href="../../CSS/black-tie/ui-layout.css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
                $("#imbSearch").click(function(){
                       $.blockUI({message: '<h3><IMG SRC="../../CSS/black-tie/images/loading6.gif" /></h3>'});});
        });
        
		
//		function ValidatePage(){
//		    //$("#imbSubmit").click(function(){
//            //        $.blockUI({message: '<h3><IMG SRC="../../CSS/black-tie/images/loading6.gif" /></h3>'});});
//		
//		    if($('#form1').validationEngine('validate')){
//                if(confirm('Submit Data ?')) {
//                    //window.parent.parent.loadWait();
//                    
//                    return true;
//                }
//            }
//            return false;
//        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <table style="width: 100%" cellspacing="1" cellpadding="0" border="0">
                        <tr>
                            <td colspan="3">
                                <uc1:ctrlFormHeader ID="ucHeaderPage2" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Branch</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlBranch" runat="server" ></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <div class="form_table_btn">
                        <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                        <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Images/BtnUpdate.png" OnClick="imbUpdate_Click" />
                        <asp:ImageButton ID="imbCreate" runat="server" ImageUrl="~/Images/BtnCreate.png" OnClick="imbCreate_Click" />
                    </div>
                </td>
             </tr>
             <tr>
                <td>
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvDomainUsers" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" >
                                <Columns>
                                    <asp:BoundField DataField="No" HeaderText="No">
                                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="UserName" HeaderText="User Name" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Organization" HeaderText="Dept" />
                                    <asp:BoundField DataField="Branch" HeaderText="Branch" />
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlBranch" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>