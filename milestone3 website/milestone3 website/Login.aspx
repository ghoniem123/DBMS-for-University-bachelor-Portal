<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="milestone3_website.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="loginlabel" runat="server">
        <div>
            please login<br />
            <br />
        </div>
        <asp:Label ID="emaillabel" runat="server" Text="Email : "  Width="100px"></asp:Label>
        <asp:TextBox ID="idbox" runat="server"></asp:TextBox>
        <p>
           <asp:Label ID="passlabel" runat="server" Text="Password : " Width="100px"></asp:Label>
            <asp:TextBox ID="passbox" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="loginbutton" runat="server" Text="login" OnClick="loginbutton_Click" />
    </form>
</body>
</html>
