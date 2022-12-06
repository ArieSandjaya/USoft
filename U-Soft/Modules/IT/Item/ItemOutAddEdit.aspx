<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemOutAddEdit.aspx.cs" Inherits="USoft.Modules.IT.Item.ItemOutAddEdit" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item-Out Add Edit</title>
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
    <script type="text/javascript" src="../../../Javascript/date.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript" src="../../../Javascript/general.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(function() {
                $("#txtOutDate").datepicker({dateFormat: "yy-mm-dd"});
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                function EndRequestHandler(sender, args) {
                    $("#txtOutDate").datepicker({dateFormat: "yy-mm-dd"});
                }
            });
        });
            
		function getDate(dateValue){
            var DateValue=new Date(dateValue);
            var DateNw=new Date();
            var DateNow=DateNw.getFullYear()+"/"+(DateNw.getMonth()+1)+"/"+DateNw.getDate();
		    if(DateValue<DateNow){alert('oi');}
		}
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="pnlDataPage" runat="server" UpdateMode="Conditional">
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
                            <tr id="trDocStatus" runat="server">
                                <td class="form_table_title" style="width: 160px;">Document Status</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:Label id="lblDocStatus" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="form_table_title" style="width: 160px;">Code</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table"><asp:Label id="lblItemOutCode" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Out Date <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblOutDate" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtOutDate" runat="server" CssClass="validate[required] text-input datepicker" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Branch From <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblBranchName" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddlBranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="getITItem"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Type <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblItemType" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddlItemType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="getITItem"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Item <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblItemCode" runat="server"></asp:Label>
                                    <asp:UpdatePanel ID="pnlItemCode" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlItemCode" runat="server" CssClass="validate[required]"></asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlBranch" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlItemType" />
                                        </Triggers>
                                   </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Condition <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblCondition" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddlCondition" runat="server" CssClass="validate[required]"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Status Out <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblStatusOut" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddlStatusOut" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusOut_SelectedIndexChanged">
                                        <asp:ListItem Value="">- Select One -</asp:ListItem>
                                        <asp:ListItem Value="1">Repair</asp:ListItem>
                                        <asp:ListItem Value="2">Dispose</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr id="trVendor" runat="server">
                                <td class="form_table_title">Vendor Name <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblSupplier" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddlSupplier" runat="server" CssClass="validate[required]"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td class="form_table_title">PIC <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblPICName" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddlPIC" runat="server" CssClass="validate[required]"></asp:DropDownList></td>
                            </tr>
                            <tr id="trRepairStatus" runat="server">
                                <td class="form_table_title">Repair Status</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblRepairStatus" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="trRemark" runat="server">
                                <td class="form_table_title">Remark</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:Label id="lblRemark" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                                <td class="form_table_btn">
                                    <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/Images/BtnAdd.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbAdd_Click"  />
                                    <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Images/BtnUpdate.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbUpdate_Click" />
                                    <asp:ImageButton ID="imbApprove" runat="server" ImageUrl="~/Images/BtnApprove.png" OnClick="imbApprove_Click" />
                                    <asp:ImageButton ID="imbReject" runat="server" ImageUrl="~/Images/BtnReject.png" OnClick="imbReject_Click" />
                                    <asp:ImageButton ID="imbRFA" runat="server" ImageUrl="~/Images/BtnRFA.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbRFA_Click" />
                                    <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="imbAdd" />
                <asp:AsyncPostBackTrigger ControlID="imbUpdate" />
                <asp:AsyncPostBackTrigger ControlID="imbApprove" />
                <asp:AsyncPostBackTrigger ControlID="imbReject" />
                <asp:AsyncPostBackTrigger ControlID="imbRFA" />
            </Triggers>
       </asp:UpdatePanel>
    </div>                      
    </form>
</body>
</html>
