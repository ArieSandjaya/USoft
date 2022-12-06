<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="USoft.Modules.Main.Users" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../../Controls/ctrlBranch.ascx" TagName="ctrlBranch" TagPrefix="uc1" %>
<%@ Register Src="../../Controls/ctrlPriviledge.ascx" TagName="ctrlPriviledge" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlUserId.ascx" TagName="ctrlUserId" TagPrefix="uc3" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Users Page</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript">
        function cekPassword()
            {
                var UPass;var UType;var tRow;
                UPass = document.getElementById("txtPassword");
                UType = document.getElementById("txtReTypePassword");
                tRow = document.getElementById("trSave");
                if (UPass.value == UType.value)
                {
                    tRow.className = "show";
                }
                else
                {
                    tRow.className = "hide";
                }
            }
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
                    <asp:Label ID="lblUserId" runat="server" Text="User ID"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtUserId" runat="server" MaxLength="50" Width="173px"></asp:TextBox></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="lblUserName" runat="server" Text="Name"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtName" runat="server" MaxLength="100" Width="173px"></asp:TextBox></td></tr>
            <tr>
                <td class="T17" style="width: 135px">
                    <asp:Label ID="lblBranch" runat="server" Text="Branch"></asp:Label></td>
                <td class="T19" style="width: 100px">
                    <uc1:ctrlBranch ID="CtrlBranch" runat="server" /></td></tr>
            <tr>
                <td class="T17" style="width: 135px">
                    <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label></td>
                <td class="T19" style="width: 100px">
                    <asp:TextBox ID="txtEmail" runat="server" MaxLength="50" Width="173px"></asp:TextBox></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="173px" onkeyup="cekPassword();"></asp:TextBox></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="lblReTypePassword" runat="server" Text="ReType Password" Width="119px"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtReTypePassword" runat="server" TextMode="Password" Width="173px" onkeyup="cekPassword();"></asp:TextBox></td></tr>
            <tr>
                <td class="T17" style="width: 135px">
                    <asp:Label ID="Label1" runat="server" Text="Can change password ?"></asp:Label></td>
                <td class="T19" style="width: 100px">
                    <asp:CheckBox ID="chkCPass" runat="server" /></td></tr>
            <tr>
                <td class="T17" style="width: 135px">
                    <asp:Label ID="Label2" runat="server" Text="Can send mail ?"></asp:Label></td>
                <td class="T19" style="width: 100px">
                    <asp:CheckBox ID="chkSendMail" runat="server" /></td></tr>
            
            <tr id="trSave" class= "hide">
                <td class="T17" style="width: 135px"></td>
                <td style="width: 100px" class="T19">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Button ID="btnSave" runat="server" CssClass="ui-button ui-state-default" OnClick="btnSave_Click"
                                Text="Save" />
                        </ContentTemplate>
                    </asp:UpdatePanel></td></tr>
        </table>
        
        <asp:button id="Button1" runat="server" text="Button" OnClick="Button1_Click" CssClass="hide" />
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
                            <uc2:ctrlPriviledge ID="CtrlPriviledge" runat="server" /></td></tr>
                    <tr>
                        <td class="T19" style="width: 135px"></td>
                        <td class="T19" style="width: 100px">
                            <asp:Button ID="btnOK" runat="server" CssClass="ui-button ui-state-default" Text="OK" OnClick="btnOK_Click" /></td></tr>
                </table>
            </div>
        </asp:Panel>
        
        <asp:button id="Button2" runat="server" text="Button2" OnClick="Button2_Click" CssClass="hide" />
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
                            <asp:Label ID="Label3" runat="server" Text="Select User"></asp:Label></td>
                        <td style="width: 100px" class="T19">
                            <uc3:ctrlUserId ID="CtrlUserId" runat="server" /></td></tr>
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
                <table class="hide" id="tblMenu" width="100%" runat="server">
                    <tr>
                        <td align="right" style="width: 100px"></td>
                        <td></td></tr>
                    <tr>
                        <td align="right" class="T19" colspan="2">
                            set menu ---&gt;<asp:Button ID="btnPriv" runat="server" CssClass="ui-button ui-state-default" Text="by Privilege" OnClientClick="privclick()" />
                            or&nbsp;<asp:Button ID="btnUserId" runat="server" CssClass="ui-button ui-state-default" Text="by User" OnClientClick="userclick()" /></td>
                        </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;<asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" HorizontalAlign="Left" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="MenuId" HeaderText="Menu ID" >
                                        <ItemStyle CssClass="hide" /><ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /></asp:BoundField>
                                    <asp:BoundField DataField="MenuName" HeaderText="Menu Name" >
                                        <ItemStyle CssClass="T19" Width="50%" /><ControlStyle CssClass="50%" /><FooterStyle CssClass="50%" /><HeaderStyle Width="50%" /></asp:BoundField>
                                    <asp:BoundField DataField="MenuParent" HeaderText="Menu Parent" >
                                        <ItemStyle CssClass="hide" /><ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /></asp:BoundField>
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
                                            <asp:CheckBox ID="chkUpdate" runat="server" Checked='<%# Convert.ToBoolean(Eval("UpdateDt")) %>'/>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="T19" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Convert.ToBoolean(Eval("DeleteDt")) %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkDelete" runat="server" Checked='<%# Convert.ToBoolean(Eval("DeleteDt")) %>'/>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="T19" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Convert.ToBoolean(Eval("ViewDt")) %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkView" runat="server" Checked='<%# Convert.ToBoolean(Eval("ViewDt")) %>'/>
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
                            <asp:Button ID="btnSaveMenu" runat="server" CssClass="ui-button ui-state-default"
                                Text="Save" OnClick="btnSaveMenu_Click" /></td>
                        <td style="width: 100px"></td></tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
