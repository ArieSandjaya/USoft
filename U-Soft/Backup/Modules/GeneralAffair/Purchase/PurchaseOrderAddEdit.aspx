<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseOrderAddEdit.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Purchase.PurchaseOrderAddEdit" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Purchase Order Add Edit</title>
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
        $(document).ready(function(){
            $(function() {
                $("#txtOrderDate").datepicker({dateFormat: "yy-mm-dd"});
                $("#txtDeliveryDate").datepicker({dateFormat: "yy-mm-dd"});
                $("#txtOfferDate").datepicker({dateFormat: "yy-mm-dd"});
            });
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
                            <td class="form_table_title" style="width: 120px;">Order ID</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:Label id="lblOrderID" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Order Date <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtOrderDate" runat="server" CssClass="validate[required] text-input datepicker" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Supplier <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlSupplier" runat="server" CssClass="validate[required]"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Currency <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="validate[required]"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title">PIC</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtPIC" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Delivery Date</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDeliveryDate" runat="server" CssClass="text-input datepicker" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Offer From</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtOfferFrom" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Offer No</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtOfferNo" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Offer Date</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtOfferDate" runat="server" CssClass="text-input datepicker" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Description</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDescription" runat="server" rows="5" TextMode="multiline"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:ImageButton ID="imbSubmit" runat="server" ImageUrl="~/Images/BtnProcess.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbSubmit_Click" />
                                <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
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