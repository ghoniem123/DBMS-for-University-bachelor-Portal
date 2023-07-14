<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="notbooked.aspx.cs" Inherits="milestone3_website.notbooked" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="homebutton" runat="server" Text="Home" OnClick="homebutton_Click" />
            <br />
            <br />
            <asp:Label ID="notbookedlabel" runat="server" Text="Not booked meetings : "></asp:Label>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
