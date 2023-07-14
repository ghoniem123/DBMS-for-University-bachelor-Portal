<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="milestone3_website.profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="profileLabel" runat="server" Text="Your profile"></asp:Label>
            <br />
        </div>
        <asp:Button ID="viewprojects1"  style="position:absolute;float:right; top: 225px; left: 30; height: 35px; width=110px;" runat="server" Text="view projects" OnClick="viewprojects1_Click" />
        <asp:Button ID="homewindow" style="position:absolute; float:right; top: 225px; left: 195px; height: 35px; width: 110px;" runat="server" Text="home" OnClick="homewindow_Click" />
    </form>
</body>
</html>
