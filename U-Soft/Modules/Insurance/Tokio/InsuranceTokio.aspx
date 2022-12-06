<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsuranceTokio.aspx.cs" Inherits="USoft.Insurance.Tokio.InsuranceTokio" %>
<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"TagPrefix="uc2" %>
<%@ Register Src="../../../Controls/ctrlDatetimeRange.ascx" TagName="ctrlDatetimeRange"TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Tokio Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script language="javascript">$(document).ready(function() {$('#btnSearch').click(function(){window.parent.parent.loadWait();});});</script>
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
                    <uc2:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <uc1:ctrlDatetimeRange ID="CtrlDatetimeRange1" runat="server" />
                            </td>
                        </tr>
                        <tr  class="T19">
                            <td style="text-align: center">
                                <asp:Button ID="btnSearch" runat="server" CssClass="ui-button ui-state-default" OnClick="btnSearch_Click"
                                    Text="Search" style="top: 1px" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="T19">
                <td>
                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                        <asp:GridView ID="gvTokio" runat="server" AutoGenerateColumns="False" EnableTheming="False">
                        <Columns>
                           <asp:TemplateField HeaderText="No">
                            <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                        </EditItemTemplate>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="name" HeaderText="Insured" />
                            <asp:BoundField DataField="address" HeaderText="Address" />
                            <asp:BoundField DataField="period_from" HeaderText="From" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="False" />
                            <asp:BoundField DataField="period_to" HeaderText="To" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="False" />
                            <asp:BoundField DataField="period_from" HeaderText="Effective" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="False"  />
                            <asp:BoundField DataField="coverage_all" HeaderText="Coverage Name" />
                            <asp:BoundField DataField="type" HeaderText="Type" />
                            <asp:BoundField DataField="production_year" HeaderText="Mnfg Year" />
                            <asp:BoundField DataField="Make" HeaderText="Make" />
                            <asp:BoundField DataField="merk" HeaderText="Merk" />
                            <asp:BoundField DataField="model" HeaderText="Model" />
                            <asp:BoundField DataField="license" HeaderText="License" />
                            <asp:BoundField DataField="chasis_number" HeaderText="Chasis Number" />
                            <asp:BoundField DataField="engine_number" HeaderText="Engine Number" />
                            <asp:BoundField DataField="usage" HeaderText="Usage" />
                            <asp:BoundField DataField="colour" HeaderText="Colour" />
                            <asp:BoundField DataField="discount_rate_to_company" HeaderText="Discount(%)" />
                            <asp:BoundField DataField="sum_insured" HeaderText="Sum Insured" DataFormatString="{0:n}"/>
                            <asp:BoundField DataField="TPL" HeaderText="TPL" DataFormatString="{0:n}" />
                            <asp:BoundField DataField="Earthquake" HeaderText="Earthquake" />
                            <asp:BoundField DataField="Flood" HeaderText="Flood" />
                            <asp:BoundField DataField="srcc" HeaderText="Srcc" />
                            <asp:BoundField DataField="pass" HeaderText="Pass" />
                            <asp:BoundField DataField="drvr" HeaderText="Drvr" />
                            <asp:BoundField DataField="Flag" HeaderText="Flag" />
                            <asp:BoundField DataField="Acc" HeaderText="Acc" />
                        </Columns>
                            <HeaderStyle CssClass="ui-widget-header" />
                    </asp:GridView>
                        <asp:Button ID="btnConvert" runat="server" CssClass="ui-button ui-state-default"
                        OnClick="btnConvert_Click" Text="Convert" Visible="false" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </td>
            </tr>
            <tr class="T19">
                <td>
                    
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
