<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dealer.aspx.cs" Inherits="USoft.Modules.Compliance.Master.dealer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsActive" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Dealer Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
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
                        <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                            <tr>
                                <td class="form_table_title" style="width: 120px;">Dealer Code</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:TextBox ID="txtDealerCode" runat="server" MaxLength="20" Width="90px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Dealer Name</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:TextBox ID="txtDealerName" runat="server" MaxLength="50"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Status</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><uc2:ctrlIsActive ID="ucIsActive" runat="server" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                                <td>
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="ui-button ui-state-default" OnClick="btnSearch_Click" Width="84px" />
                                    <asp:Button ID="btnAdd" runat="server" Text="Add Dealer" CssClass="ui-button ui-state-default" OnClick="btnAdd_Click" Width="84px" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="ui-widget-content">
                        <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="gvDealer" runat="server" AutoGenerateColumns="False" Style="width: 100%" Width="100%" OnRowCommand="gvDealer_RowCommand" AllowPaging="True" OnPageIndexChanging="gvDealer_PageIndexChanging" PageSize="50" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="No">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></EditItemTemplate>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %></ItemTemplate>
                                            <ItemStyle CssClass="T19" /></asp:TemplateField>
                                        <asp:BoundField DataField="KodeDealer" HeaderText="Dealer Code">
                                            <ItemStyle CssClass="T19" /></asp:BoundField>
                                        <asp:BoundField DataField="NamaDealer" HeaderText="Dealer Name">
                                            <ItemStyle CssClass="T19" /></asp:BoundField>
                                        <asp:TemplateField HeaderText="Status">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean((Eval("Status") == DBNull.Value?0:Eval("Status"))) %>' />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean((Eval("Status") == DBNull.Value?0:Eval("Status"))) %>' Enabled="false" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="T19" />
                                        </asp:TemplateField>    
                                        
                                        <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                                            <ControlStyle CssClass="ui-button ui-state-default" />
                                            <ItemStyle CssClass="T19" /></asp:CommandField>
                                    </Columns>
                                    <HeaderStyle CssClass="ui-widget-header" />
                                    <PagerStyle CssClass="ui-widget-header" />
                                    <AlternatingRowStyle BackColor="#E0E0E0" />
                                    <PagerSettings Mode="NumericFirstLast" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
