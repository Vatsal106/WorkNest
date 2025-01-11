<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="WorkNest.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Registration</title>
    <style type="text/css">
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}

.auto-style1 {
    width: 100%;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    background-color: #ffffff;
    padding: 20px;
}

h1 {
    text-align: center;
    color: #333;
}

.auto-style3 {
    text-align: right;
    padding-right: 15px;
    font-weight: bold;
}

.auto-style4, .auto-style5, .auto-style6, .auto-style7 {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    transition: border-color 0.3s;
}

.auto-style4:focus, .auto-style5:focus, .auto-style6:focus, .auto-style7:focus {
    border-color: #007BFF;
    outline: none;
}

label {
    color: #555;
}

.valid {
    color: green;
}

.invalid {
    color: red;
}

button {
    background-color: #007BFF;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #0056b3;
}

.error-message {
    color: red;
    font-weight: bold;
    text-align: center;
}
        .auto-style1 {
            width: 100%;
            border: 1px solid #000000;
            background-color: #C0C0C0;
        }

        .auto-style2 {
            height: 26px;
        }

        .auto-style3 {
            height: 29px;
        }

        .valid {
            color: green;
        }

        .invalid {
            color: red;
        }
        .auto-style4 {
            height: 29px;
            width: 356px;
        }
        .auto-style5 {
            width: 356px;
        }
        .auto-style6 {
            height: 26px;
            width: 356px;
        }
        .auto-style7 {
            float: left;
            width: 356px;
        }
    </style>
</head>
<body>
    <form id="regestration" runat="server">
        <div>

            <table align="center" class="auto-style1" style="width: 50%">
                <tr>
                    <td colspan="2" rowspan="1" style="text-align: center; font-size: xx-large;">Registration Form&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3" style="text-align: right; padding-right: 15px;">Name:</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Phone number:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtPhone" runat="server" TextMode="Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2" style="text-align: right; padding-right: 15px;">Email:</td>
                    <td class="auto-style6">
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2" style="text-align: right; padding-right: 15px;">User Name:</td>
                    <td class="auto-style6">
                        <asp:TextBox ID="txtUsername" runat="server" AutoPostBack="True" OnTextChanged="checkUser" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;" class="auto-style3">Password:</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" OnTextChanged="PasswordChanged" AutoPostBack="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Rewrite Parssword:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtRepassword" runat="server" TextMode="Password" OnTextChanged="checkBothPass_TextChanged" AutoPostBack="true"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">&nbsp;</td>
                    <td class="auto-style5">
                        <asp:Label ID="lblLength" runat="server" ForeColor="Red" Text="At least 8 characters"></asp:Label><br />
                        <asp:Label ID="lblNumberOrSymbol" runat="server" ForeColor="Red" Text="At least one number (0-9) or a symbol"></asp:Label><br />
                        <asp:Label ID="lblCase" runat="server" ForeColor="Red" Text="Lowercase (a-z) and uppercase (A-Z)"></asp:Label><br />
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Gender:</td>
                    <td class="auto-style7">
                        <asp:RadioButtonList ID="rblGender" runat="server" CellPadding="1" CellSpacing="1" RepeatDirection="Horizontal" TextAlign="Left">
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">City:</td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="ddlCity" runat="server">
                            <asp:ListItem>-----select-----</asp:ListItem>
                            <asp:ListItem>surat</asp:ListItem>
                            <asp:ListItem>tapi</asp:ListItem>
                            <asp:ListItem>botad</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Date of birth:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Address:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtAddress" runat="server" Height="57px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Image:</td>
                    <td class="auto-style5">
                        <asp:FileUpload ID="fuImage" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-right: 10px;">
                        <br />
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                        <br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="69px" OnClick="btnSubmit_Click" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                    </td>
                </tr>
            </table>

        </div>
        <asp:Label ID="lblCon" runat="server"></asp:Label>
    </form>
</body>
</html>
