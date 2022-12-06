<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntApproval.aspx.cs" Inherits="USoft.Modules.Compliance.Entertainment.EntApproval" %>

<%@ Register Src="~/Controls/ctrlPager.ascx" TagName="ctrlPager" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Entertainment Approval Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/validationEngine.jquery.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <table style="width: 100%;">
                <tr>
                    <td class="ui-widget-content">
                        <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="ui-widget-content">
                        <asp:UpdatePanel ID="updApp" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="gvApprove" runat="server" AutoGenerateColumns="False"
                                    CellPadding="4" Font-Size="8pt" ForeColor="#333333" GridLines="None" OnPageIndexChanging="gvApprove_PageIndexChanging"
                                    OnRowCommand="gvApprove_RowCommand" OnRowDataBound="gvApprove_RowDataBound"
                                    PageSize="20" ShowFooter="True"
                                    Style="width: 100%" OnRowEditing="gvApprove_RowEditing">
                                    <FooterStyle BackColor="#507CD1" CssClass="ui-widget-header " Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <Columns>
                                        <asp:BoundField DataField="KeyId" HeaderText="KeyId">
                                            <ControlStyle CssClass="hide" />
                                            <FooterStyle CssClass="hide" />
                                            <HeaderStyle CssClass="hide" />
                                            <ItemStyle CssClass="hide" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="labelNo" HeaderText="No" />
                                        <asp:BoundField DataField="CreateDate" DataFormatString="{0:dd-MMM-yyyy} " HeaderText="Create Date"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="resId" HeaderText="SequenceNo" />
                                        <asp:BoundField DataField="ApplName" HeaderText="Applicant Name" />
                                        <asp:BoundField DataField="Branch" HeaderText="Branch" />
                                        <asp:BoundField DataField="CountpartyName" HeaderText="Countparty Name" />
                                        <asp:BoundField DataField="EstimatedBgt" DataFormatString="{0:n}" HeaderText="Estimate" htmlEncode="False">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TotalAmount" DataFormatString="{0:n}" HeaderText="TotalAmount" htmlEncode="False">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status" />
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                    Text=""></asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                    Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <br />
                                                <table style="width: 94px">
                                                    <tr>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                                Style="text-decoration: none" Text="Approved" Width="66px"></asp:LinkButton></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Select"
                                                                Style="text-decoration: none" Text="Rejected" Width="66px"></asp:LinkButton></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="New"
                                                                Style="text-decoration: none" Text="Cancel" Width="66px"></asp:LinkButton></td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#507CD1" CssClass="ui-widget-header" Font-Bold="True" ForeColor="White" />
                                    <EditRowStyle BackColor="#2461BF" />
                                    <AlternatingRowStyle BackColor="White" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <uc2:ctrlPager ID="CtrlPager" runat="server" OnNextClicked="NextPager" OnPrevClicked="PrevPager" />
                    </td>
                </tr>
            </table>
        </div>
    
    </div>
    </form>
</body>
</html>
