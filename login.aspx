<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorkNest.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style6 {
            height: 26px;
        }
        .auto-style7 {
            width: 100%;
            border: 1px solid #000000;
            background-color: #FFFFCC;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="display:flex; justify-content:center;">

            <table cellpadding="2" class="auto-style7" style="width: 35%; text-align: center;">
                <tr>
                    <td colspan="2" style="font-size: xx-large">LogIn</td>
                </tr>
                <tr>
                    <td style=" text-align:right;">USERNAME: </td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style=" text-align:right;">PASSWORD: </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click1" Text="login" />
                    </td>
                </tr>
            </table>

        </div>
        <p class="auto-style6" style="text-align: center">
&nbsp;don&#39;t have an account?
            <asp:HyperLink ID="hplSignup" runat="server" NavigateUrl="~/registration.aspx">Sign up.</asp:HyperLink>
        </p>
        <p class="auto-style6" style="font-size: x-large; font-family: 'Comic Sans MS'; text-align: center">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </p>
        <p>
            <asp:Image ID="imgPhoto" runat="server" />
        </p>
    </form>
</body>
</html>
