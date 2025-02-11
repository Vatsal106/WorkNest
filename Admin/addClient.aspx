<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addClient.aspx.cs" Inherits="WorkNest.Admin.addClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            CLIENT NAME :
            <asp:TextBox ID="txtClientName" runat="server"></asp:TextBox>
            <br />
            <br />
            EMAIL :
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
            <br />
            <br />
            PHONE NUMBER : <asp:TextBox ID="txtPhoneNumber" runat="server" TextMode="Number"></asp:TextBox>
            <br />
            <br />
            COMPANY NAME : <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
            <br />
            <br />
            ADDRESS :
            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SUBMIT" />
            <br />
            <br />
            <asp:Label ID="lblError" class="btn" runat="server"></asp:Label>

        </div>
    </form>
</body>
</html>
