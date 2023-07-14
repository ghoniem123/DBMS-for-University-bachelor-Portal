<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="projects.aspx.cs" Inherits="milestone3_website.Courses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="profilebutton" runat="server" OnClick="profilebutton_Click" Text="Profile" />
        <asp:Button ID="homebutton" runat="server" OnClick="homebutton_Click" Text="Home" />
        <br />
        <br />
        <asp:Label ID="idlabel" runat="server" Text="ID : " Width ="120 px"></asp:Label>
        <asp:TextBox ID="idbox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="typebox" runat="server" Text="Project type : " Width ="120 px"></asp:Label>
        <asp:DropDownList ID="typelist" runat="server">
            <asp:ListItem>Academic</asp:ListItem>
            <asp:ListItem>Industrial</asp:ListItem>
            <asp:ListItem>Both</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Button ID="viewbutton" runat="server" Text="View" OnClick="viewbutton_Click" />
        <br />
        <br />
        <asp:Label ID="projectslabel" runat="server" Text="Available bachelor projects : "></asp:Label>
        <br />
        <br />
    </form>
</body>
</html>
