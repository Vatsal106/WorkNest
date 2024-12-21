<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorkNest.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    
    <link rel="stylesheet" type="text/css" href="Style.css">

</head>
<body>
   <form id="form1" runat="server">
    <h2>Welcome Back</h2>
    <div>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="input" Placeholder="Username"></asp:TextBox>
    </div>
    <div>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" Placeholder="Password"></asp:TextBox>
    </div>
    <div>
       
        <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" />
       
    </div>
    <p>
        Don't have an account? <asp:HyperLink ID="hplSignup" runat="server" NavigateUrl="~/registration.aspx">Sign up.</asp:HyperLink>
    </p>
       <p>
           <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </p>
       <asp:Image ID="imgPhoto" runat="server" BorderStyle="Solid" Height="100px" Width="100px" />
       
</form>
</body>
</html>