﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thesis.aspx.cs" Inherits="milestone3_website.thesis" %>

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
            <asp:Button ID="viewbutton" runat="server" Text="View thesis" OnClick="viewbutton_Click" Width="221px" />
            <br />
            <asp:Button ID="submitbutton" runat="server" Text="Submit thesis" OnClick="submitbutton_Click" Width="220px" />
        </div>
    </form>
</body>
</html>
