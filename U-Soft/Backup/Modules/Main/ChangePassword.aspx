<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="USoft.Modules.Main.ChangePassword" %>

<%@ Register Src="../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Change Password</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript">
    function cekPassword()
    {
        var UPass;var UType;var OldPass;var btSave;
        UPass = $("#txtPassword").val();
        UType = $("#txtReType").val();
        btnSave = $("#btnSave");
        if (UPass == UType && UType!="")
        {
            btnSave[0].className = "ui-button ui-state-default";
        }
        else
        {
            btnSave[0].className = "hide";
        }
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
            width: 100%; padding-top: 0px; text-align: right">
            <tr>
                <td colspan="9">
                    <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="T17">
                    <asp:Label ID="Label1" runat="server" Text="User Name"></asp:Label></td>
                <td class="T19" style="text-align: left"><asp:TextBox ID="txtUserName" runat="server" Enabled="False"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="T17">
                    <asp:Label ID="Label4" runat="server" Text="Old Password"></asp:Label></td>
                <td class="T19" style="text-align: left">
                    <asp:TextBox ID="txtOldPassword" runat="server" onkeyup="cekPassword();" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="T17">
                    <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label></td>
                <td class="T19" style="text-align: left">
                    <asp:TextBox ID="txtPassword" runat="server" onkeyup="cekPassword();" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="T17">
                    <asp:Label ID="Label3" runat="server" Text="Re-Type"></asp:Label></td>
                <td class="T19" style="text-align: left">
                    <asp:TextBox ID="txtReType" runat="server" onkeyup="cekPassword();" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="T17">
                </td>
                <td style="text-align: left"  class="T19">
                    <asp:Button ID="btnSave" runat="server" CssClass="hide" OnClick="btnSave_Click" Text="Save" /></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
