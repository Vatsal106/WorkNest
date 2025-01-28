<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorkNest.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
</head>
<body>
    <div class="container">
        <!-- Left Half: Image Section -->
        <div class="image-section"></div>

        <!-- Right Half: Form Section -->
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
                    <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="button" OnClick="btnLogin_Click" />
                </div>
                <p>
                    Don't have an account? 
                    <asp:HyperLink ID="hplSignup" runat="server" NavigateUrl="~/registration.aspx">Sign Up</asp:HyperLink>
                </p>
                <asp:Label runat="server" ID="lblMessage" ></asp:Label>
            </form>
        </div>
    </div>
</body>
</html>