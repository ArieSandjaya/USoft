<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdmSearchContract.aspx.cs" Inherits="USoft.Modules.Marketing.AdmSearchContract" %>

<%@ Register Src="../../../Controls/ctrlPager.ascx" TagName="ctrlPager" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Admin Fee Search Contract Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="100%">
        <tr>
            <td class="ui-widget-content">
                <uc2:ctrlFormHeader ID="ucHeaderPage" runat="server" />
            </td>
        </tr>
    
        <tr >
        <td class="ui-widget-content">
            <table class="T01" cellSpacing="0" cellPadding="0" border="0">
                <tr >
                    <td >
                        <table id="tb_SearchContract" cellSpacing="0" cellPadding="0" border="0" width="100%">
				            <tr>
				            <td class="ui-widget-content" colSpan="2">
				            <table class="T03" cellSpacing="1">
				                <tr>
				                    <td class="T17">
                                        <asp:Label ID="lblContractNo" runat="server" Text="Contract Number"></asp:Label></td>
				                    <td class="T19"><asp:TextBox ID="txtContractNo" runat="server"></asp:TextBox></td>
				                </tr>
				                <tr>
				                    <td colspan="2" class="T19" align="right">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="ui-button ui-state-default" OnClick="btnSearch_Click" /></td>
				                </tr>
				            </table>
				            </td>
				            </tr>
				            <tr>
						        <td>&nbsp;</td>
						    </tr>
						    <tr>
                                <td>
                                    <table class="T10" id="tb_Result" cellSpacing="0" runat="server">
									    <tr class="T26">
									        <td class="T14" colSpan="2">
                                                <asp:GridView ID="gvContract" runat="server" AutoGenerateColumns="False" Width="100%" PageSize="50" OnDataBound="gvContract_DataBound" OnRowDataBound="gvContract_RowDataBound" OnRowEditing="gvContract_RowEditing">
                                                    <Columns>
                                                        <asp:BoundField DataField="Contract_Number" HeaderText="Contract Number" >
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="Customer Name" DataField="Name" >
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Asset_cost_amount" HeaderText="Asset Cost Amount" DataFormatString="{0:N}" HtmlEncode="False" >
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="contract_term" HeaderText="Period Insured" >
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="input" HeaderText="input">
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PAID" HeaderText="Paid">
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField>
                                                            <EditItemTemplate>
                                                                <asp:Button ID="btnUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                                                    Text="Update" />
                                                                    <asp:Button ID="btnCancel" runat="server" CausesValidation="False"
                                                                        CommandName="Cancel" Text="Cancel" />
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnInsert" runat="server" CausesValidation="True" CommandName="Edit"
                                                                    Text="Insert" OnClick="btnInsert_Click" EnableViewState="True" style="cursor: hand;" CssClass="B01" />
                                                                <asp:Button ID="btnDelete" runat="server"
                                                                    Text="Delete" CausesValidation="False" CommandName="Delete" EnableViewState="True" CssClass="B01" OnClick="btnDelete_Click" />
                                                                    <asp:Button ID="btnSelect" runat="server" CausesValidation="False"
                                                                        CommandName="Select" Text="View" OnClick="btnSelect_Click" EnableViewState="True" style="cursor: hand;" CssClass="B01" />
                                                            </ItemTemplate>
                                                            <ControlStyle Font-Bold="True" Font-Size="Smaller" />
                                                            <HeaderTemplate>
                                                                Action
                                                            </HeaderTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="Tan" />
                                                    <PagerStyle BackColor="#5C9CCC" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                                    <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                                    <HeaderStyle BackColor="Tan" CssClass="ui-widget-header" Font-Bold="True" />
                                                    <AlternatingRowStyle BackColor="White" />
                                                    <PagerSettings Position="TopAndBottom" Mode="NextPrevious" />
                                                </asp:GridView>
										    </td>
									    </tr>
								    </table>
                                    <uc1:ctrlPager ID="CtrlPager1" runat="server" OnNextClicked="NextPager" OnPrevClicked="PrevPager"/>
							    </td>
						    </tr>
                        </table>
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
