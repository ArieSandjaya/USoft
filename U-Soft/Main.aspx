<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="USoft.Main" %>
<%@ Register Src="Controls/ctlPageHeader.ascx" TagName="ctlPageHeader" TagPrefix="uc2" %>
<%@ Register Src="Controls/ctlAccordionMenu.ascx" TagName="ctlAccordionMenu" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>

<title>U-Soft</title>
    <link rel="stylesheet" type="text/css" href="CSS/black-tie/jquery-ui-1.9.2.custom.min.css" />
    <link rel="stylesheet" type="text/css" href="CSS/black-tie/ui-layout.css" />
    <script type="text/javascript" src="Javascript/jquery.js"></script>
    <script type="text/javascript" src="Javascript/jquery.layout-1.2.0.js"></script>
    <script type="text/javascript" src="Javascript/ScriptSession.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
	    $('body').layout({ applyDefaultStyles: true,north__applyDefaultStyles: false });
    });
    function logout()
    {
        window.parent.location.href = 'LogOn.aspx'
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="ui-layout-center">
            <iframe id="myFrame" style="width: 100%; height: 100%; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top:0px; overflow: scroll;" src="" scrolling="yes" allowtransparency="" frameborder="no"></iframe></div>
        <div class="ui-layout-north ui-widget-header" style="left: 0px; position: absolute; top: 0px">
            <div align="Left" style="width:100%"><p><uc2:ctlPageHeader ID="CtlPageHeader1" runat="server" /></p></div>
            <div style="right: 0px; position: absolute; top: 0px; padding-top: 5px;padding-bottom: 5px;padding-right: 5px;"><asp:ImageButton ID="imgLogoff" runat="server" ImageUrl="~/CSS/login/images/exit.png" OnClick="imgLogoff_Click" OnClientClick="logout();" /></div>
        </div>
        <div class="ui-layout-west"><uc1:ctlAccordionMenu ID="CtlAccordionMenu1" runat="server" /></div>
    </form>
</body>
</html>
        <script type="text/javascript">
            function ChangeIFrameLocation(loc)
            {   CheckSession();
                document.getElementById('myFrame').src=loc;
             };
        </script>
