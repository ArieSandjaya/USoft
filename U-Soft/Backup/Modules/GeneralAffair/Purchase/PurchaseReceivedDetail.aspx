<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseReceivedDetail.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Purchase.PurchaseReceivedDetail" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Purchase Received Detail</title>
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.css" />
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/ui-layout.css" />
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/validationEngine.jquery.css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../../Javascript/date.js"></script>
    <script type="text/javascript" src="../../../Javascript/NumberFormat.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript" src="../../../Javascript/general.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="pnlDataPage" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="width: 100%">
                    <tr>
                        <td class="ui-widget-content" colspan="2">
                            <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                        </td>
                    </tr>
                    <tr><td colspan="2"><asp:Label ID="lblMessage" runat="server" CssClass="InfoWarn"></asp:Label></td></tr>
                    <tr>
                        <td class="ui-widget-content" style="width: 50%;" valign="top">
                            <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td class="form_table_title" style="width: 100px;">Received ID</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblReceivedID" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Received Date</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblReceivedDate" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Order ID</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblOrderID" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Order Date</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblOrderDate" runat="server"></asp:Label></td>
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
                                    <td class="form_table_title">PIC</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblPIC" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                        <td class="ui-widget-content" style="width: 50%;" valign="top">
                            <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td class="form_table_title" style="width: 100px;">Description</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblDescription" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Status</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblStatus" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Request By</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblCreatedBy" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Update By</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblUpdateBy" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td class="form_table_btn">
                                        <asp:ImageButton ID="imbApprove" runat="server" ImageUrl="~/Images/BtnApprove.png" OnClick="imbApprove_Click" />
                                        <asp:ImageButton ID="imbReject" runat="server" ImageUrl="~/Images/BtnReject.png" OnClick="imbReject_Click" />
                                        <asp:ImageButton ID="imbRFA" runat="server" ImageUrl="~/Images/BtnRFA.png" OnClick="imbRFA_Click" />
                                        <asp:ImageButton ID="imbEditHeader" runat="server" ImageUrl="~/Images/BtnEditHeader.png" OnClick="imbEditHeader_Click" />
                                        <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                        <td class="ui-widget-content" colspan="2">
                            <uc1:ctrlFormHeader ID="ucHeaderDetail" runat="server" />
                            <asp:GridView ID="gvPurchaseDetail" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" OnRowDataBound="gvPurchaseDetail_RowDataBound" OnRowDeleting="gvPurchaseDetail_RowDeleting" OnRowCommand="gvPurchaseDetail_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="RECEIVEDDETAILID" HeaderText="RECEIVED DETAIL ID" >
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NO" HeaderText="NO">
                                        <ItemStyle HorizontalAlign="Center" Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="REQUESTID" HeaderText="REQUEST ID" >
                                        <ItemStyle HorizontalAlign="Center" Width="160px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ITEMGROUPNAME" HeaderText="ITEM GROUP NAME" />
                                    <asp:BoundField DataField="ITEMTYPENAME" HeaderText="ITEM TYPE NAME" />
                                    <asp:BoundField DataField="QUANTITY" HeaderText="QTY">
                                        <ItemStyle HorizontalAlign="Right" Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MEASUREMENTCODE" HeaderText="MEASURE">
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CURRENTQTY" HeaderText="QTY-O">
                                        <ItemStyle HorizontalAlign="Right" Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RECEIVEDQTY" HeaderText="QTY-R">
                                        <ItemStyle HorizontalAlign="Right" Width="40px" />
                                    </asp:BoundField>
                                    <asp:CommandField HeaderText="ACTION" ShowEditButton="True" ShowDeleteButton="True">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr id="trItemDetail" runat="server">
                        <td class="ui-widget-content" colspan="2">
                            <uc1:ctrlFormHeader ID="ucHeaderItemDetail" runat="server" />
                            <asp:GridView ID="gvPurchaseItemDetail" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" OnRowDataBound="gvPurchaseItemDetail_RowDataBound" OnRowEditing="gvPurchaseItemDetail_RowEditing">
                                <Columns>
                                    <asp:BoundField DataField="REQUESTDETAILID" HeaderText="REQUEST DETAIL ID" >
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NO" HeaderText="NO">
                                        <ItemStyle HorizontalAlign="Center" Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="REQUESTID" HeaderText="REQUEST ID" >
                                        <ItemStyle HorizontalAlign="Center" Width="160px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ITEMGROUPNAME" HeaderText="ITEM GROUP NAME" />
                                    <asp:BoundField DataField="ITEMTYPENAME" HeaderText="ITEM TYPE NAME" />
                                    <asp:BoundField DataField="QUANTITY" HeaderText="QTY">
                                        <ItemStyle HorizontalAlign="Right" Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MEASUREMENTCODE" HeaderText="MEASURE">
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="QTYOUTSTANDING" HeaderText="QTY-O">
                                        <ItemStyle HorizontalAlign="Right" Width="40px" />
                                    </asp:BoundField>
                                    <asp:CommandField HeaderText="ACTION" ShowEditButton="True" EditText="Select">
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>   
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="imbApprove" />
                <asp:AsyncPostBackTrigger ControlID="imbReject" />
                <asp:AsyncPostBackTrigger ControlID="imbRFA" />
            </Triggers>
        </asp:UpdatePanel>     
    </div>  
    </form>
</body>
</html>