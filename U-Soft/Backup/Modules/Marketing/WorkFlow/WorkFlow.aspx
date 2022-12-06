<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkFlow.aspx.cs" Inherits="USoft.Modules.Marketing.WorkFlow.WorkFlow" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>WorkFlow Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
        </div>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" /></td></tr>
            <tr>
                <td class="ui-widget-content">
                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvWorkflow" runat="server" AutoGenerateColumns="False" Style="width: 100%" OnRowCommand="gvWorkflow_RowCommand" OnRowDeleting="gvWorkflow_RowDeleting" OnRowEditing="gvWorkflow_RowEditing" >
                                <Columns>
                                    <asp:BoundField DataField="id" HeaderText="ID" />
                                    <asp:BoundField DataField="detail_id" HeaderText="Detail ID" />
                                    <asp:BoundField DataField="parameter_code" HeaderText="Parameter Code" />
                                    <asp:BoundField DataField="sequence" HeaderText="Sequence" />
                                    <asp:BoundField DataField="description" HeaderText="Description" />
                                    <asp:BoundField DataField="status" HeaderText="Status" />
                                    <asp:BoundField DataField="request_by" HeaderText="Request By" />
                                    <asp:CommandField DeleteText="Reject" SelectText="Approved" ShowDeleteButton="True" ShowSelectButton="True" EditText="View" ShowEditButton="True" />
                                </Columns>
                                <FooterStyle CssClass="ui-widget-header" />
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="WhiteSmoke" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </td></tr>
             <tr>
                <td class="ui-widget-content">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <table id="tblView" runat="server" class="hide" width="100%">
                                <tr>
                                    <td><asp:ImageButton ID="img_close" runat="server" OnClick="img_close_Click" /></td></tr>
                                <tr>
                                    <td><asp:GridView ID="gvCashRewardShow" Enabled="False" runat="server" AutoGenerateColumns="False" Font-Size="8pt" ShowFooter="True" Style="width: 100%" ForeColor="White" OnRowDataBound="gvCashRewardShow_RowDataBound" >
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
                                                <FooterStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="tax_procentage" HeaderText="Tax Procentage" >
                                                <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" /></asp:BoundField>
                                            <asp:TemplateField HeaderText="Amount Reward Paid" >
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("amount_paid") %>' style="text-align: right"></asp:TextBox></EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmountRewardPaid" runat="server" Text='<%# Bind("amount_paid", "{0:n}") %>' style="text-align: right;"></asp:TextBox></ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTotalAmount" runat="server" Font-Size="8pt" ></asp:Label></FooterTemplate>
                                                <FooterStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tax Amount">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("amount_tax") %>' style="text-align: right"></asp:TextBox></EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTax" runat="server" Text='<%# Bind("amount_tax", "{0:n}") %>' style="text-align: right"></asp:Label></ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTotalTax" runat="server" Font-Size="8pt" ></asp:Label></FooterTemplate>
                                                <FooterStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Net Amount Paid">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("amount_net") %>' style="text-align: right"></asp:TextBox></EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNet" runat="server" Text='<%# Bind("amount_net", "{0:n}") %>' style="text-align: right"></asp:Label></ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTotalNet" runat="server" Font-Size="8pt" ></asp:Label></FooterTemplate>
                                                <FooterStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="ui-widget-header" />
                                        <HeaderStyle CssClass="ui-widget-header" />
                                        <AlternatingRowStyle BackColor="WhiteSmoke" />
                                    </asp:GridView></td></tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td></tr>
        </table>
    </form>
</body>
</html>