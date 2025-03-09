<%@ Page Title="Add Task" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AddTask.aspx.cs" Inherits="WorkNest.Admin.AddTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    <h2>Add New Task</h2>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <label>Task Name:</label>
        <asp:TextBox ID="txtTaskName" runat="server" CssClass="form-control" required></asp:TextBox>
    </div>

    <div>
        <label>Project:</label>
        <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-control"></asp:DropDownList>
    </div>

    <div>
        <label>Description:</label>
        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
    </div>

    <div>
        <label>Start Date:</label>
        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>

    <div>
        <label>Due Date:</label>
        <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>

    <div>
        <label>Status:</label>
        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
        </asp:DropDownList>
    </div>

    <div>
    <label>Department:</label>
    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" AutoPostBack="true" 
        OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
    </asp:DropDownList>
</div>

    <div>
        <label>Assign To:</label>
        <asp:DropDownList ID="ddlAssignTo" runat="server" CssClass="form-control"></asp:DropDownList>
    </div>

    <div>
        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Add Task" OnClick="btnSubmit_Click" />
    </div>
</asp:Content>
