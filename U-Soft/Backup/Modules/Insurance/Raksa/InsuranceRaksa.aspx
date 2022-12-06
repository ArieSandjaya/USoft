<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsuranceRaksa.aspx.cs" Inherits="USoft.Insurance.Raksa.InsuranceRaksa" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc2" %>

<%@ Register Src="../../../Controls/ctrlDatetimeRange.ascx" TagName="ctrlDatetimeRange"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Raksa Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script language="javascript">$(document).ready(function() {$('#btnSearch').click(function(){window.parent.parent.loadWait();});});</script>
    <script type="text/javascript">
        function ClickConvert()
        { $("#btnHide").click();}
    </script>
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
                        <tr class="T19">
                            <td style="text-align: center">
                                <asp:Button ID="btnSearch" runat="server" CssClass="ui-button ui-state-default" OnClick="btnSearch_Click"
                                    Text="Search" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="T19">
                <td>
                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvAswata" runat="server" AutoGenerateColumns="False" Style="width: 100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="No">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="NoContract" HeaderText="Contract No" />
                                    <asp:BoundField DataField="Cabang" HeaderText="Branch" />
                                    <asp:BoundField DataField="NamaTertanggung" HeaderText="Cust Name" />
                                    <asp:BoundField DataField="vehicle_name" HeaderText="Vehicle Name" />
                                    <asp:BoundField DataField="VehicleEngineNo" HeaderText="Engine No" />
                                    <asp:BoundField DataField="VehicleChasisNo" HeaderText="Chassis No" />
                                    <asp:BoundField DataField="VehicleYear" HeaderText="Year" />
                                    <asp:BoundField DataField="VehicleColor" HeaderText="Color" />
                                    <asp:BoundField DataField="NoPolisi" HeaderText="Registration No" />
                                    <asp:BoundField DataField="PeriodeAwal" HeaderText="Periode From" />
                                    <asp:BoundField DataField="PeriodeAkhir" HeaderText="Periode To" />
                                    <asp:BoundField DataField="JenisPeranggungan" HeaderText="Coverage Name" />
                                    <asp:BoundField DataField="Currency" HeaderText="Ccy" />
                                    <asp:BoundField DataField="SumInsured" HeaderText="Ins Total" DataFormatString="{0:n}" HtmlEncode="False" />
                                    <asp:BoundField DataField="rate" HeaderText="Rate" />
                                    <asp:BoundField DataField="resiko" HeaderText="Risk" DataFormatString="{0:n}" />
                                    <asp:BoundField DataField="Premi" DataFormatString="{0:n}" HeaderText="Premi"
                                        HtmlEncode="False" />
                                    <asp:BoundField DataField="accesories" HeaderText="Accesories" />
                                    <asp:BoundField DataField="CmoName" HeaderText="CMO" HtmlEncode="False" />
                                </Columns>
                                <HeaderStyle CssClass="ui-widget-header" />
                            </asp:GridView>
                            <asp:Button ID="btnConvert" runat="server" CssClass="ui-button ui-state-default" Text="Convert" Visible="False" OnClientClick="ClickConvert();" />
                        </ContentTemplate>
                    </asp:UpdatePanel>

            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Button ID="btnHide" runat="server" CssClass="hide" OnClick="btnConvert_Click" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
