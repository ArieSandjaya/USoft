<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemTypeAddEdit.aspx.cs" Inherits="USoft.Modules.GeneralAffair.Master.ItemTypeAddEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsActive" TagPrefix="uc2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item Type Add Edit</title>
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
    <script type="text/javascript" src="../../../Javascript/general.js"></script>
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
                            <td class="form_table_title" style="width: 140px;">Item Type Code <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtItemTypeCode" runat="server" CssClass="validate[required]" Width="60"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Item Type Name <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtItemTypeName" runat="server" CssClass="validate[required]"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Item Category <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlItemCategory" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlItemCategory_SelectedIndexChanged"></asp:DropDownList></td>       
                        </tr>
                        <tr>
                            <td class="form_table_title">Item Group <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:UpdatePanel ID="pnlItemGroup" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlItemGroup" runat="server" CssClass="validate[required]"></asp:DropDownList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlItemCategory" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Measurement <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlMeasurement" runat="server" CssClass="validate[required]"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Description</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDescription" runat="server" rows="5" TextMode="multiline"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Active State <span class="reqMark">*</span></td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <uc2:ctrlIsActive ID="ucIsActive" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 27px">&nbsp;</td>
                            <td class="form_table_btn" style="height: 27px">
                                <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/Images/BtnAdd.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbAdd_Click"  />
                                <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Images/BtnUpdate.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbUpdate_Click"  />
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