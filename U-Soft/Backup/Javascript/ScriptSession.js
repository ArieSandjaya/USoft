function CheckSession() {
debugger;
    var session = '<%=Session["UserId"] != null%>';
    if (session == false) {
    alert("Your Session has expired");
    window.location = "../login.aspx";
    }
}
