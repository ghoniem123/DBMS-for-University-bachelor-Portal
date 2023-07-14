<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="book.aspx.cs" Inherits="milestone3_website.book" %>

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
            <asp:Label ID="idlabel" runat="server" Text="Meeting id : "></asp:Label>
            <asp:TextBox ID="idbox" runat="server"></asp:TextBox>
            &nbsp;<asp:Button ID="bookbutton" runat="server" Text="Book" OnClick="bookbutton_Click" />
        </div>
    </form>
</body>
</html>
