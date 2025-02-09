<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProject.aspx.cs" Inherits="WorkNest.Admin.addProject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="addProject" runat="server">
        <div>

            Project Name :
            <asp:TextBox ID="txtProjectName" runat="server"></asp:TextBox>
            <br />
            <br />
            Description :<asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <br />
            Start Date :
            <asp:TextBox ID="dateStart" runat="server" TextMode="Date"></asp:TextBox>
&nbsp;<br />
            <br />
            End Date : <asp:TextBox ID="dateEnd" runat="server" TextMode="Date"></asp:TextBox>
            <br />
            <br />
            Status :
            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <br />
            Project Manager :
            <asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <br />
            Client :
            <asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SUBMIT" />
            <asp:Button ID="btnReset" runat="server" Text="RESET" OnClick="btnReset_Click" />
            <br>
            <br>
            <asp:Label ID="lblError" class="btn" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
