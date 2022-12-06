<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportCaller.aspx.cs" Inherits="USoft.Reports.ReportCaller" %>

<%@ Register Src="../Controls/ctrlTotalReq.ascx" TagName="ctrlTotalReq" TagPrefix="uc7" %>

<%@ Register Src="../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc6" %>
<%@ Register Src="../Controls/ctrlSingleDate.ascx" TagName="ctrlSingleDate" TagPrefix="uc5" %>
<%@ Register Src="../Controls/ctrlBranch.ascx" TagName="ctrlBranch" TagPrefix="uc4" %>
<%@ Register Src="../Controls/ctrlValue.ascx" TagName="ctrlValue" TagPrefix="uc1" %>
<%@ Register Src="../Controls/ctrlDateTime.ascx" TagName="ctrlDateTime" TagPrefix="uc2" %>
<%@ Register Src="../Controls/ctrlDatetimeRange.ascx" TagName="ctrlDatetimeRange" TagPrefix="uc3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report Caller Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript">
	$(function() {
		$("#<%=txtDateTo.ClientID %>").datepicker();
		$("#<%=txtDateFrom.ClientID %>").datepicker();
		$("#<%=txtSingleDate.ClientID %>").datepicker();
	});
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content" style="width: 100px">
                    <uc6:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True" UpdateMode="Conditional">
            <ContentTemplate>
        <table id="myTable" runat="server">
            <tr id="trValue0" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue0" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4"  class="T19">
                    <asp:TextBox ID="txtValue0" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue1" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue1" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue1" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue2" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue2" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue2" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue3" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue4" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue3" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue4" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue5" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue4" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue5" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue6" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue5" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue6" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue7" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue6" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue7" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue8" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue7" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue8" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblValue9" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue8" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trValue9" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label></td>
                <td colspan="4" class="T19">
                    <asp:TextBox ID="txtValue9" runat="server" Width="284px"></asp:TextBox></td>
            </tr>
            <tr id="trBranch" visible="false" runat="server">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="lblBranch" runat="server" Text="Branch"></asp:Label></td>
                <td colspan="2" class="T19">
                    <asp:DropDownList ID="ddlBranch" runat="server" Font-Bold="True" Font-Size="10px"
                        Style="font-family: Verdana, Arial, Helvetica, sans-serif"
                        Width="173px">
                    </asp:DropDownList></td>
                <td colspan="1">
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr id="trPeriod" runat="server" visible="false">
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="Label1" runat="server" Text="Date From"></asp:Label></td>
                <td colspan="2" class="T19">
                    <asp:TextBox ID="txtDateFrom" runat="server"></asp:TextBox></td>
                <td colspan="1" style="text-align: right" class="T17">
                    <asp:Label ID="Label2" runat="server" Text="Date From"></asp:Label></td>
                <td colspan="1" class="T19">
                    <asp:TextBox ID="txtDateTo" runat="server"></asp:TextBox></td>
            </tr>
            <tr id="trSingleDate" runat="server" visible="false">
                <td class="T17" colspan="1" style="text-align: right">
                    <asp:Label ID="Label3" runat="server" Text="Single Date"></asp:Label></td>
                <td class="T19" colspan="2">
                    <asp:TextBox ID="txtSingleDate" runat="server"></asp:TextBox></td>
                <td class="T17" colspan="1" style="text-align: right">
                </td>
                <td class="T19" colspan="1">
                </td>
            </tr>
            <tr id="trTotal" runat="server" visible="false">
                <td class="T17" colspan="1" style="text-align: right">
                    <asp:Label ID="Label4" runat="server" Text="Total"></asp:Label></td>
                <td class="T19" colspan="2">
                    <asp:DropDownList ID="ddlTotal" runat="server" Font-Bold="True" Font-Size="10px"
                        Style="font-family: Verdana, Arial, Helvetica, sans-serif" Width="137px">
                        <asp:ListItem Value="38500000000">35,000,000,000</asp:ListItem>
                        <asp:ListItem Value="93500000000">50,000,000,000</asp:ListItem>
                        <asp:ListItem Value="220000000000">115,000,000,000</asp:ListItem>
                    </asp:DropDownList></td>
                <td class="T17" colspan="1" style="text-align: right">
                </td>
                <td class="T19" colspan="1">
                </td>
            </tr>
            <tr runat="server" visible="false" id="Tr1">
                <td colspan="3">
                </td>
                <td colspan="1">
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="5" style="text-align: center" class="T19">
                </td>
            </tr>
        </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updPrint" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <div class="T19" style="width: 100px; height: 100px">
                    <asp:Button ID="btnPrint" runat="server" OnClick="btnPrint_Click" Text="Print" CssClass="ui-button ui-state-default"/></div>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
