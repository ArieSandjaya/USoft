<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseOrderDetailAddEdit.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Purchase.PurchaseOrderDetailAddEdit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Purchase Order Detail Add Edit</title>
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
        <asp:UpdatePanel ID="pnlDataForm" runat="server" UpdateMode="Conditional">
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
                            <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td class="form_table_title" style="width: 120px;">Order ID</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblOrderID" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Order Date</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblOrderDate" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Supplier</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblSupplier" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Currency</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblCurrency" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td class="form_table_btn">
                                        <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="ui-widget-content">
                            <uc2:ctrlSearch ID="ucSearch" runat="server" />
                            <div class="form_table_btn">
                                <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                            </div>
                        </td>
                     </tr>
                    <tr>
                        <td>
                            <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView ID="gvPurchase" runat="server" AutoGenerateColumns="False"
                                         Font-Size="8pt" Style="width: 100%" OnRowDataBound="gvPurchase_RowDataBound" EmptyDataText="No Data Available" OnRowEditing="gvPurchase_RowEditing">
                                        <Columns>
                                            <asp:BoundField DataField="REQUESTID" HeaderText="REQUEST ID" >
                                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="DATE" >
                                                <ItemStyle HorizontalAlign="Center" Width="80px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="BRANCHNAME" HeaderText="BRANCH" />
                                            <asp:BoundField DataField="USERNAME" HeaderText="REQUEST BY" />
                                            <asp:BoundField DataField="TOTAL" HeaderText="TOTAL" >
                                                <ItemStyle HorizontalAlign="Right" Width="120px" />
                                            </asp:BoundField>
                                            <asp:CommandField HeaderText="ACTION" ShowEditButton="True" EditText="Select">
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>                      
    </form>
</body>
</html>