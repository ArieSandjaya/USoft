<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Item.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Item" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item Warehouse</title>
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
                            <td class="form_table_title">Item Category</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFItemCategory" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Item Group</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFItemGroup" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Item Type</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFItemType" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                            </td>    
                        </tr>
                    </table>
                </td>
             </tr>
             <tr>
                <td>
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvItem" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available">
                                <Columns>
                                    <asp:BoundField DataField="ITEMCODE" HeaderText="CODE">
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BRANCHNAME" HeaderText="BRANCH">
                                        <ItemStyle Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ITEMGROUPNAME" HeaderText="GROUP" />
                                    <asp:BoundField DataField="ITEMTYPENAME" HeaderText="TYPE" />
                                    <asp:BoundField DataField="QUANTITY" HeaderText="QTY">
                                        <ItemStyle HorizontalAlign="Right" Width="60px"  />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MEASUREMENTCODE" HeaderText="MEASURE">
                                        <ItemStyle HorizontalAlign="Center" Width="60px"  />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="REQUESTQTY" HeaderText="QTY-R">
                                        <ItemStyle HorizontalAlign="Right" Width="60px"  />
                                    </asp:BoundField>
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