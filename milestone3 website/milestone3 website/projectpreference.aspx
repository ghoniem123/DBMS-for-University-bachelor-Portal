<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="projectpreference.aspx.cs" Inherits="milestone3_website.projectpreference" %>

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
            <asp:Label ID="codelabel" runat="server" Text="bachelor project code : " Width ="200 px"></asp:Label>
            <asp:TextBox ID="codebox" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="preferencelabel" runat="server" Text="preference number : " Width="200px"></asp:Label>
            <asp:TextBox ID="preferencebox" runat="server" ></asp:TextBox>
            <br />
            <asp:Button ID="confimbutton" runat="server" Text="Confirm" OnClick="confimbutton_Click" />
        </div>
    </form>
</body>
</html>
