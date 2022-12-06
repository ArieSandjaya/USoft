<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseRequestDetailAddEdit.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Purchase.PurchaseRequestDetailAddEdit" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Purchase Request Detail Add Edit</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/validationEngine.jquery.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../../Javascript/date.js"></script>
    <script type="text/javascript" src="../../../Javascript/NumberFormat.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript" src="../../../Javascript/general.js"></script>
    <script type="text/javascript">
        function CalculateTotal(){
            var txtQuantity = document.getElementById('txtQuantity');
            var txtPrice = document.getElementById('txtPrice');
            var txtTotal = document.getElementById('txtTotal');
            
            formatNumber(txtQuantity);
            formatNumber(txtPrice);
            
            txtTotal.value = parseFloat(txtQuantity.value.replace(/,/g , "")) * parseFloat(txtPrice.value.replace(/,/g , ""));
            
            if(isNaN(txtTotal.value)) {
                txtTotal.value = "";
            } else {
                formatNumber(txtTotal);
            }
        }
	</script>
</head>
<body onload="CalculateTotal();">
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
                                    <td class="form_table_title" style="width: 120px;">Request ID</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblRequestID" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Item Category</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:DropDownList ID="ddlItemCategory" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlItemCategory_SelectedIndexChanged"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Item Group</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:DropDownList ID="ddlItemGroup" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlItemGroup_SelectedIndexChanged"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Item Type</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:DropDownList ID="ddlItemType" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlItemType_SelectedIndexChanged"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Quantity</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="validate[required] text-input text-number"></asp:TextBox>&nbsp;<asp:Label ID="lblMeasurement" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Price</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:TextBox ID="txtPrice" runat="server" CssClass="validate[required] text-input text-number"></asp:TextBox>
                                        <asp:Label ID="lblCurrency" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Total</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:TextBox ID="txtTotal" runat="server" ReadOnly="true" CssClass="text-number"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td class="form_table_btn">
                                        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/Images/BtnAdd.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbAdd_Click" />
                                        <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Images/BtnUpdate.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbUpdate_Click" />
                                        <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>        
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlItemCategory" />
                <asp:AsyncPostBackTrigger ControlID="ddlItemGroup" />
                <asp:AsyncPostBackTrigger ControlID="ddlItemType" />
            </Triggers>
        </asp:UpdatePanel>
    </div>                      
    </form>
</body>
</html>