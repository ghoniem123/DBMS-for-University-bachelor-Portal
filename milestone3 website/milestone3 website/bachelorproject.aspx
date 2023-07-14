<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bachelorproject.aspx.cs" Inherits="milestone3_website.bachelorproject" %>

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
            <asp:Button ID="preferencebutton" runat="server" Text="Make local project preference" Width="350px" OnClick="preferencebutton_Click" />
            <br />
            <asp:Button ID="gradebutton" runat="server" Text="View your bachelor project grade" Width="350px" OnClick="gradebutton_Click" />
        </div>
    </form>
</body>
</html>
