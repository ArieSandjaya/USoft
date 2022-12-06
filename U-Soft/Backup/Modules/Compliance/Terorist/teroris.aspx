<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="teroris.aspx.cs" Inherits="USoft.Modules.Compliance.teroris" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc3" %>
<%@ Register Src="../../../Controls/ctrlPager.ascx" TagName="ctrlPager" TagPrefix="uc2" %>
<%@ Register Src="../../../Controls/ctrlValue.ascx" TagName="ctrlValue" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Terorist Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        </div>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc3:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                    <table style="width: 337px">
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label></td>
                            <td>
                                <uc1:ctrlValue id="CtrlValue1" runat="server"></uc1:ctrlValue></td>
                        </tr>
                        <tr>
                            <td class="T17" style="text-align: center">
                            </td>
                            <td style="text-align: center;" class="T19"><asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" CssClass="ui-button ui-state-default" Width="60px" />
                        <asp:Button ID="btnConvert" runat="server" Text="Print" CssClass="ui-button ui-state-default" OnClick="btnConvert_Click" Width="60px" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                        <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional" >
                            <ContentTemplate>
                                <asp:GridView ID="gvTeroris" runat="server" AutoGenerateColumns="False" Style="width: 100%" ShowFooter="True">
                                    <Columns>
                                        <asp:BoundField DataField="ROW" HeaderText="No" />
                                        <asp:BoundField DataField="name" HeaderText="Name" >
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BIRTHDAYS" HeaderText="Birthday">
                                            <ItemStyle Width="150px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Address" HeaderText="Address" >
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Nationality" HeaderText="Nationality" >
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Other_Info" HeaderText="Other Info" >
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Match">
                                            <EditItemTemplate>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <div style="width:100%" align="center">
                                                    <asp:CheckBox ID="chkMatch" runat="server" />
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="ui-widget-header" />
                                    <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" PageButtonCount="5" />
                                    <PagerStyle Wrap="False" VerticalAlign="Middle" ForeColor="Blue" />
                                    <FooterStyle CssClass="ui-widget-header" />
                                    <AlternatingRowStyle BackColor="WhiteSmoke" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    <uc2:ctrlPager ID="CtrlPager1" runat="server" OnNextClicked="NextPager" OnPrevClicked="PrevPager"/>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
