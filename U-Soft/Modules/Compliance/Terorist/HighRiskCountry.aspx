<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HighRiskCountry.aspx.cs" Inherits="USoft.Modules.Compliance.Terorist.HighRiskCountry" %>
<%@ Register Src="../../../Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc3" %>

<%@ Register Src="../../../Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc2" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>AML ATLAS / High Risk Country</title>
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
            <div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </div>
            <table style="width: 100%">
                <tr>
                    <td class="ui-widget-content">
                        <uc1:ctrlformheader id="ucHeaderPage" runat="server"></uc1:ctrlformheader>
                    </td>
                </tr>
                <tr>
                    <td class="ui-widget-content">
                        <uc3:ctrlsearch id="ucSearch" runat="server"></uc3:ctrlsearch>
                        <div class="form_table_btn">
                            <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png"
                                OnClick="imbSearch_Click" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="ui-widget-content">
                        <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="gvInsentif" runat="server" AutoGenerateColumns="False" EmptyDataText="No Data Available"
                                    Font-Size="8pt" OnRowCommand="gvInsentif_RowCommand" Style="width: 100%">
                                    <Columns>
                                        <asp:BoundField DataField="NO" HeaderText="No" ReadOnly="True">
                                            <ItemStyle HorizontalAlign="Center" Width="70px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="COUNTRY_NAME" HeaderText="Country Name" />
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
    
    </div>
    </form>
</body>
</html>
