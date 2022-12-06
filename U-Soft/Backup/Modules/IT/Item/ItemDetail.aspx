<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemDetail.aspx.cs" Inherits="USoft.Modules.IT.Item.ItemDetail" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item-In Detail</title>
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
            <tr><td><asp:Label ID="lblMessage" runat="server" CssClass="InfoWarn"></asp:Label></td></tr>
            <tr>
                <td class="ui-widget-content">
                    <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                        <tr>
                            <td class="form_table_title" style="width: 160px;">Item Code</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblItemCode" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Item-In Detail Code</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblItemInDtlCode" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Item-Transfer Detail Code</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblItemTransDtlCode" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Item-Out Detail Code</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblItemOutDtlCode" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Type</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblType" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Serial No</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblSerialNo" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Barcode</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblBarcode" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Model</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblDescription" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Condition</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblCondition" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Status In</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblStatusIn" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Status Out</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblStatusOut" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Current Location</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblBranch" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Used By</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblUsedBy" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Privilege</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblPrivilege" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td class="form_table_title">Active Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblIsActive" runat="server"></asp:Label></td></tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/Images/BtnEdit.png" OnClick="imbEdit_Click" />
                                <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                            </td></tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                        <uc1:ctrlFormHeader ID="ucHeaderHistory" runat="server" />
                        <asp:GridView ID="gvItemHistory" runat="server" AutoGenerateColumns="False"
                             Font-Size="8pt" Style="width: 100%"  EmptyDataText="No Data Available" OnRowDataBound="gvItemHistory_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="created_date" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="DATE" >
                                    <ItemStyle HorizontalAlign="Center" Width="130px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Barcode" HeaderText="BARCODE" />
                                <asp:BoundField DataField="ConditionName" HeaderText="CONDITION">
                                    <ItemStyle HorizontalAlign="Center"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="BranchName" HeaderText="CURRENT LOCATION" >
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="UsedBy" HeaderText="USED BY" />
                                <asp:BoundField DataField="Remark" HeaderText="REMARK" />
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
