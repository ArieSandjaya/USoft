<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleTask.aspx.cs" Inherits="USoft.Modules.IT.ScheduleTask" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Schedule Task</title>
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
        <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="width: 100%">
			        <tr>
                        <td class="ui-widget-content">
                            <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                        </td>
                    </tr>
                    <tr><td><asp:Label ID="lblMessage" runat="server" CssClass="InfoWarn"></asp:Label></td></tr>
                    <tr>
                        <td class="ui-widget-content">
                            <uc2:ctrlSearch ID="ucSearch" runat="server" />
                            <div class="form_table_btn">
                                <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                                <asp:ImageButton ID="imbCreate" runat="server" ImageUrl="~/Images/BtnCreate.png" OnClick="imbCreate_Click" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
			        <tr>
                        <td class="ui-widget-content">
                            <uc1:ctrlFormHeader ID="ucHeaderPageNext" runat="server" />
                            <asp:GridView ID="gvScheduleTaskNext" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" PagerStyle-HorizontalAlign="Center" 
                                 OnPageIndexChanging="gvScheduleTaskNext_PageIndexChanging" OnRowDataBound="gvScheduleTaskNext_RowDataBound" OnRowDeleting="gvScheduleTaskNext_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="SCHEDULENO" HeaderText="NO">
                                        <ItemStyle HorizontalAlign="Center" Width="70px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SCHEDULETYPE" HeaderText="TYPE">
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SCHEDULETITLE" HeaderText="TITLE" />
                                    <asp:BoundField DataField="STARTDATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="START">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ENDDATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="END">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="INTERVALTIME" HeaderText="TIME">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="USERCREATED" HeaderText="CREATED BY">
                                        <ItemStyle Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NEXTDATE" HeaderText="NEXT">
                                        <ItemStyle HorizontalAlign="Center" Width="120px" />
                                    </asp:BoundField>
                                    <asp:CommandField HeaderText="ACTION" ShowDeleteButton="True" DeleteText="Finish">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                                <PagerStyle CssClass="ui-widget-header"  />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td class="ui-widget-content">
                            <uc1:ctrlFormHeader ID="ucHeaderPageData" runat="server" />
                            <asp:GridView ID="gvScheduleTask" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available"  
                                 OnRowDataBound="gvScheduleTask_RowDataBound" OnRowCommand="gvScheduleTask_RowCommand" OnRowDeleting="gvScheduleTask_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="SCHEDULENO" HeaderText="NO">
                                        <ItemStyle HorizontalAlign="Center" Width="70px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SCHEDULETYPE" HeaderText="TYPE">
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SCHEDULETITLE" HeaderText="TITLE" />
                                    <asp:BoundField DataField="STARTDATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="START">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ENDDATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="END">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="INTERVALTIME" HeaderText="TIME">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="USERCREATED" HeaderText="CREATED BY">
                                        <ItemStyle Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="STATUS" HeaderText="STATUS">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:CommandField HeaderText="ACTION" ShowDeleteButton="True" ShowEditButton="True">
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                            <uc3:ctrlGridPager ID="ucGridPager" runat="server" OnPagerClicked="PagerClick" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="imbSearch" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>