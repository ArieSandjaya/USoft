<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchUserMenu.aspx.cs" Inherits="USoft.Modules.Main.SearchUserMenu" %>

<%@ Register Src="~/Controls/ctlPageHeader.ascx" TagName="ctlPageHeader" TagPrefix="uc3" %>
<%@ Register Src="~/Controls/ctrlPager.ascx" TagName="ctrlPager" TagPrefix="uc4" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsActive" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Search UserMenu</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <table style="width: 100%">
                        <tr>
                            <td class="ui-widget-content">
                                <uc1:ctrlFormHeader ID="CtrlFormHeader" runat="server" /></td></tr>
                        <tr>
                            <td class="T17">
                                <asp:Label ID="Label1" runat="server" Text="User Id"></asp:Label></td>
                            <td class="T19">
                                <asp:TextBox ID="txtUserID" runat="server"></asp:TextBox></td></tr>
                        <tr>
                            <td  class="T17">
                                <asp:Label ID="Label2" runat="server" Text="User Name" Width="67px"></asp:Label></td>
                            <td class="T19">
                                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox></td></tr>
                        <tr>
                            <td class="T17">
                                <asp:Label ID="Label3" runat="server" Text="Status"></asp:Label></td>
                            <td class="T19">
                                <uc2:ctrlIsActive id="CtrlIsActive" runat="server"></uc2:ctrlIsActive></td></tr>
                        <tr>
                            <td class="T17"></td>
                            <td class="T19">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="ui-button ui-state-default" OnClick="btnSearch_Click" /></td></tr>
                    </table>
                </td>
            </tr>
            <tr class="T19">
                <td>
                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvUser" runat="server" AutoGenerateColumns="False" Style="width: 100%" Width="100%" OnRowCommand="gvUser_RowCommand" >
                                <Columns>
                                    <asp:TemplateField HeaderText="No">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %> </ItemTemplate>
                                        <ItemStyle CssClass="T19" />
                                        </asp:TemplateField>
                                    <asp:BoundField DataField="UserId" HeaderText="User ID">
                                        <ItemStyle CssClass="T19" /></asp:BoundField>
                                    <asp:BoundField DataField="UserName" HeaderText="User Name">
                                        <ItemStyle CssClass="T19" /></asp:BoundField>
                                    <asp:BoundField DataField="BranchName" HeaderText="Branch">
                                        <ItemStyle CssClass="T19" /></asp:BoundField>
                                    <asp:TemplateField HeaderText="Status">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean((Eval("Active") == DBNull.Value?0:Eval("Active"))) %>' /></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean((Eval("Active") == DBNull.Value?0:Eval("Active"))) %>' Enabled="false" /></ItemTemplate>
                                        <ItemStyle CssClass="T19" />
                                        </asp:TemplateField>
                                    <asp:BoundField DataField="PriviledgeCode" HeaderText="PrivCode">
                                        <HeaderStyle CssClass="hide" /><ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                                        <ControlStyle CssClass="ui-button ui-state-default" />
                                        <ItemStyle CssClass="T19" />
                                        </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <uc4:ctrlPager ID="CtrlPager1" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
