<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="changeRoles.aspx.cs" Inherits="WorkNest.Admin.changeRoles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <!-- Add any CSS or script references here if needed -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Header_Title" runat="server">
    <!-- Add any header-specific content here if needed -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div>
            <label for="ddlName">NAME :</label>
            <asp:DropDownList ID="ddlName" runat="server" AutoPostBack="True" OnSelectedIndexChanged="bindCurrentRole">
            </asp:DropDownList>
        </div>
        <br />
        <div>
            <label for="txtCurrentRole">ROLE :</label>
            <asp:TextBox ID="txtCurrentRole" runat="server" ReadOnly="True"></asp:TextBox>
        </div>
        <br />
        <div>
            <label for="ddlChangedRole">CHANGE TO :</label>
            <asp:DropDownList ID="ddlChangedRole" runat="server" AutoPostBack="True">
            </asp:DropDownList>
        </div>
        <br />
        <div>
            <asp:Button ID="btnUpdateRole" runat="server" OnClick="btnUpdateRole_Click" Text="UPDATE" />
            &nbsp;
            <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="RESET" />
        </div>
        <br />
        <div>
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </div>
        <br />
    </div>
</asp:Content>
