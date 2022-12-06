<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlDateTime.ascx.cs" Inherits="USoft.Controls.ctrlDateTime" %>
<script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#<%=txtDate.ClientID %>").datepicker();
	});
</script>
<asp:Label ID="Label1" runat="server" Text="Date"></asp:Label>
<asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
