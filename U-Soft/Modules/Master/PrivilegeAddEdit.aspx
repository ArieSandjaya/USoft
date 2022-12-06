<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrivilegeAddEdit.aspx.cs" Inherits="USoft.Modules.Master.PrivilegeAddEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsActive" TagPrefix="uc2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Departement Add Edit</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript" src="../../Javascript/general.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
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
                                <td class="form_table_title" style="width: 120px;">Privilege Code <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:TextBox ID="txtPrivilegeCode" runat="server" CssClass="validate[required]" Width="65" MaxLength="5"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Privilege Name <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:TextBox ID="txtPrivilegeName" runat="server" CssClass="validate[required]" Width="200"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Departement <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:DropDownList ID="ddlDepartement" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Old Code</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:TextBox ID="txtOldCode" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Active State <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <uc2:ctrlIsActive ID="ucIsActive" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 27px">&nbsp;</td>
                                <td class="form_table_btn" style="height: 27px">
                                    <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/Images/BtnAdd.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbAdd_Click" />
                                    <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Images/BtnUpdate.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbUpdate_Click" />
                                    <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPrivilegeMenu" runat="server">
                    <td class="ui-widget-content">
                        <uc1:ctrlFormHeader ID="ucHeaderMenu" runat="server" />
                        <asp:GridView ID="gvPrivilegeMenu" runat="server" AutoGenerateColumns="False"
                             Font-Size="8pt" ShowFooter="False" Style="width: 100%" EmptyDataText="No Data Available" OnRowDataBound="gvPrivilegeMenu_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="MenuId" HeaderText="Menu ID">
                                    <ItemStyle CssClass="hide" />
                                    <ControlStyle CssClass="hide" />
                                    <FooterStyle CssClass="hide" />
                                    <HeaderStyle CssClass="hide" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MenuParent" HeaderText="Menu Parent">
                                    <ItemStyle CssClass="hide" />
                                    <ControlStyle CssClass="hide" />
                                    <FooterStyle CssClass="hide" />
                                    <HeaderStyle CssClass="hide" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MenuLink" HeaderText="Menu Link">
                                    <ItemStyle CssClass="hide" />
                                    <ControlStyle CssClass="hide" />
                                    <FooterStyle CssClass="hide" />
                                    <HeaderStyle CssClass="hide" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MenuName" HeaderText="Menu Name" />
                                <asp:TemplateField HeaderText="Insert">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkInsertAll" OnClick="ToggleCheckByClass(this.checked,'chkInsert');" runat="server" />&nbsp;<asp:Label ID="lblInsert" runat="server" Text="Insert"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkInsert" CssClass="chkInsert" runat="server" Checked='<%# Convert.ToBoolean(Eval("InsertDt")) %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="75px" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkUpdateAll" OnClick="ToggleCheckByClass(this.checked,'chkUpdate');" runat="server" />&nbsp;<asp:Label ID="lblUpdate" runat="server" Text="Update"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkUpdate" CssClass="chkUpdate" runat="server" Checked='<%# Convert.ToBoolean(Eval("UpdateDt")) %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="75px" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkDeleteAll" OnClick="ToggleCheckByClass(this.checked,'chkDelete');" runat="server" />&nbsp;<asp:Label ID="lblDelete" runat="server" Text="Delete"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkDelete" CssClass="chkDelete" runat="server" Checked='<%# Convert.ToBoolean(Eval("DeleteDt")) %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="75px" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkViewAll" OnClick="ToggleCheckByClass(this.checked,'chkView');" runat="server" />&nbsp;<asp:Label ID="lblView" runat="server" Text="View"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkView" CssClass="chkView" runat="server" Checked='<%# Convert.ToBoolean(Eval("ViewDt")) %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="75px" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="ui-widget-header" />
                            <AlternatingRowStyle BackColor="Gainsboro" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>                      
    </form>
</body>
</html>