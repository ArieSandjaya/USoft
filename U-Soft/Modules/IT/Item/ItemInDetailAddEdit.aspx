<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemInDetailAddEdit.aspx.cs" Inherits="USoft.Modules.IT.Item.ItemInDetailAddEdit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item In Detail Add Edit</title>
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
                                    <td class="form_table_title">Item-In Detail Code</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblItemInDetailCode" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title">Item-In Code</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblItemInCode" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title">Receive From</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblReceiveFrom" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td class="form_table_title">Status In <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                          <asp:DropDownList ID="ddlStatusIn" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusIn_SelectedIndexChanged">
                                               <asp:ListItem Value="">- Select One -</asp:ListItem>
                                               <asp:ListItem Value="1">New</asp:ListItem>
                                               <asp:ListItem Value="2">Return</asp:ListItem>
                                               <asp:ListItem Value="3">Replace</asp:ListItem>
                                          </asp:DropDownList></td></tr>
                                <tr>
                                    <td class="form_table_title" style="width: 120px;">Item Type <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:DropDownList ID="ddlItemType" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="getITItem"></asp:DropDownList></td></tr>
                                <tr id="trOldSerialNo" runat="server">
                                    <td class="form_table_title">Item <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table">
                                        <asp:UpdatePanel ID="pnlItemCode" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlItemOutCode" runat="server" CssClass="validate[required]"></asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlItemType" />
                                        </Triggers>
                                   </asp:UpdatePanel>
                                   </td></tr>
                                <tr id="trNewSerialNo" runat="server">
                                    <td class="form_table_title">New Serial No <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:TextBox ID="txtSerialNo" runat="server" CssClass="validate[required]"></asp:TextBox></td></tr>
                                <tr>
                                    <td class="form_table_title">Barcode <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:TextBox ID="txtBarcode" runat="server" CssClass="validate[required]"></asp:TextBox></td></tr>
                                <tr id="trModel" runat="server">
                                    <td class="form_table_title">Model</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td></tr>
                                <tr>
                                    <td class="form_table_title">Condition <span class="reqMark">*</span></td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:DropDownList ID="ddlCondition" runat="server" CssClass="validate[required]"></asp:DropDownList></td></tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td class="form_table_btn">
                                        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/Images/BtnAdd.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbAdd_Click" />
                                        <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Images/BtnUpdate.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbUpdate_Click"  />
                                        <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click"  />
                                    </td></tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlStatusIn" />
            </Triggers>
        </asp:UpdatePanel>                
    </div>                      
    </form>
</body>
</html>