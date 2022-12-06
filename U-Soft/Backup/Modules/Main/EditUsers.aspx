<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditUsers.aspx.cs" Inherits="USoft.Modules.Main.EditUsers" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlBranch.ascx" TagName="ctrlBranch" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsActive" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlPriviledge.ascx" TagName="ctrlPriviledge" TagPrefix="uc3" %>
<%@ Register Src="~/Controls/ctrlUserId.ascx" TagName="ctrlUserId" TagPrefix="uc4" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Edit Users Page</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript">
        function privclick() {
            $get('Button1').click();
        }
        function userclick() {
            $get('Button2').click();
        }
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="label1" runat="server" Text="User ID"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtUserId1" runat="server" MaxLength="50" Enabled="False" Width="173px"></asp:TextBox></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="label2" runat="server" Text="Name"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtName1" runat="server" MaxLength="100" Enabled="False" Width="173px"></asp:TextBox></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="label3" runat="server" Text="Branch"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <uc1:ctrlBranch ID="CtrlBranch" runat="server" /></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="label4" runat="server" Text="Email"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtEmail1" runat="server" MaxLength="50" Width="173px"></asp:TextBox></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="label7" runat="server" Text="Can change password ?"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:CheckBox ID="chkCPass1" runat="server" /></td></tr>
            <tr>
                <td style="width: 135px; height: 16px;" class="T17" >
                    <asp:Label ID="label5" runat="server" Text="Can send mail ?"></asp:Label></td>
                <td style="width: 100px; height: 16px;" class="T19" >
                    <asp:CheckBox ID="chkSendMail1" runat="server" /></td></tr>
            <tr>
                <td class="T17" style="width: 135px">
                    <asp:Label ID="Label8" runat="server" Text="Status"></asp:Label></td>
                <td class="T19" style="width: 100px">
                    <uc2:ctrlIsActive ID="CtrlIsActive" runat="server" /></td></tr>
            <tr>
                <td class="T17" style="width: 135px">
                    <asp:Label ID="Label6" runat="server" Text="to edit menu"></asp:Label></td>
                <td class="T19" style="width: 100px">
                    <asp:Button ID="btnEditMenu" runat="server" CssClass="ui-state-default" Text="Edit Menu" OnClick="btnEditMenu_Click" ForeColor="White" /></td></tr>
            <tr>
                <td style="width: 135px" class="T17">&nbsp;</td>
                <td style="width: 100px" class="T19">
                    <asp:Button ID="btnUpdate" runat="server" CssClass="ui-button ui-state-default" Text="Update" OnClick="btnUpdate_Click" /></td></tr>
        </table>
        
        <asp:button id="Button1" runat="server" text="Button" CssClass="hide" OnClick="Button1_Click" />
        <cc1:ModalPopupExtender ID="mpePR" runat="server" CancelControlID="imgBtnCancel" 
                TargetControlID="Button1" PopupControlID="panel17">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="panel17" runat="server" Enabled="true" BackColor="Gainsboro" Style="border-right: black thin solid;
            padding-right: 0px; border-top: black thin solid; display: none; padding-left: 0px;
            padding-bottom: 0px; margin: 0px; border-left: black thin solid; padding-top: 0px;
            border-bottom: black thin solid" Width="100%" Height="30%">
            <div>
                <table>
                    <tr>
                        <td class="T19" style="width: 135px; height: 16px;">
                            <asp:ImageButton ID="imgBtnCancel" runat="server" ImageAlign="Left" ImageUrl="~/CSS/black-tie/images/Unchecked.gif" OnClick="imgBtnCancel_Click" /></td>
                        <td class="T19" style="width: 100px; height: 16px;"></td></tr>
                    <tr>
                        <td style="width: 135px" class="T19">
                            <asp:Label ID="lblPriviledge" runat="server" Text="Select Priviledge"></asp:Label></td>
                        <td style="width: 100px" class="T19">
                            <uc3:ctrlPriviledge ID="CtrlPriviledge" runat="server" /></td></tr>
                    <tr>
                        <td class="T19" style="width: 135px"></td>
                        <td class="T19" style="width: 100px">
                            <asp:Button ID="btnOK" runat="server" CssClass="ui-button ui-state-default" Text="OK" OnClick="btnOK_Click" /></td></tr>
                </table>
            </div>
        </asp:Panel>
        
        <asp:button id="Button2" runat="server" text="Button2" CssClass="hide" OnClick="Button2_Click" />
        <cc1:ModalPopupExtender ID="mpeUSR" runat="server" CancelControlID="imgBtnCancel2" 
                TargetControlID="Button2" PopupControlID="panel99">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="panel99" runat="server" Enabled="true" BackColor="Gainsboro" Style="border-right: black thin solid;
            padding-right: 0px; border-top: black thin solid; display: none; padding-left: 0px;
            padding-bottom: 0px; margin: 0px; border-left: black thin solid; padding-top: 0px;
            border-bottom: black thin solid" Width="100%" Height="30%">
            <div>
                <table>
                    <tr>
                        <td class="T19" style="width: 135px; height: 16px;">
                            <asp:ImageButton ID="imgBtnCancel2" runat="server" ImageAlign="Left" ImageUrl="~/CSS/black-tie/images/Unchecked.gif" OnClick="imgBtnCancel2_Click" /></td>
                        <td class="T19" style="width: 100px; height: 16px;"></td></tr>
                    <tr>
                        <td style="width: 135px" class="T19">
                            <asp:Label ID="Label9" runat="server" Text="Select User"></asp:Label></td>
                        <td style="width: 100px" class="T19">
                            <uc4:ctrlUserId ID="CtrlUserId" runat="server" /></td></tr>
                    <tr>
                        <td class="T19" style="width: 135px"></td>
                        <td class="T19" style="width: 100px">
                            <asp:Button ID="btnOK2" runat="server" CssClass="ui-button ui-state-default" Text="OK" OnClick="btnOK2_Click" /></td></tr>
                </table>
            </div>
        </asp:Panel>
    </div>
        <asp:UpdatePanel ID="updGrid" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table id="tblMenu" runat="server" class="hide" width="100%">
                    <tr>
                        <td colspan="2">
                            <asp:ImageButton ID="imgBtnClose" runat="server" ImageUrl="~/CSS/black-tie/images/Unchecked.gif" ImageAlign="Left" OnClick="imgBtnClose_Click" /></td></tr>
                    <tr>
                        <td colspan="2"></td></tr>
                    <tr>
                        <td colspan="2" class="T19" align="right" valign="bottom">
                            set menu ---&gt;<asp:Button ID="btnPriv" runat="server" CssClass="ui-button ui-state-default" Text="by Privilege" OnClientClick="privclick()" />
                            or<asp:Button ID="btnUserId" runat="server" CssClass="ui-button ui-state-default" Text="by User" OnClientClick="userclick()" />
                            </td></tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;<asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" HorizontalAlign="Left" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="MenuId" HeaderText="Menu ID"><ItemStyle CssClass="hide" /><ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="MenuName" HeaderText="Menu Name"><ItemStyle CssClass="T19" Width="50%" /><ControlStyle CssClass="50%" /><FooterStyle CssClass="50%" /><HeaderStyle Width="50%" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="MenuParent" HeaderText="Menu Parent"><ItemStyle CssClass="hide" /><ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" />
                                        </asp:BoundField>
                                    <asp:TemplateField HeaderText="Insert">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean(Eval("InsertDt")) %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkInsert" runat="server" Checked='<%# Convert.ToBoolean(Eval("InsertDt")) %>' />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="T19" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Update">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Convert.ToBoolean(Eval("UpdateDt")) %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkUpdate" runat="server" Checked='<%# Convert.ToBoolean(Eval("UpdateDt")) %>' />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="T19" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Convert.ToBoolean(Eval("DeleteDt")) %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkDelete" runat="server" Checked='<%# Convert.ToBoolean(Eval("DeleteDt")) %>' />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="T19" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Convert.ToBoolean(Eval("ViewDt")) %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkView" runat="server" Checked='<%# Convert.ToBoolean(Eval("ViewDt")) %>' />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="T19" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                            </asp:GridView>
                            &nbsp;
                        </td></tr>
                    <tr class="T17">
                        <td style="width: 100px">
                            <asp:Button ID="btnSaveMenu" runat="server" CssClass="ui-button ui-state-default" OnClick="btnSaveMenu_Click" Text="Save" /></td>
                        <td style="width: 100px"></td></tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
