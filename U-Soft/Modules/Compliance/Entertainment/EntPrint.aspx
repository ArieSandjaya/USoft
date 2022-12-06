<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntPrint.aspx.cs" Inherits="USoft.Modules.Compliance.Entertainment.EntPrint" %>

<%@ Register Src="../../../Controls/ctrlPager.ascx" TagName="ctrlPager" TagPrefix="uc2" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Entertainment Print Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/validationEngine.jquery.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript">
       $(function() {
		$("#dtpickerFrom").datepicker({dateFormat: "dd-M-yy"});
		$("#dtpickerTo").datepicker({dateFormat: "dd-M-yy"});
	});
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td class="ui-widget-content">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <div>
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 78px">
                                    Date From :</td>
                                <td style="width: 177px">
                                    <asp:TextBox ID="dtpickerFrom" runat="server" CssClass="watermarkOn" Font-Size="8pt"
                                        Style="font-size: 0.9em; cursor: hand; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="171px"></asp:TextBox></td>
                                <td style="width: 15px">
                                    To</td>
                                <td>
                                    <asp:TextBox ID="dtpickerTo" runat="server" CssClass="watermarkOn" Font-Size="8pt"
                                        Style="font-size: 0.9em; cursor: hand; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                        Width="171px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 78px">
                                    Branch</td>
                                <td style="width: 177px">
                                    <asp:DropDownList ID="ddlBranch" runat="server" CssClass="ui-widget-text" Style="font-size: 0.9em"
                                        Width="177px">
                                    </asp:DropDownList></td>
                                <td style="width: 15px">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 78px">
                                    Status</td>
                                <td style="width: 177px">
                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="ui-widget-text" Style="font-size: 0.9em"
                                        Width="177px">
                                        <asp:ListItem>All</asp:ListItem>
                                        <asp:ListItem>Approved</asp:ListItem>
                                        <asp:ListItem>Rejected</asp:ListItem>
                                        <asp:ListItem>Cancel</asp:ListItem>
                                        <asp:ListItem>Open</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="width: 15px">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 78px">
                                </td>
                                <td style="width: 177px"><asp:UpdatePanel ID="updSearch" runat="server">
                                    <ContentTemplate>
                                    <asp:Button ID="btnSearch" runat="server" CssClass="ui-state-hover" OnClick="btnSearch_Click"
                                        Style="cursor: hand" Text="Search" Width="61px" />
                                    <asp:Button ID="btnPrint" runat="server" CssClass="ui-state-hover" OnClick="btnPrint_Click"
                                        Style="cursor: hand" Text="Print" Width="61px" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                </td>
                                <td style="width: 15px">
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                    <asp:GridView ID="gvPrint" runat="server" AutoGenerateColumns="False"
                        CellPadding="4" Font-Size="X-Small" ForeColor="#333333" GridLines="None" OnPageIndexChanging="gvPrint_PageIndexChanging"
                        OnSelectedIndexChanging="gvPrint_SelectedIndexChanging" PageSize="20" ShowFooter="True"
                        Style="width: 100%">
                        <FooterStyle BackColor="#507CD1" CssClass="ui-widget-header" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#507CD1" CssClass="ui-widget-header" Font-Bold="True" ForeColor="White" />
                        <EditRowStyle BackColor="#2461BF" />
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="labelNo" HeaderText="No." />
                            <asp:BoundField DataField="Create_Date" DataFormatString="{0:dd-MM-yyyy} " HeaderText="Create Date" />
                            <asp:BoundField DataField="resid" HeaderText="SequenceNo" />
                            <asp:BoundField DataField="ApplName" HeaderText="ApplicantName" />
                            <asp:BoundField DataField="Branch" HeaderText="Branch" />
                            <asp:BoundField DataField="EventItems" HeaderText="Events" />
                            <asp:BoundField DataField="CountpartyName" HeaderText="CounterpartyName" />
                            <asp:BoundField DataField="EstimatedBgt" DataFormatString="{0:n}" HeaderText="Estimate" />
                            <asp:BoundField DataField="TotalAmount" DataFormatString="{0:n}" HeaderText="TotalAmount" />
                            <asp:BoundField DataField="AcceptanceOffer" HeaderText="EntertainType" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:CommandField EditText="PRINT" />
                        </Columns>
                    </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <asp:UpdatePanel ID="updPaging" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                    <uc2:ctrlPager ID="CtrlPager" runat="server" OnNextClicked="NextPager" OnPrevClicked="PrevPager"/>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
