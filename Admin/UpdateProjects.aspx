<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="UpdateProjects.aspx.cs" Inherits="WorkNest.Admin.UpdateProjects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Update Project
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h2>Update Project</h2>
    
    <asp:HiddenField ID="hfProjectID" runat="server" />

    <label>Project Name:</label>
    <asp:TextBox ID="txtProjectName" runat="server" CssClass="form-control" />

    <label>Description:</label>
    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" />

    <label>Start Date:</label>
    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date" />

    <label>End Date:</label>
    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date" />

    <label>Status:</label>
    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
        <asp:ListItem Text="HOLD" Value="ON HOLD"></asp:ListItem>
        <asp:ListItem Text="IN PROGRESS" Value="IN PROGRESS"></asp:ListItem>
        <asp:ListItem Text="IN TESTING" Value="IN TESTING"></asp:ListItem>
        <asp:ListItem Text="COMPLETED" Value="COMPLETED"></asp:ListItem>
    </asp:DropDownList>

    <label>Project Manager:</label>
    <asp:DropDownList ID="ddlProjectManager" runat="server" CssClass="form-control"></asp:DropDownList>

    <label>Client:</label>
    <asp:DropDownList ID="ddlClient" runat="server" CssClass="form-control"></asp:DropDownList>

    <br />
    <asp:Label ID="lblError" Text="" runat="server" />
    <asp:Button ID="btnUpdateProject" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdateProject_Click" />
    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
</asp:Content>