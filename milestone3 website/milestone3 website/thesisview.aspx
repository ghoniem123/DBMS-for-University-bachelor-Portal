<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thesisview.aspx.cs" Inherits="milestone3_website.thesisview" %>

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
        </div>
        <asp:Label ID="titlelabel" runat="server" Text="Thesis title : "></asp:Label>
        <asp:TextBox ID="titlebox" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="enterbutton" runat="server" Text="View" OnClick="enterbutton_Click" />
        <br />
        <br />
        <br />
    </form>
</body>
</html>
