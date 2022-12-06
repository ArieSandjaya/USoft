<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashRewardRecipients.aspx.cs" Inherits="USoft.Popup.CashRewardRecipients" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Cash Reward Recipients</title>
    <link rel="stylesheet" type="text/css" href="../CSS/black-tie/jquery-ui-1.9.2.custom.css" />
    <link rel="stylesheet" type="text/css" href="../CSS/black-tie/ui-layout.css" />
    <script type="text/javascript" src="../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../Javascript/ScriptSession.js"></script>
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
                <td>
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvCashRewardRecipient" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" OnRowDataBound="gvCashRewardRecipient_RowDataBound" EmptyDataText="No Data Available" OnRowCommand="gvCashRewardRecipient_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="refund_recipient_id" HeaderText="RECIPIENT ID" >
                                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="recipientName" HeaderText="RECIPIENT NAME" >
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="position" HeaderText="POSITION" />
                                    <asp:CommandField HeaderText="ACTION" EditText="Select" ShowSelectButton="True">
                                        <ItemStyle HorizontalAlign="Center" Width="70px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                            <uc3:ctrlGridPager ID="ucGridPager" runat="server" OnPagerClicked="PagerClick" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
