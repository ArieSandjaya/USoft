<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActivityTask.aspx.cs" Inherits="USoft.Modules.IT.ActivityTask" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Activity Task</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/black-tie/jquery-ui-1.9.2.custom.css" />
    <link rel="stylesheet" type="text/css" href="../../CSS/black-tie/ui-layout.css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../Javascript/ScriptSession.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table style="width: 100%" >
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr><td><asp:Label ID="lblMessage" runat="server" CssClass="InfoWarn"></asp:Label></td></tr>
            <tr>
                <td class="ui-widget-content">
                    <uc2:ctrlSearch ID="ucSearch" runat="server" />
                    <table style="width: 100%" cellspacing="1" cellpadding="0" border="0">
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Branch</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFBranch" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Problem Type</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFProblemType" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Item Type</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFItemType" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">PIC</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFPIC" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Terminated By</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFTerminatedBy" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Priority</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFPriority" runat="server" >
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="0">Low</asp:ListItem>
                                    <asp:ListItem Value="1">Medium</asp:ListItem>
                                    <asp:ListItem Value="2">High</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFStatus" runat="server" >
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="0">Open</asp:ListItem>
                                    <asp:ListItem Value="1">Assign</asp:ListItem>
                                    <asp:ListItem Value="2">Solved</asp:ListItem>
                                    <asp:ListItem Value="3">Closed</asp:ListItem>
                                    <asp:ListItem Value="4">Done</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                                <asp:ImageButton ID="imbCreate" runat="server" ImageUrl="~/Images/BtnCreate.png" OnClick="imbCreate_Click" />
                            </td>    
                        </tr>
                    </table>
                </td>
             </tr>
             <tr>
                <td>
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvActivityTask" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" 
                                 OnRowCommand="gvActivityTask_RowCommand" OnRowDataBound="gvActivityTask_RowDataBound" OnRowDeleting="gvActivityTask_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="ACTIVITYNO" HeaderText="NO">
                                        <ItemStyle HorizontalAlign="Center" Width="70px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ACTIVITYDATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="DATE">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="REQUESTBY" HeaderText="USER" />
                                    <asp:BoundField DataField="BRANCHNAME" HeaderText="BRANCH" />
                                    <asp:BoundField DataField="PROBLEMTYPENAME" HeaderText="PROBLEM TYPE" />
                                    <asp:BoundField DataField="ITEMTYPENAME" HeaderText="TYPE" />
                                    <asp:BoundField DataField="PRIORITY" HeaderText="PRIORITY">
                                        <ItemStyle HorizontalAlign="Center" Width="90px"  />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="STATUS" HeaderText="STATUS" >
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PIC" HeaderText="PIC" />
                                    <asp:BoundField DataField="TERMINATEDBY" HeaderText="TERMINATED BY" />
                                    <asp:CommandField HeaderText="ACTION" ShowDeleteButton="True" ShowEditButton="True" EditText="Detail">
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                            <uc3:ctrlGridPager ID="ucGridPager" runat="server" OnPagerClicked="PagerClick" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="imbSearch" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>