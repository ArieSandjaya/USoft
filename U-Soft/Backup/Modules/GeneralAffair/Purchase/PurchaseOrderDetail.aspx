<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseOrderDetail.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Purchase.PurchaseOrderDetail" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Purchase Order Detail</title>
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
                                    <td class="form_table_title" style="width: 100px;">Order ID</td>
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
                                    <td class="form_table_title">Total</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblTotal" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">PIC</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblPIC" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Delivery Date</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblDeliveryDate" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Description</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblDescription" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                        <td class="ui-widget-content" style="width: 50%;" valign="top">
                            <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td class="form_table_title" style="width: 100px;">Offer From</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblOfferFrom" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Offer No</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblOfferNo" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Offer Date</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblOfferDate" runat="server"></asp:Label></td>
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
                                    <td class="form_table_title">Status</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblStatus" runat="server"></asp:Label></td>
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
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" 
                                 OnRowDataBound="gvPurchaseDetail_RowDataBound" OnRowDeleting="gvPurchaseDetail_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="ORDERDETAILID" HeaderText="DETAIL ID">
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NO" HeaderText="NO">
                                        <ItemStyle HorizontalAlign="Center" Width="40px" />
                                    </asp:BoundField>
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
                                    <asp:CommandField HeaderText="ACTION" ShowDeleteButton="True">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                            <br />
                            <div class="form_table_btn">
                                <asp:ImageButton ID="imbAddDetail" runat="server" ImageUrl="~/Images/BtnAddDetail.png" OnClick="imbAddDetail_Click" />
                            </div>
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                        <td class="ui-widget-content" colspan="2">
                            <uc1:ctrlFormHeader ID="ucHeaderItemDetail" runat="server" />
                            <asp:GridView ID="gvPurchaseItemDetail" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" OnRowDataBound="gvPurchaseItemDetail_RowDataBound">
                                <Columns>
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
                                    <asp:BoundField DataField="PRICE" HeaderText="PRICE" >
                                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TOTAL" HeaderText="TOTAL" >
                                        <ItemStyle HorizontalAlign="Right" Width="120px" />
                                    </asp:BoundField>
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