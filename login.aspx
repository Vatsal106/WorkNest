﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorkNest.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="Style.css">
</head>
<body>
    
    <div class="container">
        
        <div class="form-section">
            <form id="form1" runat="server">
                <h2>Holla, Welcome Back</h2>
                <div>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input" Placeholder="Username"></asp:TextBox>
                </div>
                <div>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" Placeholder="Password"></asp:TextBox>
                </div>
                <div>
                    <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Sign In" CssClass="button" />
                </div>
                <p>
                    Don't have an account? <asp:HyperLink ID="hplSignup" runat="server" NavigateUrl="~/registration.aspx">Sign Up</asp:HyperLink>
                </p>
                <p>
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </p>
            </form>
        </div>

       
        <div id="loginImage">
            <asp:Image ID="imgIllustration" runat="server" 
                       ImageUrl="~/original-ba68e98ea10e1867e831884c3b153387 (1) (1).png" 
                       AlternateText="Illustration" />
        </div>
    </div>
</body>
</html>
