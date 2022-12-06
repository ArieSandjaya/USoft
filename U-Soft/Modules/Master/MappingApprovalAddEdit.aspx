<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MappingApprovalAddEdit.aspx.cs" Inherits="USoft.Modules.Master.MappingApprovalAddEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsActive" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlIsActive.ascx" TagName="ctrlIsBranch" TagPrefix="uc3" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Mapping Approval Add Edit</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" />
    <link rel="stylesheet" type="text/css" href="../../CSS/black-tie/ui-layout.css" />
    <link rel="stylesheet" type="text/css" href="../../CSS/black-tie/validationEngine.jquery.css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript" src="../../Javascript/NumberFormat.js"></script>
    <script type="text/javascript" src="../../Javascript/general.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
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
                                <td class="form_table_title" style="width: 120px;">Menu <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:DropDownList ID="ddlMenu" runat="server" CssClass="validate[required]"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Departement <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:DropDownList ID="ddlDepartement" runat="server"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Privilege Approval <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:DropDownList ID="ddlParent" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlParent_SelectedIndexChanged"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">User Approval</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:UpdatePanel ID="pnlUserApproval" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlUserApproval" runat="server"></asp:DropDownList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlParent" />
                                    </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">For Branch <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <uc3:ctrlIsBranch ID="ucIsBranch" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">State <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:TextBox ID="txtState" runat="server" CssClass="validate[required] text-input text-number"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">State Description</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:TextBox ID="txtStateDescription" runat="server" Rows="3" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_table_title">Active State <span class="reqMark">*</span></td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <uc2:ctrlIsActive ID="ucIsActive" runat="server" />
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
                <tr id="trMail" runat="server">
                    <td class="ui-widget-content">
                        <uc1:ctrlFormHeader ID="ucHeaderMail" runat="server" />
                        <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                            <tr>
                                <td class="form_table_title" style="width: 120px;">User</td>
                                <td class="form_table_sepp">:</td>
                                <td class="form_table">
                                    <asp:DropDownList ID="ddlUserMail" runat="server"></asp:DropDownList>
                                    <asp:ImageButton ID="imbAddMail" runat="server" ImageUrl="~/Images/BtnAdd.png" OnClick="imbAddMail_Click" />
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="gvApprovalMail" runat="server" AutoGenerateColumns="False"
                             Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" OnRowDataBound="gvApprovalMail_RowDataBound" OnRowDeleting="gvApprovalMail_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="ApprovalEmailId">
                                    <ItemStyle CssClass="hide" />
                                    <ControlStyle CssClass="hide" />
                                    <FooterStyle CssClass="hide" />
                                    <HeaderStyle CssClass="hide" />
                                </asp:BoundField>
                                <asp:BoundField DataField="UserName" HeaderText="NAME" />
                                <asp:BoundField DataField="Email" HeaderText="EMAIL" />
                                <asp:CommandField HeaderText="ACTION" ShowDeleteButton="True">
                                    <ItemStyle HorizontalAlign="Center" Width="80px" />
                                </asp:CommandField>
                            </Columns>
                            <HeaderStyle CssClass="ui-widget-header" />
                            <AlternatingRowStyle BackColor="Gainsboro" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>   
            </ContentTemplate>
        </asp:UpdatePanel>   
    </div>                      
    </form>
</body>
</html>