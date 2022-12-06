<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemTransDetail.aspx.cs" Inherits="USoft.Modules.IT.Item.ItemTransDetail" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item-Trans Detail</title>
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
                        <td class="ui-widget-content">
                            <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                        </td>
                    </tr>
                    <tr><td><asp:Label ID="lblMessage" runat="server" CssClass="InfoWarn"></asp:Label></td></tr>
                    <tr>
                        <td class="ui-widget-content">
                            <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td class="form_table_title">Document Status</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblStatus" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title" style="width: 120px;">Item Transfer Code</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblItemTransCode" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title">Origin</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblBranchFrom" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title">Destination</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblBranchTo" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title">Transfer Date</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblTransDate" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title">Created By</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblCreatedName" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td class="form_table_btn">
                                        <asp:ImageButton ID="imbApprove" runat="server" ImageUrl="~/Images/BtnApprove.png" OnClick="imbApprove_Click" />
                                        <asp:ImageButton ID="imbReject" runat="server" ImageUrl="~/Images/BtnReject.png" OnClick="imbReject_Click" />
                                        <asp:ImageButton ID="imbRFA" runat="server" ImageUrl="~/Images/BtnRFA.png" OnClick="imbRFA_Click" />
                                        <asp:ImageButton ID="imbEditHeader" runat="server" ImageUrl="~/Images/BtnEditHeader.png" OnClick="imbEditHeader_Click" />
                                        <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                                    </td></tr>
                            </table>
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                     <tr>
                        <td class="ui-widget-content" colspan="2">
                            <uc1:ctrlFormHeader ID="ucHeaderDetail" runat="server" />
                            <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                <asp:GridView ID="gvItemTransDetail" runat="server" AutoGenerateColumns="False"
                                     Font-Size="8pt" Style="width: 100%"  EmptyDataText="No Data Available"
                                     OnRowDataBound="gvItemTransDetail_RowDataBound" OnRowCommand="gvItemTransDetail_RowCommand" OnRowDeleting="gvItemTransDetail_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="ITItemTransDtlCode" HeaderText="TRF CODE" >
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITItemTransCode" HeaderText="TRANSFER HEADER CODE">
                                            <ItemStyle CssClass="hide"/><ControlStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><FooterStyle CssClass="hide" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITItemCode" HeaderText="ITEM CODE" >
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ItemTypeName" HeaderText="ITEM TYPE" >
                                            <ItemStyle Width="120px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SerialNo" HeaderText="SERIAL NO" />
                                        <asp:BoundField DataField="Barcode" HeaderText="BARCODE" />
                                        <asp:BoundField DataField="Description" HeaderText="MODEL" />
                                        <asp:BoundField DataField="ParentCode" HeaderText="PARENT CODE">
                                            <ItemStyle CssClass="hide"/><ControlStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><FooterStyle CssClass="hide" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ConditionName" HeaderText="CONDITION">
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UsedBy" HeaderText="USED BY" />                                        
                                        <asp:CommandField HeaderText="ACTION" ShowDeleteButton="True" ShowEditButton="True">
                                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                                        </asp:CommandField>
                                    </Columns>
                                    <HeaderStyle CssClass="ui-widget-header" />
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="imbApprove" />
                                    <asp:AsyncPostBackTrigger ControlID="imbReject" />
                                    <asp:AsyncPostBackTrigger ControlID="imbRFA" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <br />
                                <div class="form_table_btn">
                                    <asp:ImageButton ID="imbAddDetail" runat="server" ImageUrl="~/Images/BtnAddDetail.png" OnClick="imbAddDetail_Click" />
                                </div>
                        </td>
                     </tr>
                </table>   
            </ContentTemplate>
        </asp:UpdatePanel>     
    </div>  
    </form>
</body>
</html>
