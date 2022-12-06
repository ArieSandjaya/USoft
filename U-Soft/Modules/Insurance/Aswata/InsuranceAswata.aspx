<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsuranceAswata.aspx.cs" Inherits="USoft.Insurance.Aswata.InsuranceAswata" %>
<%@ Register Src="../../../Controls/ctrlErrorMessage.ascx" TagName="ctrlErrorMessage" TagPrefix="uc3" %>
<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc2" %>
<%@ Register Src="../../../Controls/ctrlDatetimeRange.ascx" TagName="ctrlDatetimeRange" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Aswata Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script language="javascript">$(document).ready(function() {$('#btnSearch').click(function(){window.parent.parent.loadWait();});});</script>
    <script type="text/javascript">function ClickConvert(){$("#btnHide").click();}</script>
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
                        <uc1:ctrlDatetimeRange ID="CtrlDatetimeRange1" runat="server" EnableViewState="true" />
                    </td>
                </tr>
                <tr class="T19">
                    <td style="text-align: center;"><asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" CssClass="ui-button ui-state-default" /></td>
                </tr>
            </table>
                </td>
            </tr>
            <tr class="T19">
                <td>
                        <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional"  >
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
                                        <asp:BoundField DataField="commence_date" HeaderText="Commence Date" />
                                        <asp:BoundField DataField="ContractNo" HeaderText="Contract No" />
                                        <asp:BoundField DataField="customer_name" HeaderText="Cust Name" />
                                        <asp:BoundField DataField="full_address" HeaderText="Address" />
                                        <asp:BoundField DataField="BPKB_name" HeaderText="BPKB Name" />
                                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                                        <asp:BoundField DataField="EndDate" HeaderText="End Date" />
                                        <asp:BoundField DataField="usage" HeaderText="Usage" />
                                        <asp:BoundField DataField="Brand" HeaderText="Brand" />
                                        <asp:BoundField DataField="type_mobil" HeaderText="Type Mobil" />
                                        <asp:BoundField DataField="category" HeaderText="Category" />
                                        <asp:BoundField DataField="thnbuat" HeaderText="Tahun" />
                                        <asp:BoundField DataField="warna_Kendaraan" HeaderText="Warna" />
                                        <asp:BoundField DataField="no_polisi" HeaderText="No Pol" />
                                        <asp:BoundField DataField="no_rangka_kendaraan" HeaderText="No Rangka" />
                                        <asp:BoundField DataField="no_mesin_kendaraan" HeaderText="No Mesin" />
                                        <asp:BoundField DataField="accesories" HeaderText="Accesories" />
                                        <asp:BoundField DataField="Tahun_I" DataFormatString="{0:n}" HeaderText="Tahun(I)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="coverage_I" HeaderText="Coverage(I)" />
                                        <asp:BoundField DataField="tjhth1" DataFormatString="{0:n}" HeaderText="TJH(I)" HtmlEncode="False" />
                                        <asp:BoundField DataField="RSCC1" HeaderText="RSCC(I)" />
                                        <asp:BoundField DataField="RSMD1" HeaderText="RSMD(I)" />
                                        <asp:BoundField DataField="AOG1" HeaderText="AOG(I)" />
                                        <asp:BoundField DataField="Flood1" HeaderText="Flood(I)" />
                                        <asp:BoundField DataField="EarthQuake1" HeaderText="Earth Quake(I)" />
                                        <asp:BoundField DataField="Tahun_II" DataFormatString="{0:n}" HeaderText="Tahun(II)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="coverage_II" HeaderText="Coverage(II)" />
                                        <asp:BoundField DataField="tjhth2" DataFormatString="{0:n}" HeaderText="TJH(II)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="RSCC2" HeaderText="RSCC(II)" />
                                        <asp:BoundField DataField="RSMD2" HeaderText="RSMD(II)" />
                                        <asp:BoundField DataField="AOG2" HeaderText="AOG(II)" />
                                        <asp:BoundField DataField="Flood2" HeaderText="Flood(II)" />
                                        <asp:BoundField DataField="EarthQuake2" HeaderText="Earth Quake(II)" />
                                        <asp:BoundField DataField="Tahun_III" DataFormatString="{0:n}" HeaderText="Tahun(III)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="coverage_III" HeaderText="Coverage(III)" />
                                        <asp:BoundField DataField="tjhth3" DataFormatString="{0:n}" HeaderText="TJH(III)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="RSCC3" HeaderText="RSCC(III)" />
                                        <asp:BoundField DataField="RSMD3" HeaderText="RSMD(III)" />
                                        <asp:BoundField DataField="AOG3" HeaderText="AOG(III)" />
                                        <asp:BoundField DataField="Flood3" HeaderText="Flood(III)" />
                                        <asp:BoundField DataField="EarthQuake3" HeaderText="Earth Quake(III)" />
                                        <asp:BoundField DataField="Tahun_IV" DataFormatString="{0:n}" HeaderText="Tahun(IV)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="coverage_IV" HeaderText="Coverage(IV)" />
                                        <asp:BoundField DataField="tjhth4" DataFormatString="{0:n}" HeaderText="TJH(IV)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="RSCC4" HeaderText="RSCC(IV)" />
                                        <asp:BoundField DataField="RSMD4" HeaderText="RSMD(IV)" />
                                        <asp:BoundField DataField="AOG4" HeaderText="AOG(IV)" />
                                        <asp:BoundField DataField="Flood4" HeaderText="Flood(IV)" />
                                        <asp:BoundField DataField="EarthQuake4" HeaderText="Earth Quake(IV)" />
                                        <asp:BoundField DataField="Tahun_V" DataFormatString="{0:n}" HeaderText="Tahun(V)"
                                            HtmlEncode="False" />
                                        <asp:BoundField DataField="coverage_V" HeaderText="Coverage(V)" />
                                        <asp:BoundField DataField="tjhth5" DataFormatString="{0:n}" HeaderText="TJH(V)" HtmlEncode="False" />
                                        <asp:BoundField DataField="RSCC5" HeaderText="RSCC(V)" />
                                        <asp:BoundField DataField="RSMD5" HeaderText="RSMD(V)" />
                                        <asp:BoundField DataField="AOG5" HeaderText="AOG(V)" />
                                        <asp:BoundField DataField="Flood5" HeaderText="Flood(V)" />
                                        <asp:BoundField DataField="EarthQuake5" HeaderText="Earth Quake(V)" />
                                    </Columns>
                                    <HeaderStyle CssClass="ui-widget-header" />
                                </asp:GridView>
                                <asp:Button ID="btnConvert" runat="server" Text="Convert" Visible="false" CssClass="ui-button ui-state-default" OnClientClick="ClickConvert();"/>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                </td>
            </tr>
            <tr class="T19">
                <td>
                    <asp:Button ID="btnHide" runat="server" Text="" CssClass="hide" OnClick="btnConvert_Click" />
                </td>
            </tr>
        </table>
        
    </form>
</body>
</html>

