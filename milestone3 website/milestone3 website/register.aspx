<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="milestone3_website.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 46px">
            <asp:Label ID="registerlabel" runat="server" Text="please fill the following boxes "></asp:Label>
            <br />
            <asp:Label ID="required" runat="server" Text="All the following fields are required "></asp:Label>
            <br />
            <br />
            <br />
        </div>
        <asp:Label ID="fnamelabel" runat="server" Text="First name : "></asp:Label>
        <asp:TextBox ID="fnamebox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lnamelabel" runat="server" Text="Last name : "></asp:Label>
        <asp:TextBox ID="lnamebox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="dateofbirth" runat="server" Text="Date of birth (in format YYYY/MM/DD) : "></asp:Label>
        <asp:TextBox ID="dateofbirthbox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="gpalabel" runat="server" Text="GPA : "></asp:Label>
        <asp:TextBox ID="gpabox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="usernamelabel" runat="server" Text="Username : "></asp:Label>
        <asp:TextBox ID="usernamebox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="emaillabel" runat="server" Text="Email : "></asp:Label>
        <asp:TextBox ID="emailbox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="SemesterLabel2" runat="server" Text="Semester : "></asp:Label>
        <asp:DropDownList ID="semesterlist" runat="server">
            <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Label ID="addresslabel" runat="server" Text="Address : "></asp:Label>
        <asp:TextBox ID="addressbox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="majorcodelabel" runat="server" Text="Major code : "></asp:Label>
        <asp:TextBox ID="majorcodebox" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="phonelabel" runat="server" Text="Phone number : "></asp:Label>
        <asp:TextBox ID="phonebox" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="registerbutton" runat="server" Text="Register" OnClick="registerbutton_Click" />
    </form>
</body>
</html>
