<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="milestone3_website.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="profilebutton" runat="server" Text="profile" OnClick="profilebutton_Click" />
            <br />
            <br />
            <asp:Button ID="thesisbutton" runat="server" Text="Thesis" Width="240px" OnClick="thesisbutton_Click" />
            <br />
            <br />
        </div>
        <asp:Button ID="projectbutton" runat="server" Text="Local bachelor project" Width="240px" OnClick="projectbutton_Click" />
        <br />
        <br />
        <asp:Button ID="progressbutton" runat="server" Text="Progress report" Width="240px" OnClick="progressbutton_Click" />
        <br />
        <br />
        <asp:Button ID="defensebutton" runat="server" Text="Defense" Width="240px" OnClick="defensebutton_Click" />
        <br />
        <br />
        <asp:Button ID="meetingbutton" runat="server" Text="Meetings" Width="240px" OnClick="meetingbutton_Click" />
    </form>
</body>
</html>
