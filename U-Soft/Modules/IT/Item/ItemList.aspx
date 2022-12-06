<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemList.aspx.cs" Inherits="USoft.Modules.IT.Item.ItemList" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item-In</title>
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
                            <td class="form_table_title" style="width: 120px;">Current Location</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFBranch" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Type</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFType" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Condition</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFCondition" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">In Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFInStatus" runat="server">
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="1">New</asp:ListItem>
                                    <asp:ListItem Value="2">Return</asp:ListItem>
                                    <asp:ListItem Value="3">Replace</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Out Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFOutStatus" runat="server">
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="1">Repair</asp:ListItem>
                                    <asp:ListItem Value="2">Dispose</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Active Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFActiveStatus" runat="server">
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="0">Non Active</asp:ListItem>
                                    <asp:ListItem Value="1">Active</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <div class="form_table_btn">
                        <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                    </div>
                </td>
             </tr>
             <tr>
                <td>
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvItemList" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" 
                                 OnRowDataBound="gvItemList_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="ITItemCode" HeaderText="ITEM CODE" >
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ItemTypeName" HeaderText="TYPE" ></asp:BoundField>
                                    <asp:BoundField DataField="SerialNo" HeaderText="SERIAL NO" ></asp:BoundField>
                                    <asp:BoundField DataField="Barcode" HeaderText="BARCODE" ></asp:BoundField>
                                    <asp:BoundField DataField="ConditionName" HeaderText="CONDITION">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StatusIn" HeaderText="IN STATUS">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StatusOut" HeaderText="OUT STATUS">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BranchName" HeaderText="CURRENT LOCATION">
                                        <ItemStyle Width="140px" />
                                    </asp:BoundField>    
                                    <asp:BoundField DataField="IsActive" HeaderText="ACTIVE STATUS">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:BoundField>                                      
                                    <asp:TemplateField HeaderText="ACTION">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                    </asp:TemplateField>
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