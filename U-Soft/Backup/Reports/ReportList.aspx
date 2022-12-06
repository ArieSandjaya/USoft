<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportList.aspx.cs" Inherits="USoft.Reports.ReportList" %>

<%@ Register Src="../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Reports Page</title>
    <link rel="stylesheet" type="text/css" href="../CSS/black-tie/jquery-ui-1.9.2.custom.min.css"/>
    <link rel="stylesheet" type="text/css" href="../CSS/black-tie/ui-layout.css"/>
</head>
<body>
    <form id="form1" runat="server">
    <div><uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" /></div>
    <div>
        <asp:GridView ID="gViewLists" runat="server" AutoGenerateColumns="False" BorderStyle="Solid" GridLines="None" ShowHeader="False" Width="100%" OnRowCommand="gViewLists_RowCommand" BorderColor="#D2E0EA" BorderWidth="1px">
            <Columns>
                <asp:BoundField DataField="Report_Code" HeaderText="Report Code" >
                    <ItemStyle Width="50px" CssClass="T17"/>
                </asp:BoundField>
                <asp:BoundField DataField="Report_Name" HeaderText="Report Name" >
                    <ItemStyle CssClass="T17" />
                </asp:BoundField>
                <asp:BoundField DataField="Report_File_Name" HeaderText="Report_File_Name" >
                    <ControlStyle CssClass="hide" />
                    <FooterStyle CssClass="hide" />
                    <HeaderStyle CssClass="hide" />
                    <ItemStyle CssClass="hide" />
                </asp:BoundField>
                <asp:BoundField DataField="Report_Parameter" HeaderText="Report_Parameter" >
                    <ControlStyle CssClass="hide" />
                    <FooterStyle CssClass="hide" />
                    <HeaderStyle CssClass="hide" />
                    <ItemStyle CssClass="hide" />
                </asp:BoundField>
                <asp:BoundField DataField="Report_Parameter_Type" HeaderText="Report_Parameter_Type" >
                    <ControlStyle CssClass="hide" />
                    <FooterStyle CssClass="hide" />
                    <HeaderStyle CssClass="hide" />
                    <ItemStyle CssClass="hide" />
                </asp:BoundField>
                <asp:BoundField DataField="Report_Parameter_Component" HeaderText="Report_Parameter_Component" >
                    <ControlStyle CssClass="hide" />
                    <FooterStyle CssClass="hide" />
                    <HeaderStyle CssClass="hide" />
                    <ItemStyle CssClass="hide" />
                </asp:BoundField>
                <asp:CommandField ButtonType="Button" ShowSelectButton="True" >
                    <ControlStyle CssClass="ui-button ui-state-default" />
                    <ItemStyle CssClass="T19" HorizontalAlign="Right" />
                </asp:CommandField>
            </Columns>
            <AlternatingRowStyle BackColor="#D2E0EA" />
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
