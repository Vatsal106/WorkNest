<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorkNest.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 50%;
            border: 1px solid #000000;
            background-color: #FFFFCC;
            height: 118px;
            margin-left: 326px;
        }
        .auto-style2 {
            width: 261px;
        }
        .auto-style3 {
            width: 261px;
            height: 29px;
        }
        .auto-style4 {
            width: 279px;
        }
        .auto-style5 {
            width: 279px;
            height: 29px;
        }
        .auto-style6 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <table class="auto-style1" style="width: 40%">
                <tr>
                    <td class="auto-style2" style="padding-right: 15px; text-align: right">USERNAME</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3" style="padding-right: 15px; text-align: right">PASSWORD</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3" style="text-align: center; padding-center: 15px;" colspan="2">
                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SUBMIT" />
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
            &nbsp;</p>
    </form>
</body>
</html>
