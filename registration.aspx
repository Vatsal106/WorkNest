<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="WorkNest.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
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
    </style>
    </head>
<body>
    <form id="regestration" runat="server">
        <div>
           
             <table align="center" class="auto-style1" style="width: 50%">
                <tr>
                    <td colspan="2" rowspan="1" style="text-align: center; font-size: xx-large;">Rgestration Form&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3" style="text-align: right; padding-right: 15px;">Name:</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Phone number:</td>
                    <td>
                        <asp:TextBox ID="txtPhone" runat="server" TextMode="Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2" style="text-align: right; padding-right: 15px;">Email:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Password:</td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Rewrite Parssword:</td>
                    <td>
                        <asp:TextBox ID="txtRepassword" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Gender:</td>
                    <td style="float: left">
                        <asp:RadioButtonList ID="rblGender" runat="server" CellPadding="1" CellSpacing="1" RepeatDirection="Horizontal" TextAlign="Left">
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">City:</td>
                    <td>
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
                    <td>
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Address:</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" Height="57px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 15px;">Image:</td>
                    <td>
                        <asp:FileUpload ID="fuImage" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-right: 10px;">
                        <asp:Button ID="btnSubmit" runat="server"  Text="Submit" Width="69px" OnClick="btnSubmit_Click" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset"  />
                    </td>
                </tr>
                </table>
           
        </div>
        <asp:Label ID="lblCon" runat="server"></asp:Label>
    </form>
</body>
</html>
