<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PriviledgeSearch.aspx.cs" Inherits="USoft.Modules.Main.PriviledgeSearch" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlPriviledge.ascx" TagName="ctrlPriviledge" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Search Privilege</title>
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
                    <uc1:ctrlFormHeader ID="CtrlFormHeader" runat="server" /></td></tr>
            <tr class="T19">
                <td>
                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvPriv" runat="server" AutoGenerateColumns="False" Style="width: 100%" Width="100%" OnRowCommand="gvPriv_RowCommand" >
                                <Columns>
                                    <asp:TemplateField HeaderText="No">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %></ItemTemplate>
                                        <ItemStyle CssClass="T19" /></asp:TemplateField>
                                    <asp:BoundField DataField="PriveledgeCode" HeaderText="Priveledge Code">
                                        <ItemStyle CssClass="T19" /></asp:BoundField>
                                    <asp:BoundField DataField="PriveledgeName" HeaderText="Priveledge Name">
                                        <ItemStyle CssClass="T19" /></asp:BoundField>
                                    <asp:TemplateField HeaderText="Status">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean((Eval("Active") == DBNull.Value?0:Eval("Active"))) %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean((Eval("Active") == DBNull.Value?0:Eval("Active"))) %>' Enabled="false" />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="T19" />
                                    </asp:TemplateField>    
                                    
                                    <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                                        <ControlStyle CssClass="ui-button ui-state-default" />
                                        <ItemStyle CssClass="T19" /></asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td></tr>
         </table>   
    </div>
    </form>
</body>
</html>
