<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashRewardPerApplDetail.aspx.cs" Inherits="USoft.Modules.Marketing.CashReward.CashRewardPerApplDetail" %>

<%@ Register Src="../../../Controls/ctrlCashRewardRecipient.ascx" TagName="ctrlCashRewardRecipient"
    TagPrefix="uc4" %>
<%@ Register Src="../../../Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc3" %>

<%@ Register Src="../../../Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc2" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"

    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Cash Reward Per Application Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        </div>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <table style="width: 100%" cellspacing="1" cellpadding="0" border="0">
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Contract Number</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:Label ID="lblContractNumber" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Customer Name</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:Label ID="lblCustomerName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Brand Name</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:Label ID="lblBrandName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Supplier Name</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:Label ID="lblSupplierName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Amount Reward</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:Label ID="lblAmountReward" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <div class="form_table_btn">
                        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/Images/BtnAddDetail.png" OnClick="imbAdd_Click" />
                    </div></td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <asp:Panel ID="pnlData" runat="server">
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvCashRewardDetail" runat="server" AutoGenerateColumns="False" EmptyDataText="No Data Available"
                                Font-Size="8pt" Style="width: 100%" OnRowCommand="gvInsentif_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="refund_recipient_id" HeaderText="REFUND RECIPIENT ID">
                                        <ItemStyle HorizontalAlign="Center" Width="70px" CssClass="hide" />
                                        <ControlStyle CssClass="hide" />
                                        <FooterStyle CssClass="hide" />
                                        <HeaderStyle CssClass="hide" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="recipientName" HeaderText="RECIPIENT NAME" />
                                    <asp:BoundField DataField="position" HeaderText="POSITION">
                                        <ItemStyle HorizontalAlign="Left" Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="bankName" HeaderText="BANK NAME" />
                                    <asp:BoundField DataField="bankLocation" HeaderText="BANK LOCATION" />
                                    <asp:BoundField DataField="account_name" HeaderText="ACCOUNT NAME" />
                                    <asp:BoundField DataField="account_number" HeaderText="ACCOUNT NUMBER" />
                                    <asp:BoundField DataField="npwp" HeaderText="NPWP" />
                                    <asp:BoundField DataField="Tax_type_code" HeaderText="TAX" />
                                    <asp:BoundField DataField="RecipientAmount" HeaderText="AMOUNT" />
                                    <asp:BoundField DataField="TaxAmount" HeaderText="TAX AMOUNT" />
                                    <asp:BoundField DataField="NetAmount" HeaderText="NET AMOUNT" />
                                    <asp:CommandField HeaderText="ACTION" ShowEditButton="True">
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDetail" runat="server" Visible="False">
                        <uc4:ctrlCashRewardRecipient id="CtrlCashRewardRecipient" runat="server" OnAddClicked="Add_Clicked" OnSaveClicked="Save_Clicked">
                        </uc4:ctrlCashRewardRecipient>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
