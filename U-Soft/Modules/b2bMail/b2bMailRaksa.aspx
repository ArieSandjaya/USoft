<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="b2bMailRaksa.aspx.cs" Inherits="USoft.Modules.b2bMail.b2bMailRaksa" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mail Page</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script language="javascript">
        $(document).ready(function() {
            $('#btnSend').click(function(){window.parent.parent.loadWait();});
        });
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
                <td class="ui-widget-content" >
                    <uc2:ctrlFormHeader ID="CtrlFormHeader" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="ui-widget-content">
                    <table>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Email To :</td>
                            <td style="width: 99px;">
                                <asp:DropDownList ID="dllEmailTo" runat="server" AutoPostBack="True" CausesValidation="True"
                                    OnSelectedIndexChanged="dllEmailTo_SelectedIndexChanged" OnTextChanged="dllEmailTo_TextChanged"
                                    Style="font-size: 0.9em" Width="128px">
                                    <asp:ListItem>Raksa</asp:ListItem>
                                    <asp:ListItem>Aswata</asp:ListItem>
                                    <asp:ListItem Value="TOKIO">Tokio Marine</asp:ListItem>
                                </asp:DropDownList></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                From :</td>
                            <td style="width: 99px;">
                                <asp:TextBox ID="txtSender" runat="server" BorderColor="#C0C0FF"
                                    BorderWidth="1px" Font-Names="Verdana" Font-Size="X-Small" Height="15px" ReadOnly="True"
                                    TabIndex="1" Width="670px"  ></asp:TextBox></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                To :</td>
                            <td style="width: 99px;">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" EnableViewState="False" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtReceiver" runat="server" BorderColor="#C0C0FF"
                                            BorderWidth="1px" Font-Names="Verdana" Font-Size="X-Small" Height="15px" ReadOnly="True"
                                            TabIndex="1" Width="670px"></asp:TextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="dllEmailTo" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Cc :</td>
                            <td style="width: 99px;">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" EnableViewState="False" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtCc" runat="server" BorderColor="#C0C0FF"
                                            BorderWidth="1px" Font-Names="Verdana" Font-Size="X-Small" Height="15px" ReadOnly="True"
                                            TabIndex="1" Width="670px"></asp:TextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="dllEmailTo" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Subject :</td>
                            <td style="width: 99px;">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtSubject" runat="server" BorderColor="#C0C0FF"
                                            BorderWidth="1px" Font-Names="Verdana" Font-Size="X-Small" Height="15px" ReadOnly="True"
                                            TabIndex="2" Width="670px">Aplikasi Asuransi</asp:TextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="dllEmailTo" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Format :</td>
                            <td style="width: 99px;">
                                <asp:RadioButtonList ID="rblMailFormat" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                                    Style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                                    padding-top: 0px" TabIndex="3">
                                    <asp:ListItem Selected="True" Value="Text">Text</asp:ListItem>
                                    <asp:ListItem Value="HTML">HTML</asp:ListItem>
                                </asp:RadioButtonList></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Attachment :</td>
                            <td style="width: 99px;">
                                <input id="inpAttachment1" runat="server" name="filMyFile" style="width: 673px" tabindex="5" type="file" /></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Attachment :</td>
                            <td style="width: 99px;">
                                <input id="inpAttachment2" runat="server" name="filMyFile" style="width: 673px;" tabindex="6" type="file" /></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Attachment :</td>
                            <td style="width: 99px;">
                                <input id="inpAttachment3" runat="server" name="filMyFile" style="width: 673px;" tabindex="7" type="file" /></td></tr>
                        <tr>
                            <td style="width: 100px; text-align: right">
                                Message :</td>
                            <td style="width: 99px">
                                <asp:TextBox ID="txtBody" runat="server" Columns="40" Font-Names="Verdana" Font-Size="X-Small"
                                    Height="185px" Rows="5" TabIndex="4" TextMode="MultiLine" Width="668px"></asp:TextBox></td></tr>
                        <tr class="T19">
                            <td align="center" colspan="2">
                                <asp:Button ID="btnSend" runat="server" OnClick="btnSend_Click" TabIndex="9" Text="Send"
                                    Width="100px" CssClass="ui-button ui-state-default" /></td></tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label></td></tr>
                    </table>
                </td>
            </tr>         
        </table>
        
    </form>
</body>
</html>