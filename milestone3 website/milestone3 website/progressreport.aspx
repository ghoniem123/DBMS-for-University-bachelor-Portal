<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="progressreport.aspx.cs" Inherits="milestone3_website.progressreport" %>

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
            <asp:Label ID="datelabel" runat="server" Text="Date : (YYYY/MM/DD) "></asp:Label>
            <asp:TextBox ID="datebox" runat="server"></asp:TextBox>
            &nbsp;&nbsp;
            <asp:Button ID="viewbutton" runat="server" Text="View" OnClick="viewbutton_Click" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
