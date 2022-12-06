<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdmSearchContractEdit.aspx.cs" Inherits="USoft.Modules.Marketing.AdmSearchContractEdit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Admin Fee</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="../../../Javascript/calcSisa.js" type="text/javascript"></script>
    <script src="../../../Javascript/NumberFormat.js" type="text/javascript"></script>
    <script src="../../../Javascript/CalculateAdm.js" type="text/javascript"></script>
    <style type="text/css">     
        .hide     
            {         
                display:none;     
             } 
        .show
            {         
                display:true;     
             }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" /></td>
            </tr>
        </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                        <table style="width: 100%; text-align: left; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;" id="tblMain">
                            <tr>
                                <td style="width: 30px; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; height: 18px;">
                                </td>
                                <td style="width: 158px; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; height: 18px;">
                                    <asp:Label ID="Label3" runat="server" Text="Contract Number" Width="121px" style="text-align: right; font-size: 0.9em; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" Height="16px"></asp:Label></td>
                                <td colspan="8" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px;
                                    margin: 0px; padding-top: 0px; height: 18px;">
                                    <asp:TextBox ID="txtContractNum" runat="server" Font-Names="Arial"
                                        ReadOnly="True" Style="text-align: left; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" Width="165px" Height="12px" CssClass="T28"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 30px">
                                </td>
                                <td style="width: 158px; text-align: right">
                                    <asp:Label ID="lblCustName" runat="server" Height="16px" Style="padding-right: 0px; padding-left: 0px;
                                        font-size: 0.9em; padding-bottom: 0px; margin: 0px; padding-top: 0px; text-align: right"
                                        Text="Customer Name" Width="121px"></asp:Label></td>
                                <td colspan="8" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">
                                    <asp:TextBox ID="txtCustName" runat="server" Width="384px" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" Wrap="False" CssClass="T28"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 30px">
                                </td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                                    padding-top: 0px; width: 158px;">
                                    <asp:Label ID="Label20" runat="server" Style="font-size: 0.9em; text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;"
                                        Text="Insurance Name" Width="121px" Height="16px"></asp:Label></td>
                                <td colspan="8" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px;
                                    margin: 0px; padding-top: 0px">
                                    <asp:TextBox ID="txtInsuranceName" runat="server" Height="12px" ReadOnly="True" Style="padding-right: 0px;
                                        padding-left: 0px; padding-bottom: 0px;
                                        margin: 0px; padding-top: 0px;
                                        text-align: left" Width="270px" Wrap="False" CssClass="T28"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 30px">
                                </td>
                                <td style="width: 158px">
                                    <asp:Label ID="Label21" runat="server" Style="font-size: 0.9em; text-align: right"
                                        Text="Insurance Type" Width="121px" Height="16px"></asp:Label></td>
                                <td colspan="8" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px;
                                    margin: 0px; padding-top: 0px">
                                    <asp:Label ID="Label22" runat="server" Font-Bold="True" Height="12px" Style="font-size: 0.9em;
                                        font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right"
                                        Text="1"></asp:Label>
                                    <asp:Label ID="lbl01" runat="server" Height="12px" Style="padding-right: 0px; padding-left: 0px;
                                        font-size: 0.9em; padding-bottom: 0px; margin: 0px; padding-top: 0px; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="35px" Font-Bold="True"></asp:Label>
                                    <asp:Label ID="Label23" runat="server" Font-Bold="True" Height="12px" Style="font-size: 0.9em;
                                        font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right"
                                        Text="2"></asp:Label>
                                    <asp:Label ID="lbl02" runat="server" Height="12px" Style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="35px" Font-Bold="True"></asp:Label>
                                    <asp:Label ID="lbl0" runat="server" Font-Bold="True" Height="12px" Style="font-size: 0.9em;
                                        font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right"
                                        Text="3"></asp:Label>
                                    <asp:Label ID="lbl03" runat="server" Height="12px" Style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="35px" Font-Bold="True"></asp:Label>
                                    <asp:Label ID="Label24" runat="server" Font-Bold="True" Height="12px" Style="font-size: 0.9em;
                                        font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right"
                                        Text="4"></asp:Label>
                                    <asp:Label ID="lbl04" runat="server" Height="12px" Style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="35px" Font-Bold="True"></asp:Label>
                                    <asp:Label ID="lbl05" runat="server" Font-Bold="True" Height="12px" Style="font-size: 0.9em;
                                        font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right"
                                        Text="5"></asp:Label>
                                    <asp:Label ID="Label1" runat="server" Height="12px" Style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="35px" Font-Bold="True"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 30px">
                                </td>
                                <td style="width: 158px">
                                    <asp:Label ID="lblModel" runat="server" Style="font-size: 0.9em; text-align: right"
                                        Text="Model" Width="121px" Height="16px"></asp:Label></td>
                                <td colspan="8" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px;
                                    margin: 0px; padding-top: 0px">
                                    <asp:TextBox ID="txtModel" runat="server" Height="12px" ReadOnly="True" Style="padding-right: 0px;
                                        padding-left: 0px; padding-bottom: 0px;
                                        margin: 0px; padding-top: 0px;
                                        text-align: left" Width="270px" Wrap="False" CssClass="T28"></asp:TextBox>
                                    <asp:TextBox ID="txtBrand" runat="server" Style="display: none"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 30px">
                                </td>
                                <td style="width: 158px">
                                    <asp:Label ID="Category" runat="server" Style="font-size: 0.9em; text-align: right"
                                        Text="Category" Width="121px" Height="16px"></asp:Label></td>
                                <td colspan="8" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px;
                                    margin: 0px; padding-top: 0px">
                                    <asp:TextBox ID="txtCategory" runat="server" Height="12px" ReadOnly="True" Style="padding-right: 0px;
                                        padding-left: 0px; padding-bottom: 0px;
                                        margin: 0px; padding-top: 0px;
                                        text-align: left" Width="270px" Wrap="False" CssClass="T28"></asp:TextBox>
                                    <asp:TextBox ID="txtInsRate" runat="server" Style="display: none" Width="14px"></asp:TextBox>
                                    <asp:TextBox ID="txtInsRate2" runat="server" Style="display: none" Width="14px"></asp:TextBox>
                                    <asp:TextBox ID="txtInsRate3" runat="server" Style="display: none" Width="14px"></asp:TextBox>
                                    <asp:TextBox ID="txtInsRate4" runat="server" Style="display: none" Width="14px"></asp:TextBox>
                                    <asp:TextBox ID="txttjh" runat="server" Style="display: none" Width="14px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 30px">
                                </td>
                                <td style="width: 158px">
                                    <asp:Label ID="Label25" runat="server" Style="font-size: 0.9em; text-align: right"
                                        Text="Asset Condition" Width="121px" Height="16px"></asp:Label></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtAssetCond" runat="server" Font-Names="Arial" Font-Size="Smaller"
                                        Height="12px" ReadOnly="True" Style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;
                                        text-align: right" Width="95px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 25px">
                                    <asp:Label ID="Label16" runat="server" Style="padding-right: 0px; padding-left: 0px;
                                        font-size: 0.9em; padding-bottom: 0px; margin: 0px; padding-top: 0px; text-align: right"
                                        Text="Std Premi %" Width="95px"></asp:Label></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                                    padding-top: 0px">
                                    <asp:TextBox ID="txtStdPremiPercent" runat="server" Height="12px" ReadOnly="True"
                                        Style="padding-right: 0px; padding-left: 0px;
                                        padding-bottom: 0px; margin: 0px; padding-top: 0px;
                                        text-align: right" Width="75px" CssClass="T28"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Style="text-align: right; font-size: 0.9em; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" Text="Admin Fee (Cash)"
                                        Width="105px"></asp:Label></td>
                                <td style="width: 56px">
                                    <asp:TextBox ID="txtAdmFee" runat="server" ReadOnly="True" Style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;"
                                        Width="75px" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 252px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30px;">
                                </td>
                                <td style="width: 158px;">
                                    <asp:Label ID="Label14" runat="server" Text="Harga OTR" Width="121px" style="text-align: right; font-size: 0.9em;" Height="16px"></asp:Label></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtOTR" runat="server" Width="95px" style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Font-Names="Arial" Font-Size="Smaller" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 25px;">
                                    <asp:Label ID="Label2" runat="server" Text="Std Premi" Width="95px" style="text-align: right; font-size: 0.9em; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;"></asp:Label></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;">
                                    <asp:TextBox ID="txtStdPremi" runat="server" Width="75px" style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="Label7" runat="server" Text="Admin Fee (Credit)" Width="105px" style="text-align: right; font-size: 0.9em;" Height="16px"></asp:Label></td>
                                <td style="width: 56px;">
                                    <asp:TextBox ID="txtPremiCredit" runat="server" Width="75px" style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 252px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30px;">
                                </td>
                                <td style="width: 158px;">
                                    <asp:Label ID="lblYear" runat="server" Style="padding-right: 0px; padding-left: 0px;
                                        font-size: 0.9em; padding-bottom: 0px; margin: 0px; padding-top: 0px; text-align: right"
                                        Text="Year Of Manufacture" Width="121px" Height="16px"></asp:Label></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtYear" runat="server" Height="12px" ReadOnly="True" Style="padding-right: 0px;
                                        padding-left: 0px; padding-bottom: 0px;
                                        margin: 0px; padding-top: 0px;
                                        text-align: right" Width="95px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 25px;">
                                    <asp:Label ID="lblAdmFee" runat="server" Text="Admin Fee %" Width="95px" style="text-align: right; font-size: 0.9em;"></asp:Label></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;">
                                    <asp:TextBox ID="txtAdmFeePercen" runat="server" Width="75px" style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Style="text-align: right; font-size: 0.9em;" Text="Policy Fee (Cash)" Width="105px" Height="16px"></asp:Label></td>
                                <td style="width: 56px;">
                                    <asp:TextBox ID="txtPolicyFeeCash" runat="server" ReadOnly="True" Style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" Width="75px" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 252px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30px;">
                                </td>
                                <td style="width: 158px;">
                                    <asp:Label ID="Label15" runat="server" Text="Commence Date" Width="121px" style="text-align: right; font-size: 0.9em;" Height="16px"></asp:Label></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtCommence" runat="server" Font-Names="Arial" Font-Size="Smaller"
                                        Height="12px" ReadOnly="True" Style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;
                                        text-align: right" Width="95px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 25px;">
                                    <asp:Label ID="Label4" runat="server" Style="text-align: right; font-size: 0.9em;" Text="Admin Fee"
                                        Width="95px"></asp:Label></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;">
                                    <asp:TextBox ID="txtAdminFee" runat="server" ReadOnly="True" Style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;"
                                        Width="75px" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text="Policy Fee (Credit)" Width="105px" style="text-align: right; font-size: 0.9em; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" Height="16px"></asp:Label></td>
                                <td style="width: 56px;">
                                    <asp:TextBox ID="txtPolicyFeeCredit" runat="server" Width="75px" style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 252px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30px;">
                                </td>
                                <td style="width: 158px;">
                                    <asp:Label ID="Label8" runat="server" Text="Adm Premi Cash" Width="121px" style="text-align: right; font-size: 0.9em;" Visible="False" Height="16px"></asp:Label></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtPremiCash" runat="server" Width="95px" style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Visible="False" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 25px;">
                                    <asp:Label ID="Label6" runat="server" Text="Total premi+Adm" Width="95px" style="text-align: right; font-size: 0.9em;"></asp:Label></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;">
                                    <asp:TextBox ID="txtPremiCust" runat="server" Width="75px" style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; text-align: right">
                                    <asp:Label ID="Label13" runat="server" Style="text-align: right; font-size: 0.9em;" Text="Other Fee (Cash)"
                                        Width="105px" Height="16px"></asp:Label></td>
                                <td style="width: 56px;">
                                    <asp:TextBox ID="txtOtherFeeCash" runat="server" ReadOnly="True" Style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" Width="75px" Height="12px" CssClass="T28"></asp:TextBox></td>
                                <td style="width: 252px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30px;">
                                </td>
                                <td style="width: 158px;">
                                    <asp:Label ID="lblRefundNet" runat="server" Style="text-align: right; font-size: 0.9em;" Text="Refund Net"
                                        Width="121px" Height="16px"></asp:Label></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtRefundNet" runat="server" Style="font-weight: bold;
                                        font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;"
                                        Width="95px" BackColor="WhiteSmoke" BorderColor="LightSteelBlue" BorderStyle="Solid" Enabled="False" Height="12px"></asp:TextBox></td>
                                <td style="width: 25px;">
                                    <asp:Label ID="Label10" runat="server" Style="text-align: right; font-size: 0.9em;" Text="Refund Gross" Width="95px"></asp:Label></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;">
                                    <asp:TextBox ID="txtRefund" runat="server" Style="font-weight: bold;
                                        font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;"
                                        Width="75px" BackColor="WhiteSmoke" BorderColor="LightSteelBlue" BorderStyle="Solid" Enabled="False" Height="12px"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="Label17" runat="server" Height="16px" Style="font-size: 0.9em; text-align: right"
                                        Text="Recalc Amdin Fee %" Width="105px"></asp:Label></td>
                                <td style="width: 56px;">
                                    <asp:DropDownList ID="ddlRecalc" runat="server" onchange='ddlChange(this.form.ddlRecalc);' BackColor="#FFFFC0" CssClass="D01">
                                        <asp:ListItem Selected="True" Value="0">0 %</asp:ListItem>
                                        <asp:ListItem Value="40">40.00 %</asp:ListItem>
                                        <asp:ListItem Value="42.5">42.50 %</asp:ListItem>
                                        <asp:ListItem Value="45">45.00 %</asp:ListItem>
                                        <asp:ListItem Value="47.5">47.50 %</asp:ListItem>
                                        <asp:ListItem Value="50">50.00 %</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="width: 252px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30px;">
                                </td>
                                <td style="width: 158px;">
                                    <asp:Label ID="Label19" runat="server" Style="text-align: right; font-size: 0.9em;" Text="Max Refund Percentage"
                                        Width="121px"></asp:Label></td>
                                <td colspan="3" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;">
                                    <asp:Label ID="lblMaxRefund" runat="server" ForeColor="Red" Style="text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;"
                                        Width="95px"></asp:Label></td>
                                <td style="width: 25px;">
                                    <asp:Label ID="Label12" runat="server" Style="text-align: right; font-size: 0.9em;" Text="Refund Precentage"
                                        Width="95px"></asp:Label></td>
                                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;">
                                    <asp:TextBox ID="txtRefundPercen" runat="server" BackColor="#FFFFC0" BorderColor="LightSteelBlue"
                                        BorderStyle="Groove" Style="font-weight: bold; font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="49px" onchange="calcRefund(this.value);" OnTextChanged="txtRefundPercen_TextChanged" Height="12px"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtFlatRate" runat="server" Width="5px" style="font-weight: bold; font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" Visible="False"></asp:TextBox>
                                    <asp:TextBox ID="txtEffRate" runat="server" Width="8px" style="font-weight: bold; font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" Visible="False"></asp:TextBox>
                                    <asp:TextBox ID="txtInputRate" runat="server" Width="12px" style="font-weight: bold; font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" Visible="False"></asp:TextBox>
                                    <asp:TextBox ID="txtEffInputRate" runat="server" Width="13px" style="font-weight: bold; font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px;" ReadOnly="True" Height="12px" Visible="False"></asp:TextBox></td>
                                <td style="width: 56px;">
                                    <asp:TextBox ID="txtNett" runat="server" CssClass="hide" Width="27px" Height="12px" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px"></asp:TextBox>
                                    <asp:TextBox ID="txtRefundDealer" runat="server" CssClass="hide" Height="12px" Style="padding-right: 0px;
                                        padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px" Width="9px">0</asp:TextBox></td>
                                <td style="width: 252px">
                                </td>
                            </tr>
                        </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Style="cursor: hand;"
                                        Text="Save" Width="58px" CssClass="B01" />
                <asp:Button ID="btnPrint" runat="server" Height="21px" Text="Print" Width="58px" Style="cursor: hand;" Enabled="False" OnClick="btnPrint_Click" CssClass="B01" />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <cc1:TabContainer ID="tc" runat="server" ActiveTabIndex="0" Width="100%">
            <cc1:TabPanel ID="tp1" runat="server" HeaderText="TabPanel1">
                <ContentTemplate>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            <div style="width: 100%; border-top-style: none; border-right-style: none; border-left-style: none; height: 100%; border-bottom-style: none">
                        <asp:Label ID="lbl40" runat="server" Style="text-align: center; vertical-align: text-bottom;" Width="100%" Font-Bold="True" Height="35px"></asp:Label>
                        <asp:GridView ID="gViewTotal" runat="server" AutoGenerateColumns="False"  ShowFooter="True" OnDataBound="gViewTotal_DataBound" style="font-size: 0.9em;" OnRowDataBound="gViewTotal_RowDataBound" Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Net">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtNet" runat="server" Style="font-size: 0.9em" Width="35px" onblur="calc(this.id,this.value);"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Gross">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtGross" runat="server" Style="font-size: 0.9em" Width="35px" onblur="calc(this.id,this.value);"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="% Gross">
                                            <FooterTemplate>
                                                <asp:TextBox ID="lblGrossTotal" runat="server" BorderColor="Transparent" BorderStyle="None"
                                                    Style="font-size: 0.9em; color: white; background-color: transparent; text-align: right; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif;"
                                                    Width="50px"></asp:TextBox>
                                            </FooterTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="lblGross" runat="server" Width="75px" style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; border-top-style: none; border-right-style: none; border-left-style: none; text-align: right; border-bottom-style: none; width: 50px;" BorderStyle="None" BorderColor="Transparent"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="GrossMurni">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGrossMurni" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblMurniTot" runat="server"></asp:Label>
                                                </FooterTemplate>
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="recipient_type_code" HeaderText="Recipient Code">
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="Recipient ID" DataField="recipientId">
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="RecipientName" HeaderText="Recipient Name" />
                                            <asp:BoundField DataField="BankName" HeaderText="Bank Name" />
                                            <asp:BoundField DataField="AccountName" HeaderText="Account Name" />
                                            <asp:BoundField DataField="AccountNumber" HeaderText="Account Number" >
                                                <FooterStyle CssClass="ui-widget-header" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Tax Percent">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TaxProcentage") %>' Width="7px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaxPercentTotal" runat="server" Text='<%# Bind("TaxProcentage") %>'
                                                        Width="29px"></asp:Label>
                                                </ItemTemplate>
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;<asp:TextBox ID="lblTotalAmount" runat="server" BorderColor="Transparent" BorderStyle="None"
                                                        Style="font-size: 0.9em; color: white; background-color: transparent; text-align: right; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif;"
                                                        Width="75px"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    &nbsp;<asp:TextBox ID="lblAmountTotal" runat="server" Width="75px" style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; border-top-style: none; border-right-style: none; border-left-style: none; text-align: right; border-bottom-style: none;" BorderColor="Transparent" BorderStyle="None"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
                                                <FooterStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tax Amount " ShowHeader="False">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTaxAmount" runat="server" Height="100%" Style="font-weight: bold;
                                                        font-size: 0.9em; text-align: right" Width="95%"></asp:Label>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="lblTaxAmountTotal" runat="server" Width="75px" style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; border-top-style: none; border-right-style: none; border-left-style: none; text-align: right; border-bottom-style: none;" BorderStyle="None" BorderColor="Transparent"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Net Amount">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                   <asp:Label ID="lblTotalNetAmount" runat="server" Height="100%" Style="font-weight: bold;
                                                        font-size: 0.9em; text-align: right" Width="95%"></asp:Label>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    &nbsp;<asp:TextBox ID="lblNetAmountTotal" runat="server" Width="75px" style="font-size: 0.9em; border-top-style: none; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; border-right-style: none; border-left-style: none; background-color: transparent; text-align: right; border-bottom-style: none" BorderStyle="None"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CurrentTaxTypeCode" >
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="NPWP" >
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                        </Columns>
                            <FooterStyle CssClass="ui-widget-header" Font-Size="0.9em" />
                            <PagerTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </PagerTemplate>
                            <HeaderStyle CssClass="ui-widget-header" />
                            <RowStyle Font-Size="0.9em" />
                        </asp:GridView>
                <asp:Label ID="lbl25" runat="server" Style="text-align: center; vertical-align: text-bottom;" Width="100%" Font-Bold="True" Height="35px"></asp:Label>
                <asp:GridView ID="gViewTotal25" runat="server" AutoGenerateColumns="False" Width="100%"  ShowFooter="True" style="font-size: 0.9em" OnRowCreated="gViewTotal25_RowCreated" OnRowDataBound="gViewTotal25_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtNetTotal25" runat="server" BackColor="Transparent" BorderColor="Transparent"
                                    BorderStyle="None" BorderWidth="0px" ForeColor="Transparent"
                                    ReadOnly="True" Style="font-size: 0.9em" Width="38px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="percentAsli" runat="server" BackColor="Transparent" BorderColor="Transparent"
                                    BorderStyle="None" BorderWidth="0px" ForeColor="Transparent" onblur="calcPercen(this.id,this.value);" Style="font-size: 0.9em" Width="38px" Enabled="False"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Percen25" DataFormatString="{0:N}" HeaderText="% Gross" HtmlEncode="False">
                            <ItemStyle HorizontalAlign="Right" />
                            <ControlStyle Width="75px" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Percen25" HeaderText="Gross Murni">
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                        <asp:BoundField DataField="recipient_type_code" HeaderText="RecipientCode">
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="RecipientID" DataField="recipientId">
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RecipientName" HeaderText="Recipient Name" />
                        <asp:BoundField DataField="BankName" HeaderText="Bank Name" />
                        <asp:BoundField DataField="AccountName" HeaderText="Account Name" />
                        <asp:BoundField DataField="AccountNumber" HeaderText="Account Number" >
                            <FooterStyle CssClass="ui-widget-header" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Tax Percent">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TaxProcentage") %>' Width="7px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTaxPercentgViewTotal25" runat="server" Text='<%# Bind("TaxProcentage") %>'
                                    Width="29px"></asp:Label>
                            </ItemTemplate>
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Amount25" DataFormatString="{0:N}" HeaderText="Amount" HtmlEncode="False">
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TaxAmount25" DataFormatString="{0:N}" HeaderText="Tax Amount" HtmlEncode="False">
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="netAmount25" DataFormatString="{0:N}" HeaderText="Net Amount" HtmlEncode="False">
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CurrentTaxTypeCode" HeaderText="Tax Type" >
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NPWP" HeaderText="NPWP" >
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle CssClass="ui-widget-header" Font-Size="0.9em" />
                    <PagerTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </PagerTemplate>
                    <HeaderStyle CssClass="ui-widget-header" />
                    <RowStyle Font-Size="0.9em" />
                </asp:GridView>
                <asp:Label ID="lblSisa" runat="server" Style="text-align: center; vertical-align: text-bottom;" Width="100%" Font-Bold="True" Height="35px"></asp:Label>
                <asp:GridView ID="gViewTotalSisa" runat="server" AutoGenerateColumns="False" Width="100%"  ShowFooter="True" OnRowCreated="gViewTotalSisa_RowCreated" style="font-size: 0.9em">
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtNetSisa" runat="server" BackColor="Transparent" BorderColor="Transparent"
                                    BorderStyle="None" BorderWidth="0px" ForeColor="Transparent" ReadOnly="True"
                                    Style="font-size: 0.9em; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif; text-align: right;" Width="38px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrossSisa" runat="server" BackColor="Transparent" BorderColor="Transparent"
                                    BorderStyle="None" BorderWidth="0px" ForeColor="Transparent" onblur="calcPercen(this.id,this.value);"
                                    ReadOnly="True" Style="font-size: 0.9em" Width="38px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="% Gross">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                            </ItemTemplate>
                            <FooterStyle HorizontalAlign="Right" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gross Murni">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="lblGrossMurniTotal25" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="recipient_type_code" HeaderText="Recipient Code">
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Recipient ID" DataField="recipientId">
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RecipientName" HeaderText="Recipient Name" />
                        <asp:BoundField DataField="BankName" HeaderText="Bank Name" />
                        <asp:BoundField DataField="AccountName" HeaderText="Account Name" />
                        <asp:BoundField DataField="AccountNumber" HeaderText="Account Number" >
                            <FooterStyle CssClass="ui-widget-header" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Tax Percent">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TaxProcentage") %>' Width="7px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTaxPercentgViewTotal25" runat="server" Text='<%# Bind("TaxProcentage") %>'
                                    Width="29px"></asp:Label>
                            </ItemTemplate>
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                &nbsp;<asp:Label ID="lblTotalAmountgViewTotal25" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAmountTotalgViewTotal25" runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tax Amount " ShowHeader="False">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTaxAmountgViewTotal25" runat="server" Height="100%" Style="font-weight: bold;
                                    font-size: 0.9em; text-align: right" Width="95%"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTaxAmountgViewTotal25" runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Net Amount">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblNetAmountgViewTotal25" runat="server" Height="100%" Style="font-weight: bold;
                                    font-size: 0.9em; text-align: right" Width="95%"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                &nbsp;<asp:Label ID="lblNetAmountgViewTotal25" runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="CurrentTaxTypeCode" >
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NPWP" >
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle CssClass="ui-widget-header" Font-Size="0.9em" />
                    <PagerTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </PagerTemplate>
                    <HeaderStyle CssClass="ui-widget-header" />
                    <RowStyle Font-Size="0.9em" />
                </asp:GridView>
                <table style="width: 616px; text-align: right;">
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                            </td>
                        <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                            width: 100px; padding-top: 0px">
                            <asp:Label ID="lblTotalAB1" runat="server" Style="font-size: 0.8em; text-align: right"
                                Text="Amount Total" Width="107px" Font-Size="0.9em"></asp:Label></td>
                        <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                            width: 100px; padding-top: 0px; text-align: right;">
                            <asp:Label ID="lblTotalAB" runat="server" Font-Bold="True" Style="padding-right: 0px;
                                padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; text-align: right; font-size: 0.8em;"
                                Width="90px" Font-Size="0.9em"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                            width: 100px; padding-top: 0px">
                            <asp:Label ID="Label26" runat="server" Style="font-size: 0.8em; text-align: right"
                                Text="Tax Total" Width="107px" Font-Size="0.9em"></asp:Label></td>
                        <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                            width: 100px; padding-top: 0px; text-align: right;">
                            <asp:Label ID="lblTotalTaxAB" runat="server" Font-Bold="True" Style="padding-right: 0px;
                                padding-left: 0px; font-size: 0.8em; padding-bottom: 0px; margin: 0px; padding-top: 0px;
                                text-align: right" Width="90px" Font-Size="0.9em"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="width: 100px; text-align: right">
                        </td>
                        <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                            width: 100px; padding-top: 0px">
                            <asp:Label ID="Label27" runat="server" Style="font-size: 0.8em; text-align: right"
                                Text="Net Total" Width="107px" Font-Size="0.9em"></asp:Label></td>
                        <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                            width: 100px; padding-top: 0px; text-align: right;">
                            <asp:Label ID="lblTotalNetAB" runat="server" Font-Bold="True" Style="padding-right: 0px;
                                padding-left: 0px; font-size: 0.8em; padding-bottom: 0px; margin: 0px; padding-top: 0px;
                                text-align: right" Width="90px" Font-Size="0.9em"></asp:Label></td>
                    </tr>
                </table>
            </div>                        
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnCalculate" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
                </ContentTemplate>
                <HeaderTemplate>
                    Insurance Refund
                </HeaderTemplate>
            </cc1:TabPanel>
            <cc1:TabPanel ID="tp2" runat="server" HeaderText="TabPanel2">
                <HeaderTemplate>
                    Interest Refund
                </HeaderTemplate>
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gViewInterest" runat="server" AutoGenerateColumns="False" Width="100%"  ShowFooter="True" style="font-size: 0.9em" OnRowCreated="gViewTotal25_RowCreated" OnRowDataBound="gViewTotal25_RowDataBound">
                                <RowStyle Font-Size="0.9em" />
                                <Columns>
                                    <asp:BoundField DataField="recipient_type_code" HeaderText="RecipientCode">
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="RecipientID" DataField="recipientId">
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RecipientName" HeaderText="Recipient Name" />
                                    <asp:BoundField DataField="BankName" HeaderText="Bank Name" />
                                    <asp:BoundField DataField="AccountName" HeaderText="Account Name" />
                                    <asp:BoundField DataField="AccountNumber" HeaderText="Account Number" >
                                        <FooterStyle CssClass="ui-widget-header" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Tax Percent">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TaxProcentage") %>' Width="7px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaxPercentgViewTotal25" runat="server" Text='<%# Bind("TaxProcentage") %>'
                                                Width="29px"></asp:Label>
                                        </ItemTemplate>
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Amount25" DataFormatString="{0:N}" HeaderText="Amount" HtmlEncode="False">
                                        <FooterStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TaxAmount25" DataFormatString="{0:N}" HeaderText="Tax Amount" HtmlEncode="False">
                                        <FooterStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="netAmount25" DataFormatString="{0:N}" HeaderText="Net Amount" HtmlEncode="False">
                                        <FooterStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentTaxTypeCode" HeaderText="Tax Type" >
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NPWP" HeaderText="NPWP" >
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                        <ItemStyle CssClass="hide" />
                                    </asp:BoundField>
                                </Columns>
                                <FooterStyle CssClass="ui-widget-header" Font-Size="0.9em" />
                                <PagerTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </PagerTemplate>
                                <HeaderStyle CssClass="ui-widget-header" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
        </cc1:TabContainer>
<div>
    </div>
        <asp:Button ID="btnCalculate" runat="server" OnClick="btnCalculate_Click" Text="Calculate" style="font-size: 0.9em; cursor: hand;" Width="58px" CssClass="hide" />
    </form>
</body>
</html>
