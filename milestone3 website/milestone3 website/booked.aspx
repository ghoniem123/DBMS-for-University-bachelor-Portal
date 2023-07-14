<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="booked.aspx.cs" Inherits="milestone3_website.booked" %>

<!DOCTYPE html>
<head runat="server">
    <title></title>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="homebutton" runat="server" Text="Home" OnClick="homebutton_Click" />
            <br />
            <br />
            <asp:Label ID="idlabel" runat="server" Text="Meeting id : "></asp:Label>
            <asp:TextBox ID="idbox" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="viewbutton" runat="server" Text="View" OnClick="viewbutton_Click" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
