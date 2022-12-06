<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TerorisAdd.aspx.cs" Inherits="USoft.Modules.Compliance.TerorisAdd" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New Sanction Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() 
        {$('#btnProcess').click(function(){window.parent.parent.loadWait();});
															    $('#btnSave').click(function(){window.parent.parent.loadWait();});
																$('#btnExcell').click(function(){$("#trExcell").attr("class","show");$("#trManual").attr("class","hide");});
																$('#btnManual').click(function(){$("#trManual").attr("class","show");$("#trExcell").attr("class","hide");});
																$("#txtAddress").resizable({handles: "se"});
																$("#txtOther").resizable({handles: "se"});
																});
    </script>
     <style>
        .ui-resizable-se {bottom: 17px;}
    </style>
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
                <td class="ui-widget-content" style="width: 100%">
                    <uc1:ctrlFormHeader ID="CtrlFormHeader1" runat="server" />
                </td>
            </tr>
            <tr class="T19">
                <td style="width: 100%">
                    <input id="btnExcell" type="button" value="Export From Excell" style="width: 168px" class="ui-button ui-state-default" />
            </tr>
            <tr id="trExcell" class="hide">
                <td style="width: 100px" class="ui-widget-content">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label1" runat="server" Text="Search File" Width="94px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:FileUpload ID="fuExcell" runat="server" Width="483px" CssClass="ui-button ui-state-default" /></td>
                        </tr>
                        <tr class="T19">
                            <td style="width: 81px">
                            </td>
                            <td style="width: 100px">
                                <asp:Button ID="btnProcess" runat="server" CssClass="ui-button ui-state-default"
                                    OnClick="btnProcess_Click" Text="Process" Width="80px" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="T19">
                <td style="width: 100px"><input id="btnManual" type="button" value="Manual Input" style="width: 168px" class="ui-button ui-state-default" /></td>
            </tr>
            <tr id="trManual" class="hide">
                <td style="width: 100px" class="ui-widget-content">
                    <table style="width: 391px; border-top-width: thin; border-left-width: thin; border-left-color: blue; border-bottom-width: thin; border-bottom-color: blue; border-top-color: blue; border-right-width: thin; border-right-color: blue;">
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label2" runat="server" Text="Name" Width="94px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:TextBox ID="txtName" runat="server" Width="276px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label3" runat="server" Text="Birthday" Width="94px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:TextBox ID="txtBirthday" runat="server" Width="276px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top">
                                <asp:Label ID="Label4" runat="server" Text="Address" Width="94px"></asp:Label></td>
                            <td><div style="width: 276px;">
                                <textarea id="txtAddress" cols="20" runat="server" style="width: 276px; overflow: auto; margin-bottom: 0px; padding-bottom: 0px; height: 85px;">
                                </textarea></div></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label5" runat="server" Text="Nationality" Width="94px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:TextBox ID="txtNationaly" runat="server" Width="276px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; vertical-align: top;">
                                <asp:Label ID="Label6" runat="server" Text="Other Info" Width="94px"></asp:Label></td>
                            <td style="width: 100px"><div style="width: 276px;">
                                <textarea id="txtOther" runat="server" cols="20" style="width: 276px; overflow: auto; height: 85px;"></textarea></div></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 100px">
                                <table>
                                    <tr class="T19">
                                        <td style="width: 100px"><asp:Button ID="btnSaveManual" runat="server" CssClass="ui-button ui-state-default" Text="Save" Width="80px" OnClick="btnSaveManual_Click"/></td>
                                        <td style="width: 100px"><asp:Button ID="btnReset" runat="server" CssClass="ui-button ui-state-default" Text="Reset" Width="80px"/></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
    </div>
        <asp:UpdatePanel ID="updTeroris" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 100px">
        <asp:GridView ID="gvTeroris" runat="server" AutoGenerateColumns="False" ShowFooter="True"
            Style="width: 100%">
            <Columns>
                <asp:BoundField DataField="ROW" HeaderText="No" />
                <asp:BoundField DataField="name" HeaderText="Name" />
                <asp:BoundField DataField="LAST_NAME" HeaderText="Last Name" />
                <asp:BoundField DataField="BIRTHDAYS" HeaderText="Birthday">
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="Address" HeaderText="Address" />
                <asp:BoundField DataField="Nationality" HeaderText="Nationality" />
                <asp:BoundField DataField="Other_Info" HeaderText="Other Info" />
            </Columns>
            <HeaderStyle CssClass="ui-widget-header" />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" Position="TopAndBottom" />
            <PagerStyle ForeColor="Blue" VerticalAlign="Middle" Wrap="False" />
            <FooterStyle CssClass="ui-widget-header" />
            <AlternatingRowStyle CssClass="ui-state-highlight" />
        </asp:GridView>
                        </td>
                    </tr>
                    <tr class="T19">
                        <td style="width: 100px">
                            <asp:Button ID="btnSave" runat="server" CssClass="ui-button ui-state-default" Text="Save" OnClick="btnSave_Click" Visible="False" Width="80px"/></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
