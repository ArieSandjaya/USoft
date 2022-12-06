<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashRewardPaid.aspx.cs" Inherits="USoft.Modules.Marketing.CashReward.CashRewardPaid" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlPager.ascx" TagName="ctrlPager" TagPrefix="uc2" %>
<%@ Import Namespace="System.Web.Services" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cash Reward Paid in same Period</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript">
        function UpdateAmount(period,contractId,SupplierType,RefundRecId,SupplierCode,BrandCode,RecipientName,Value,Tax)
        {
            var Amount = Value.value;
            var sValue = (Value.name).split("$");
            var sTax=document.getElementById(sValue[0]+"_"+sValue[1]+"_lblTax");
            var sNet=document.getElementById(sValue[0]+"_"+sValue[1]+"_lblNet");
            $.ajax({
                 type: "POST",
                 url: "UpdateCachReward.asmx/UpdateAmount",
                 data: "{'Period':'"+period+"', 'Contract':'"+contractId+"', 'SupplierType':'"+SupplierType+"', 'RefundRecipient':'"+RefundRecId+"', 'SupplierCd':'"+SupplierCode+"', 'BrandCd':'"+BrandCode+"', 'RecipientName':'"+RecipientName+"', 'Amount':'"+Amount+"'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json"                 
             });
             sTax.innerText = isNaN(parseFloat(Amount.replace(/,/gi,"")) * (Tax/100))?0:Amount.replace(/,/gi,"") * (Tax/100);
        }
        
        $(document).ready(function()
        {  
            $(function(){ $('.txtAmountRewardPaid').blur(function(){ $(this).formatCurrency( { colorize:true,negativeFormat:'-%s%n',roundToDecimalPlace:0 }); }).keyup(function(e){ var e=window.event||e;var keyUnicode=e.charCode||e.keyCode; if(e!==undefined){ switch(keyUnicode){ case 16:break;case 17:break;case 18:break;case 27:this.value='';break;case 35:break;case 36:break;case 37:break;case 38:break;case 39:break;case 40:break;case 78:break;case 110:break;case 190:break; default:$(this).formatCurrency({colorize:true,negativeFormat:'-%s%n',roundToDecimalPlace:0,eventOnDecimalsEntered:true}); } } }); }); 
        });
        function loadWait()
        {
            //window.parent.parent.loadWait();
            $.blockUI({message: '<img src="../../../CSS/black-tie/images/loading6.gif" />'});
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        </div>
        
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" /></td></tr>
            <tr>
                <td class="ui-widget-content">
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="lblPeriode" runat="server" Text="Periode"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:TextBox ID="txtPeriod" runat="server"></asp:TextBox></td></tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="lblAsset" runat="server" Text="Asset Condition" Width="87px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlAssetCondition" runat="server" Width="148px">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem Value="NEW_AC">NEW</asp:ListItem>
                                    <asp:ListItem Value="USED_AC">USED</asp:ListItem>
                                </asp:DropDownList></td></tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label1" runat="server" Text="Brand" Width="87px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlBrand" runat="server" Width="148px">
                                </asp:DropDownList></td></tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label2" runat="server" Text="Branch" Width="87px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlBranch" runat="server" Width="148px">
                                </asp:DropDownList></td></tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label3" runat="server" Text="Recipient Name" Width="87px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:TextBox ID="txtRecipientName" runat="server"></asp:TextBox></td></tr>
                        <tr class="T19">
                            <td style="width: 100px"></td>
                            <td style="width: 100px">
                                <asp:Button ID="btnSearch" runat="server" CssClass="ui-button ui-state-default" Text="Search" OnClick="btnSearch_Click" OnClientClick="loadWait()" />
                                <asp:Button ID="btnConvert" runat="server" CssClass="ui-button ui-state-default" Text="Convert to Excel" OnClick="btnConvert_Click" /><br />
                                <asp:Button ID="btnWorkFlow" runat="server" CssClass="ui-button ui-state-default" Text="Submit to Workflow" OnClick="btnWorkFlow_Click" OnClientClick="loadWait()" /></td></tr>
                    </table>
                </td></tr>
            <tr>
                <td class="ui-widget-content">
                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvCashRewardPaid" runat="server" AutoGenerateColumns="False" PageSize="50" Font-Size="8pt" ShowFooter="True" Style="width: 100%" OnRowDataBound="gvCashRewardPaid_RowDataBound" OnDataBound="gvCashRewardPaid_DataBound" >
                                <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" Position="TopAndBottom" />
                                <Columns>
                                    <asp:BoundField DataField="Row" HeaderText="No" />
                                    <asp:BoundField DataField="Period" HeaderText="Period">
                                        <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:BoundField DataField="contract_id" HeaderText="Contract ID" >
                                        <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:BoundField DataField="supplier_type" HeaderText="Supplier Type" >
                                        <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:BoundField DataField="refund_recipient_id" HeaderText="Refund Recipient ID" >
                                        <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:BoundField DataField="supplier_code" HeaderText="Supplier Code" >
                                        <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:BoundField DataField="brand_Code" HeaderText="Brand Code" >
                                        <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:BoundField DataField="brand_name" HeaderText="Brand Name" />
                                    <asp:BoundField DataField="condition" HeaderText="Condition" />
                                    <asp:BoundField DataField="supplier_name" HeaderText="Supplier" />
                                    <asp:BoundField DataField="branch_parent" HeaderText="Branch" />
                                    <asp:TemplateField HeaderText="Contract">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("contract_number") %>'></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("contract_number") %>'></asp:Label>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("customer_name") %>'></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="dp_rate" HeaderText="DP Rate" />
                                    <asp:BoundField DataField="contract_term" HeaderText="Term" />
                                    <asp:BoundField DataField="payment_due_type_Code" HeaderText="Pay Type" />
                                    <asp:BoundField DataField="flat_input_rate" HeaderText="Flat Input" />
                                    <asp:BoundField DataField="car_type_name" HeaderText="Car Type" />
                                    <asp:BoundField DataField="admin_fee" HeaderText="Admin Fee" DataFormatString="{0:n}" HtmlEncode="False" />
                                    <asp:BoundField DataField="Eligible" HeaderText="Eligible" />
                                    <asp:BoundField DataField="amount_reward" HeaderText="Amount Reward" />
                                    <asp:BoundField DataField="recipient_name" HeaderText="Recipient Name" />
                                    <asp:BoundField DataField="Position" HeaderText="Position" />
                                    <asp:BoundField DataField="Bank_Name" HeaderText="Bank Name" />
                                    <asp:BoundField DataField="account_name" HeaderText="Account Name" />
                                    <asp:BoundField DataField="account_number" HeaderText="Account Number" />
                                    <asp:TemplateField HeaderText="NPWP">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("npwp") %>'></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblNPWP" runat="server" Text='<%# Bind("npwp") %>'></asp:Label></ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="Label4" runat="server" Text="GrandTotal :"></asp:Label></FooterTemplate>
                                        <FooterStyle HorizontalAlign="right" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="tax_procentage" HeaderText="Tax Procentage" >
                                        <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                    <asp:TemplateField HeaderText="Amount Reward Paid">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("amount_paid") %>' style="text-align: right"></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtAmountRewardPaid" CssClass="txtAmountRewardPaid" runat="server" Text='<%# Bind("amount_paid", "{0:n}") %>' style="text-align: right"></asp:TextBox></ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalAmount" runat="server" Font-Size="8pt"></asp:Label></FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tax Amount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("amount_tax") %>' style="text-align: right"></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblTax" runat="server" Text='<%# Bind("amount_tax", "{0:n}") %>' style="text-align: right"></asp:Label></ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalTax" runat="server" Font-Size="8pt" ></asp:Label></FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Net Amount Paid">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("amount_net") %>' style="text-align: right"></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblNet" runat="server" Text='<%# Bind("amount_net", "{0:n}") %>' style="text-align: right"></asp:Label></ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalNet" runat="server" Font-Size="8pt" ></asp:Label></FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" />    
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Paid">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("paid_in_same_period") %>'></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkPaid" runat="server" Checked='<%# (Eval("paid_in_same_period").ToString()=="Y")?Convert.ToBoolean(1):Convert.ToBoolean(0) %>' Enabled="false" /></ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="ui-widget-header" />
                                <PagerStyle ForeColor="Blue" VerticalAlign="Middle" Wrap="False" />
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="WhiteSmoke" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <uc2:ctrlPager ID="CtrlPager" runat="server"  OnNextClicked="NextPager" OnPrevClicked="PrevPager"/>                    
                    <br />
                    </td></tr>
        </table>
    </form>
</body>
</html>
