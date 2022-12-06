<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlPager.ascx.cs" Inherits="USoft.Controls.ctrlPager" %>
<table style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; text-align: left">
    <tr>
        <td class="T19">
    <asp:Button ID="btnPrev" runat="server" CssClass="ui-button ui-state-default" Text="Prev" OnClick="btnPrev_Click" Visible="False" /></td>
        <td class="T19">
    <asp:Button ID="btnNext" runat="server" CssClass="ui-button ui-state-default" Text="Next" OnClick="btnNext_Click" Visible="False" /></td>
        <td class="T19">
<asp:Label ID="lblMaxRow" runat="server" Text="0" style="display: none"></asp:Label></td>
        <td class="T19">
<asp:Label ID="lblCurrent" runat="server" Text="0" style="display: none"></asp:Label></td>
    </tr>
</table>
&nbsp;
