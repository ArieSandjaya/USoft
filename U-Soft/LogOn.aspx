<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogOn.aspx.cs" Inherits="USoft.LogOn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta charset="utf8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Log On Page</title>
    <link rel="stylesheet" href="CSS/login/style.css" />
    <script src="Javascript/jquery-1.8.3.js"></script>
    <script src="Javascript/login.js"></script>
    <style type="text/css">
#cssmenu {
	width: 100%;
	height: 27px;
	margin: 0;
	padding: 0;
	background: #000000 url(CSS/homepage/images/bg-bubplastic.gif) top left repeat-x;
}
#cssmenu ul {
	list-style: none;
	margin: 0;
	padding: 0;
}
#cssmenu ul li {
	float: left;
	margin: 0;
	padding: 0;
	background: transparent url(CSS/homepage/images/bg-bubplastic-button.gif) top left no-repeat;
}

#cssmenu ul li a {
	display: block;
	height: 27px;
	padding-left: 35px;
	float: left;
	text-transform: uppercase;
	font-family: 'Helvetica Neue',helvetica,'microsoft sans serif',arial,sans-serif;
	font-size: 70%;
	color: #FFFFFF;
	text-decoration: none;
}

#cssmenu ul li a span {
	display: block;
	float: left;
	height: 22px;
	padding-top: 5px;
	padding-right: 35px;
	background: transparent url(CSS/homepage/images/bg-bubplastic-button.gif) top right no-repeat;
	cursor: pointer;
}


#cssmenu ul li a:hover,
#cssmenu ul li.active a {
	background: transparent url(CSS/homepage/images/bg-bubplastic-h-orange.gif) top left no-repeat;
}
#cssmenu ul li a:hover span,
#cssmenu ul li.active a span {
	background: transparent url(CSS/homepage/images/bg-bubplastic-h-orange.gif) top right no-repeat;
}

</style>
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <div id="bar">
        <div id="container">
            <div id="loginContainer">
                <a href="#" id="loginButton" runat="server"><span>Login</span><em></em></a>
                <div style="clear:both"></div>
                <div id="loginBox">                
                    <form id="loginForm" runat="server">
                        <fieldset id="body">
                            <fieldset>
                                <label for="email">
                                    User</label>
                                <asp:TextBox ID="txtUserID" runat="server"></asp:TextBox>
                            </fieldset>
                            <fieldset>
                                <label for="password">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                            </fieldset>
                            <asp:Button ID="login" runat="server" Text="Sign in" OnClick="login_Click"/>
                        </fieldset>
                        <span><a href="#"></a></span>
                    </form>
                </div>
            </div>
            <!-- Login Ends Here -->
        </div>
    </div>
    <div align="center">
        <asp:Label ID="lblWarning" runat="server" ForeColor="Red">Please Change Your Windows Regional Setting To "English (United States)"</asp:Label>
    </div>
    <div id='cssmenu'>
    <ul>
       <li><a href='#' onclick="LoadDiv('Modules/HomePage/home.html')";><span>Home</span></a></li>
       <li><a href='#'><span>IT Request Form</span></a></li>
       <li><a href='#'><span>Email Address</span></a></li>
       <li><a href='#'><span>S.O.P</span></a></li>
       <li><a href='#'><span>Marketing Support</span></a></li>
       <li><a href='#'><span>Others Form</span></a></li>
       <li><a href='#'><span>Feed Back</span></a></li>
    </ul>
    </div>
    <div id="myPage" style="padding-right: 10px; padding-left: 10px; margin-left: 10px; margin-right: 10px">
        <%		   
            Response.WriteFile("Modules/HomePage/home.html");
        %>    
    </div>
</body>
</html>
