<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddDepartment.aspx.cs" Inherits="USoft.Modules.Compliance.Master.AddDepartment" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New Department Page</title>    
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
                    <uc1:ctrlformheader id="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                        <tr>
                            <td class="form_table_title" style="width: 160px;">Departement Code <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDeptCode" runat="server" CssClass="validate[required]" MaxLength="5" Width="128px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Departement Name <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDeptName" runat="server" CssClass="validate[required]" MaxLength="50" Width="276px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:Button ID="btnSave" runat="server" CssClass="ui-button ui-state-default" Text="Save" Width="80px" OnClick="btnSave_Click" OnClientClick="javascript:return ValidatePage();" />&nbsp;
                                <asp:Button ID="btnBack" runat="server" CssClass="ui-button ui-state-default" Text="Back" Width="80px" OnClick="btnBack_Click" />
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
