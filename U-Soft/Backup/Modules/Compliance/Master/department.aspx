<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="department.aspx.cs" Inherits="USoft.Modules.Compliance.Master.department" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Department Page</title>
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
                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvDept" runat="server" AutoGenerateColumns="False" Style="width: 100%" Width="100%" OnRowCommand="gvPriv_RowCommand" >
                                <Columns>
                                    <asp:TemplateField HeaderText="No">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %></ItemTemplate>
                                        <ItemStyle CssClass="T19" /></asp:TemplateField>
                                    <asp:BoundField DataField="DeptCode" HeaderText="Dept. Code">
                                        <ItemStyle CssClass="T19" /></asp:BoundField>
                                    <asp:BoundField DataField="DeptName" HeaderText="Dept. Name">
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
                                        <ItemStyle CssClass="T19" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnAdd" runat="server" Text="Add Dept." CssClass="ui-button ui-state-default" OnClick="btnAdd_Click" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

