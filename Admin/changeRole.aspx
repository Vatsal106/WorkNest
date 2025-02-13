<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="changeRole.aspx.cs" Inherits="WorkNest.Admin.changeRole" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            NAME :
            <asp:DropDownList ID="ddlName" runat="server" AutoPostBack="True" OnSelectedIndexChanged="bindCurrentRole">
            </asp:DropDownList>
            <br />
            <br />
            ROLE :
            
            <asp:TextBox ID="txtCurrentRole" runat="server" ReadOnly="True"></asp:TextBox>
            
            <br />
            <br />
            CHANGE TO :
            <asp:DropDownList ID="ddlChangedRole" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="btnUpdateRole" runat="server" OnClick="btnUpdateRole_Click" Text="UPDATE" />
&nbsp;
            <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="RESET" />
            <br />
            <br />
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <br />
            <br />

        </div>
    </form>
</body>
</html>
