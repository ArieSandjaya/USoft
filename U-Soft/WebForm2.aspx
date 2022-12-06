<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="USoft.WebForm2" %>

<%@ Register Src="Controls/ctlHtmlAccordionMenu.ascx" TagName="ctlHtmlAccordionMenu"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <uc1:ctlHtmlAccordionMenu ID="CtlHtmlAccordionMenu1" runat="server" />
    
    </div>
    </form>
</body>
</html>
