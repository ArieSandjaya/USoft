<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditDealer.aspx.cs" Inherits="USoft.Modules.Compliance.Master.EditDealer" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsActive" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Edit Dealer Page</title> 
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript">
        function ValidatePage(){
		    if($('#form1').validationEngine('validate')){
                if(confirm('Submit Data ?')) {
                    window.parent.parent.loadWait();
                    
                    return true;
                }
            }
            return false;
        }
        /*        
        $(document).ready(function() 
        {
            $('#btnSave').click(function(){window.parent.parent.loadWait();});
		});
		*/
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Dealer Code</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDealerCode1" runat="server" CssClass="validate[required]" MaxLength="5" Width="60px" Enabled="False"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Dealer Name <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDealerName1" runat="server" CssClass="validate[required]" MaxLength="50"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Status <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><uc2:ctrlIsActive ID="ucIsActive" runat="server" CssClass="validate[required]" /></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:Button ID="btnUpdate" runat="server" CssClass="ui-button ui-state-default" Text="Update" OnClick="btnUpdate_Click" OnClientClick="javascript:return ValidatePage();" />
                                <asp:Button ID="btnBack" runat="server" CssClass="ui-button ui-state-default" Text="Back" OnClick="btnBack_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
