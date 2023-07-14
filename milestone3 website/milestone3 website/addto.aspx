<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addto.aspx.cs" Inherits="milestone3_website.addto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="homebutton" runat="server" OnClick="homebutton_Click" Text="Home" />
            <br />
            <br />
        </div>
        <asp:Label ID="idbutton" runat="server" Text="Meeting id : " Width="130px"></asp:Label>
        <asp:TextBox ID="idbox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="todolistlabel" runat="server" Text="To do list : "  Width="130px" ></asp:Label>
        <asp:TextBox ID="todobox" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="addbutton" runat="server" Text="Add" OnClick="addbutton_Click" />
    </form>
</body>
</html>
