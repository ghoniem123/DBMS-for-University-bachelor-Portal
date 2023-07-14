<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="meetings.aspx.cs" Inherits="milestone3_website.meetings" %>

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
        </div>
        <asp:Button ID="notbookedbutton" runat="server" Text="View not booked meetings" width ="250px" OnClick="notbookedbutton_Click"/>
        <br />
        <asp:Button ID="bookbutton" runat="server" Text="Book a meeting" width ="250px" OnClick="bookbutton_Click"/>
        <br />
        <asp:Button ID="viewbookedbutton" runat="server" Text="View booked meetings" width ="250px" OnClick="viewbookedbutton_Click"/>
        <br />
        <asp:Button ID="addtodobutton" runat="server" Text="Add to do list of a meeting" width ="250px" OnClick="addtodobutton_Click" />
    </form>
</body>
</html>
