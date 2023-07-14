<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="welcome.aspx.cs" Inherits="milestone3_website.welcome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="welcome1" runat="server"  Text="Welcome"></asp:Label>
        <br />
        <br />
        <asp:Button ID="register1" runat="server" OnClick ="register1_Click" Text="Register" />
        <asp:Button ID="signin1" runat="server" Text="Login" OnClick="signin1_Click1" Width="75px" />
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
