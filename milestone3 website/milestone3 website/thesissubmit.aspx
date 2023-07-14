<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thesissubmit.aspx.cs" Inherits="milestone3_website.thesissubmit" %>

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
            <asp:Label ID="titlelabel" runat="server" Text="Title : " Width="87px"></asp:Label>
            &nbsp;&nbsp;
            &nbsp;<asp:TextBox ID="titlebox" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="pdflabel" runat="server" Text="PDF document : "></asp:Label>
            <asp:TextBox ID="pdfbox" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="submitbutton" runat="server" Text="Submit" OnClick="submitbutton_Click" />
        </div>
    </form>
</body>
</html>
