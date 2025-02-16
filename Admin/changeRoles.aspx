<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="changeRoles.aspx.cs" Inherits="WorkNest.Admin.changeRoles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <!-- Add any CSS or script references here if needed -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Header_Title" runat="server">
    <!-- Add any header-specific content here if needed -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
</asp:Content>