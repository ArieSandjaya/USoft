<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashRewardPerAppl.aspx.cs" Inherits="USoft.Modules.Marketing.CashReward.CashRewardPerAppl" %>

<%@ Register Src="../../../Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc3" %>

<%@ Register Src="../../../Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc2" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
                    <uc3:ctrlSearch ID="ucSearch" runat="server" />
                    <div class="form_table_btn">
                        <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                    </div></td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvInsentif" runat="server" AutoGenerateColumns="False" EmptyDataText="No Data Available"
                                Font-Size="8pt" Style="width: 100%" OnRowCommand="gvInsentif_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="contract_number" HeaderText="CONTRACT NUMBER" />
                                    <asp:BoundField DataField="customername" HeaderText="CUSTOMER NAME">
                                        <ItemStyle HorizontalAlign="Left" Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SUPPLIER_NAME" HeaderText="SUPPLIER NAME" />
                                    <asp:BoundField DataField="BRAND_NAME" HeaderText="BRAND" />
                                    <asp:BoundField DataField="ELIGIBLE" HeaderText="ELIGIBLE" />
                                    <asp:CommandField HeaderText="ACTION" ShowEditButton="True">
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:CommandField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                            <uc2:ctrlgridpager id="ucGridPager" runat="server" onpagerclicked="PagerClick"></uc2:ctrlgridpager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
