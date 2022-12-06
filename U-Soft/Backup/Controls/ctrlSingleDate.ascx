<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlSingleDate.ascx.cs" Inherits="USoft.Controls.ctrlPeriod" %>
<script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#<%=txtDate.ClientID %>").datepicker();
	});
</script>
<asp:TextBox ID="txtDate" runat="server"></asp:TextBox>