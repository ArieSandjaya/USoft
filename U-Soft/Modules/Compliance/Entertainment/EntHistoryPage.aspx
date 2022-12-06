<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntHistoryPage.aspx.cs" Inherits="USoft.Modules.Compliance.Entertainment.EntHistoryPage" %>
<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Entertainment History Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/validationEngine.jquery.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript">
        $(function() {
            $("#dtpickerFrom").datepicker({dateFormat: "d-M-yy"});
		    $("#dtpickerTo").datepicker({dateFormat: "d-M-yy"}); 	
	        });
	    function ValidatePage() 
	        {
	            CheckSession();
	            return $('#EntHistoryPage').validationEngine('validate');
            }; 
    </script>
</head>
<body>
    <form id="EntHistoryPage" runat="server">
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
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:CheckBox ID="chkEvents" runat="server" Checked="True" /></td>
                            <td style="width: 100px">
                                <asp:Label ID="Label2" runat="server" Text="Events Date from"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:TextBox ID="dtpickerFrom" runat="server" Font-Size="8pt"
                                    Style="font-family: Lucida Grande, Lucida Sans, Arial, sans-serif"
                                    Width="116px" CssClass="validate[condRequired[chkEvents]] text-input datepicker" ></asp:TextBox></td>
                            <td style="width: 19px">
                                <asp:Label ID="Label4" runat="server" Text="To"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:TextBox ID="dtpickerTo" runat="server" Font-Size="8pt"
                                    Style="font-family: Lucida Grande, Lucida Sans, Arial, sans-serif" Width="116px" CssClass="validate[condRequired[chkEvents]] text-input datepicker"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:CheckBox ID="chkSequence" runat="server" /></td>
                            <td style="width: 100px">
                                <asp:Label ID="Label3" runat="server" Text="Sequence Number" Width="111px"></asp:Label></td>
                            <td colspan="3">
                                <asp:TextBox ID="txtSeq" runat="server" Font-Size="8pt" Style="font-size: 0.9em;
                                    cursor: hand; font-family: Lucida Grande, Lucida Sans, Arial, sans-serif" Width="266px" CssClass="validate[condRequired[chkSequence]]"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 100px">
                                <asp:Button ID="btnSearch" runat="server" CssClass="ui-state-hover"
                                    Text="Search" OnClick="btnSearch_Click" OnClientClick="javascript:return ValidatePage();" /></td>
                            <td style="width: 19px">
                            </td>
                            <td style="width: 100px">
                            </td>
                        </tr>
                    </table>
                    <div>
                        <span style="font-size: 10pt">
                            <asp:UpdatePanel ID="updApp" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView ID="gvHistory" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellPadding="0" Font-Size="8pt" PageSize="20" ShowFooter="True"
                                        Width="100%" OnRowEditing="gvHistory_RowEditing" OnRowCommand="gvHistory_RowCommand" OnRowDataBound="gvHistory_RowDataBound" OnPageIndexChanging="gvHistory_PageIndexChanging" OnSelectedIndexChanging="gvHistory_SelectedIndexChanging">
                                        <Columns>
                                            <asp:BoundField DataField="KeyId" HeaderText="KeyId">
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="labelNo" HeaderText="No" />
                                            <asp:BoundField DataField="CreateDate" DataFormatString="{0:dd-MMM-yyyy} " HeaderText="Create Date"
                                                HtmlEncode="False">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ResId" HeaderText="Seq No">
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ApplName" HeaderText="Appl Name">
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Branch" HeaderText="Branch">
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Datetime" DataFormatString="{0:dd-MMM-yyyy} " HeaderText="Event Date"
                                                HtmlEncode="False">
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EventItems" HeaderText="Events">
                                                <ControlStyle CssClass="hide" />
                                                <FooterStyle CssClass="hide" />
                                                <HeaderStyle CssClass="hide" />
                                                <ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CountpartyName" HeaderText="Counterparty Name">
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EstimatedBgt" DataFormatString="{0:n0}" HeaderText="Estimate"
                                                HtmlEncode="False">
                                                <ItemStyle HorizontalAlign="Right" Width="10px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TotalAmount" DataFormatString="{0:n0}" HeaderText="Total"
                                                HtmlEncode="False">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Status" HeaderText="Status">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:TemplateField ShowHeader="False">
                                                <EditItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                        Text="Update"></asp:LinkButton>
                                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancel"></asp:LinkButton>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <table style="text-align: right">
                                                        <tr>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton ID="lbEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                                    Text="Edit"></asp:LinkButton></td>
                                                            <td>
                                                                    <asp:LinkButton ID="lbCancel" runat="server" CausesValidation="False" CommandName="Delete"
                                                                        Text="Cancel" Visible="False"></asp:LinkButton></td>
                                                            <td>
                                                                <asp:LinkButton ID="lbPrint" runat="server" CausesValidation="False" CommandName="Select"
                                                                 Text="Print"></asp:LinkButton></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="ui-widget-header" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle CssClass="ui-widget-header" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <PagerSettings PageButtonCount="12" />
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </span>&nbsp;</div>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
