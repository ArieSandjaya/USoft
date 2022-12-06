<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActivityTaskAddEdit.aspx.cs" Inherits="USoft.Modules.IT.ActivityTaskAddEdit" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Activity Task Add Edit</title>
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
    <script type="text/javascript" src="../../Javascript/general.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $(function() { $("#txtActivityDate").datepicker({dateFormat: "yy-mm-dd"}); });
        });
            
		function getDate(dateValue){
		    var DateValue=new Date(dateValue);
            var DateNw=new Date();
            var DateNow=DateNw.getFullYear()+"-"+(DateNw.getMonth()+1)+"-"+DateNw.getDate();
		    if(DateValue>DateNow){alert('oi');}
		}
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="pnlDataForm" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
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
                                    <td class="form_table_title" style="width: 120px;">Activity No</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblActivityNo" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Date <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:TextBox ID="txtActivityDate" runat="server" CssClass="validate[required] text-input datepicker" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Request By <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:TextBox ID="txtRequestBy" runat="server" CssClass="validate[required]"></asp:TextBox></td>
                                </tr>
                                <%--<tr>
                                    <td class="form_table_title">Email <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:TextBox ID="txtEmail" runat="server" CssClass="validate[required]"></asp:TextBox>@ufindo.com</td>
                                </tr>--%>
                                <tr>
                                    <td class="form_table_title">Branch <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:DropDownList ID="ddlBranch" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr id="trDepartment" runat="server">
                                    <td class="form_table_title">Departement <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:DropDownList ID="ddlDepartement" runat="server" CssClass="validate[required]"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Problem Type <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:DropDownList ID="ddlProblemType" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlProblemType_SelectedIndexChanged"></asp:DropDownList>
                                    </td>
                                </tr>                        
                                <tr id="trItemType" runat="server">
                                    <td class="form_table_title">Item Type <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:DropDownList ID="ddlItemType" runat="server" CssClass="validate[required]"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Description <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:TextBox ID="txtDescription" runat="server" rows="5" TextMode="multiline" CssClass="validate[required]"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Priority <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:DropDownList ID="ddlPriority" runat="server" CssClass="validate[required]">
                                            <asp:ListItem Value="">- Select One -</asp:ListItem>
                                            <asp:ListItem Value="0">Low</asp:ListItem>
                                            <asp:ListItem Value="1">Medium</asp:ListItem>
                                            <asp:ListItem Value="2">High</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td class="form_table_btn">
                                        <asp:ImageButton ID="imbSubmit" runat="server" ImageUrl="~/Images/BtnProcess.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbSubmit_Click" />
                                        <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlBranch" />
                <asp:AsyncPostBackTrigger ControlID="ddlProblemType" />
            </Triggers>
        </asp:UpdatePanel>      
    </div>                      
    </form>
</body>
</html>