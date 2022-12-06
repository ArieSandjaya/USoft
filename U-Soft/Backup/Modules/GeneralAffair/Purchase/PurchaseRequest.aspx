<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseRequest.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Purchase.PurchaseRequest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Purchase Request</title>
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.css" />
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/ui-layout.css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
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
                    <uc2:ctrlSearch ID="ucSearch" runat="server" />
                    <table style="width: 100%" cellspacing="1" cellpadding="0" border="0">
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFStatus" runat="server" >
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="D">Draft</asp:ListItem>
                                    <asp:ListItem Value="R">RFA</asp:ListItem>
                                    <asp:ListItem Value="A">Approve</asp:ListItem>
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
                            <asp:GridView ID="gvPurchase" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" OnRowDataBound="gvPurchase_RowDataBound" EmptyDataText="No Data Available" OnRowCommand="gvPurchase_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="REQUESTID" HeaderText="REQUEST ID" >
                                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="DATE" >
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ITEMCATEGORYNAME" HeaderText="CATEGORY" />
                                    <asp:BoundField DataField="BRANCHNAME" HeaderText="BRANCH">
                                        <ItemStyle Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SUPPLIERNAME" HeaderText="SUPPLIER" />
                                    <asp:BoundField DataField="USERNAME" HeaderText="REQUEST BY">
                                        <ItemStyle Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TOTAL" HeaderText="TOTAL" >
                                        <ItemStyle HorizontalAlign="Right" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CURRENCYCODE" HeaderText="CURR" >
                                        <ItemStyle HorizontalAlign="Center" Width="60px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="STATUS" HeaderText="STATUS" >
                                        <ItemStyle HorizontalAlign="Center" Width="70px" />
                                    </asp:BoundField>
                                    <asp:CommandField HeaderText="ACTION" ShowEditButton="True" EditText="Detail">
                                        <ItemStyle HorizontalAlign="Center" Width="70px" />
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