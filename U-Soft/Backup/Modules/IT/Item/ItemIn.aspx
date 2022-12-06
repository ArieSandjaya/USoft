<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemIn.aspx.cs" Inherits="USoft.Modules.IT.Item.ItemIn" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlSearch.ascx" TagName="ctrlSearch" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlGridPager.ascx" TagName="ctrlGridPager" TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Item-In</title>
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.css" />
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/ui-layout.css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../../Javascript/date.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $(function() { $("#txtDateIn").datepicker({dateFormat: "yy-mm-dd"}); });
        });
            
		function getDate(dateValue){
            var DateValue=new Date(dateValue);
            var DateNw=new Date();
            var DateNow=DateNw.getFullYear()+"/"+(DateNw.getMonth()+1)+"/"+DateNw.getDate();
		    if(DateValue<DateNow){alert('oi');}
		}
	</script>
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
                    <uc2:ctrlSearch ID="ucSearch" runat="server" />
                    <table style="width: 100%" cellspacing="1" cellpadding="0" border="0">
                        <tr>
                            <td class="form_table_title">Date in</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:TextBox ID="txtDateIn" runat="server" onChange="getDate(this.value);" Width="94px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="form_table_title" style="width: 120px;">Receive From</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFReceiveType" runat="server" >
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="Branch">Branch</asp:ListItem>
                                    <asp:ListItem Value="Vendor">Vendor</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Branch</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFBranch" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Vendor</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFSupplier" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">PIC</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table"><asp:DropDownList ID="ddlFPIC" runat="server" ></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="form_table_title">Doc Status</td>
                            <td class="form_table_sepp">:</td>
                            <td class="form_table">
                                <asp:DropDownList ID="ddlFDocStatus" runat="server" >
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="D">Draft</asp:ListItem>
                                    <asp:ListItem Value="R">RFA</asp:ListItem>
                                    <asp:ListItem Value="A">Approve</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td class="form_table_btn">
                                <asp:ImageButton ID="imbSearch" runat="server" ImageUrl="~/Images/BtnSearch.png" OnClick="imbSearch_Click" />
                                <asp:ImageButton ID="imbCreate" runat="server" ImageUrl="~/Images/BtnCreate.png" OnClick="imbCreate_Click"  />
                            </td>
                        </tr>
                    </table>
                </td>
             </tr>
             <tr>
                <td>
                    <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvItemIn" runat="server" AutoGenerateColumns="False"
                                 Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" 
                                 OnRowDataBound="gvItemIn_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="ITItemInCode" HeaderText="ITEM-IN CODE" >
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="Date" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="DATE IN" >
                                        <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="ReceiveType" HeaderText="RECEIVE FROM" >
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                        </asp:BoundField>    
                                    <asp:BoundField DataField="BranchName" HeaderText="BRANCH" >
                                        </asp:BoundField>
                                    <asp:BoundField DataField="SupplierName" HeaderText="VENDOR" >
                                        </asp:BoundField>
                                    <asp:BoundField DataField="createdName" HeaderText="PIC" >
                                        <ItemStyle Width="150px" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="Status" HeaderText="Status" >
                                        <ItemStyle HorizontalAlign="Center" Width="100px"  />
                                        </asp:BoundField>
                                    <asp:TemplateField HeaderText="ACTION">
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                        </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                                <AlternatingRowStyle BackColor="Gainsboro" />
                            </asp:GridView>
                            <uc3:ctrlGridPager ID="ucGridPager" runat="server" OnPagerClicked="PagerClick" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="imbSearch" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>