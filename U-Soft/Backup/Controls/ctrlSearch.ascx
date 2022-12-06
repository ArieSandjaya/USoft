<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlSearch.ascx.cs" Inherits="USoft.Controls.ctrlSearch" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<table style="width: 100%" cellspacing="1" cellpadding="0" border="0">
    <tr>
        <td colspan="3">
            <uc1:ctrlFormHeader ID="ucHeaderSearch" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="form_table_title" style="width: 120px;">Search By</td>
        <td class="form_table_sepp">:</td>
        <td class="form_table">
            <asp:DropDownList ID="ddlFieldSearch" runat="server"></asp:DropDownList>
            <asp:TextBox ID="txtFieldSearch" runat="server"></asp:TextBox>
        </td>
    </tr>
</table>