<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlDatetimeRange.ascx.cs" Inherits="USoft.Controls.ctrlDatetimeRange" %>
<script type="text/javascript">
	$(function() {
		$("#<%=txtDateFrom.ClientID %>").datepicker();
	});
	$(function() {
		$("#<%=txtDateTo.ClientID %>").datepicker();
	});
</script>
<table style="width: 625px">
    <tr>
        <td style="width: 95px">Date From</td>
        <td style="width: 164px">
            <asp:TextBox ID="txtDateFrom" runat="server"></asp:TextBox></td>
        <td style="width: 57px">Date To</td>
        <td style="width: 222px">
            <asp:TextBox ID="txtDateTo" runat="server"></asp:TextBox></td>
    </tr>
</table>
