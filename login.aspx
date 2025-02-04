<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorkNest.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | WorkNest</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    
</head>
<body>
    <div class="container">
        <!-- Left Half: Image Section -->
        <div class="image-section">
            <asp:Image ID="LoginImg" runat="server" ImageUrl="~/Images/LOGINIMAGE.png" CssClass="login-image"/>
        </div>

        <!-- Right Half: Form Section -->
        <div class="form-section">
            <form id="form1" runat="server">
                <h2>Welcome Back <span class="wave">👋</span></h2>

                <p class="subtext">Please enter your credentials to sign in.</p>

                <div class="input-group">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input" Placeholder="Username"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" Placeholder="Password"></asp:TextBox>
                </div>
                <div class="button-group input-group">
                    <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="button" OnClick="btnLogin_Click" />
                </div>

                <p class="bottom-text">
                    Don't have an account? Contact Admin/Management!! 
                   
                </p>

                <asp:Label runat="server" ID="lblMessage" CssClass="error-message"></asp:Label>
            </form>
        </div>
    </div>
</body>
</html>
