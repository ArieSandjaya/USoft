<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Priviledge.aspx.cs" Inherits="USoft.Modules.Main.Priviledge" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Priviledge Page</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript">
        function cekField()
            {
                var pCode;var pName;var tRow;
                pCode = document.getElementById("txtPrivCode");
                pName = document.getElementById("txtPrivName");
                tRow = document.getElementById("trSH");
                if ((pCode.value && pName.value) == "")
                {
                    tRow.className = "hide";
                }
                else
                {
                    tRow.className = "show";
                }
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
                    <asp:Label ID="lblPrivCode" runat="server" Text="Priviledge Code"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtPrivCode" runat="server" onkeyup="cekField();" MaxLength="5" Width="60px"></asp:TextBox></td></tr>
            <tr>
                <td style="width: 135px" class="T17">
                    <asp:Label ID="lblPrivName" runat="server" Text="Priviledge Name"></asp:Label></td>
                <td style="width: 100px" class="T19">
                    <asp:TextBox ID="txtPrivName" runat="server" onkeyup="cekField();" MaxLength="50"></asp:TextBox></td></tr>
            <tr id="trSH" class="hide">
                <td class="T17" style="width: 135px"></td>
                <td style="width: 100px" class="T19">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Button ID="btnSave" runat="server" CssClass="ui-button ui-state-default" OnClick="btnSave_Click" Text="Save" />
                        </ContentTemplate>
                    </asp:UpdatePanel></td></tr>
        </table>
    </div>
    
        <asp:UpdatePanel ID="updGrid" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            <table class="hide" id="tblMenu" width="100%" runat="server">
                <tr>
                    <td style="width: 100px"></td>
                    <td style="width: 100px"></td></tr>
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
