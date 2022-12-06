<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="USoft.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Ufinance Software</title>
    <link href="CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="Javascript/ScriptSession.js"></script>
    <style type="text/css" media="screen">
        body,
        html {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        * {
            padding: 0;
            margin: 0;
        }

        iframe {
            width: 100%;
            height: 100%;
            overflow: hidden;
            border: none;
        }
    </style>
</head>
<body>
    <iframe id="myFrame" style="width: 100%; height: 100%; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top:0px; overflow: scroll;" src="Main.aspx" scrolling="yes" frameborder="yes"></iframe>
</body>
</html>
<script type="text/javascript">
    function loadWait()
    {
        $.blockUI({message: '<IMG SRC="CSS/black-tie/images/loading6.gif" />'});
    }
    function closeWait()
    {
        $.unblockUI();
    }
    function cekSession()
    {
        CheckSession();
    }
</script>
