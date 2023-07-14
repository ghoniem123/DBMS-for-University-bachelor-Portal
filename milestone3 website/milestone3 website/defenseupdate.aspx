<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="defenseupdate.aspx.cs" Inherits="milestone3_website.defenseupdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="homebutton" runat="server" OnClick="Button1_Click" Text="Home" />
            <br />
            <br />
            <asp:Label ID="contentlabel" runat="server" Text="Content : "></asp:Label>
            <asp:TextBox ID="contentbox" runat="server"></asp:TextBox>
            &nbsp;<asp:Button ID="updatebutton" runat="server" Text="Update" OnClick="updatebutton_Click" />
        </div>
    </form>
</body>
</html>
