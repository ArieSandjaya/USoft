<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleTaskAddEdit.aspx.cs" Inherits="USoft.Modules.IT.ScheduleTaskAddEdit" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Schedule Task Add Edit</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../Javascript/date.js"></script>
    <script type="text/javascript" src="../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript" src="../../Javascript/NumberFormat.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $(function() { $("#txtStartDate").datepicker({dateFormat: "yy-mm-dd"}); });
            $(function() { $("#txtEndDate").datepicker({dateFormat: "yy-mm-dd"}); });
        });
            
		function getDate(dateValue){
		    var DateValue=new Date(dateValue);
            var DateNw=new Date();
            var DateNow=DateNw.getFullYear()+"-"+(DateNw.getMonth()+1)+"-"+DateNw.getDate();
		    if(DateValue>DateNow){alert('oi');}
		}
		
		function ValidatePage(){
		    if($('#form1').validationEngine('validate')){
                if(confirm('Submit Data ?')) {
                    window.parent.parent.loadWait();
                    
                    return true;
                }
            }
            return false;
        }
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
            <tr><td><asp:Label ID="lblMessage" runat="server" CssClass="InfoWarn"></asp:Label></td></tr>
            <tr>
                <td class="ui-widget-content">
                    <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Schedule No</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblScheduleNo" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Type <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlType" runat="server" CssClass="validate[required]">
                                    <asp:ListItem Value="">- Select One -</asp:ListItem>
                                    <asp:ListItem Value="0">Permanent</asp:ListItem>
                                    <asp:ListItem Value="1">Temporer</asp:ListItem>
                                    <asp:ListItem Value="2">Reporting</asp:ListItem>
                                    <asp:ListItem Value="3">Monitoring</asp:ListItem>
                                    <asp:ListItem Value="4">Service</asp:ListItem>
                                    <asp:ListItem Value="5">Maintance User</asp:ListItem>
                                    <asp:ListItem Value="6">Backup Data</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Title <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtTitle" runat="server" CssClass="validate[required]"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Start Date <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtStartDate" runat="server" CssClass="validate[required] text-input datepicker" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">End Date</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtEndDate" runat="server" CssClass="text-input datepicker" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Interval By <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlIntervalBy" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlIntervalBy_SelectedIndexChanged">
                                            <asp:ListItem Value="0">Just Once</asp:ListItem>
                                            <asp:ListItem Value="1">Day</asp:ListItem>
                                            <asp:ListItem Value="2">Date</asp:ListItem>
                                        </asp:DropDownList>&nbsp;<asp:TextBox ID="txtIntervalRange" runat="server" CssClass="validate[required] text-input text-number" Width="50px"></asp:TextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlIntervalBy" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Time <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlHour" runat="server" CssClass="validate[required]"></asp:DropDownList>&nbsp;:&nbsp;<asp:DropDownList ID="ddlMinute" runat="server" CssClass="validate[required]"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Description</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDescription" runat="server" rows="5" TextMode="multiline"></asp:TextBox></td>
                        </tr>
                        <tr id="trStatus" runat="server">
                            <td class="form_table_title">Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="validate[required]">
                                    <asp:ListItem Value="">- Select One -</asp:ListItem>
                                    <asp:ListItem Value="1">Open</asp:ListItem>
                                    <asp:ListItem Value="2">Finish</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:ImageButton ID="imbSubmit" runat="server" ImageUrl="~/Images/BtnProcess.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbSubmit_Click" />
                                <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/Images/BtnCancel.png" OnClick="imbCancel_Click" />
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