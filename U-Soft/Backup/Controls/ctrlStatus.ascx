<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlStatus.ascx.cs" Inherits="USoft.Controls.ctrlStatus" %>
<asp:DropDownList ID="ddlStatus" runat="server" Width="84px" style="font-size: 10px; font-family: Verdana, Arial, Helvetica, sans-serif">
    <asp:ListItem Value="">All</asp:ListItem>
    <asp:ListItem Value="D">Draft</asp:ListItem>
    <asp:ListItem Value="R">Request For Approval</asp:ListItem>
    <asp:ListItem Value="A">Approve</asp:ListItem>
    <asp:ListItem Value="X">Reject</asp:ListItem>
</asp:DropDownList>