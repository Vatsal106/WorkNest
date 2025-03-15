<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="SubmitReport.aspx.cs" Inherits="WorkNest.Project_Manager.SubmitReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="container mt-4">
        <h2 class="mb-3">Insert Task Report</h2>
        <div class="card p-4 shadow-sm">
            <asp:HiddenField ID="hfTaskID" runat="server" />
            <div class="mb-3">
                <label for="ddlTasks" class="form-label">Select Task:</label>
                <asp:DropDownList ID="ddlTasks" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlTasks_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <asp:Label ID="Label1" runat="server" Text="Task Name: "></asp:Label>
                <asp:Label ID="txtTaskName" runat="server" class="form-label"></asp:Label>
            </div>
            <div class="mb-3">
                <label for="txttaskDescription" class="form-label">Task Description:</label>
                <asp:Label ID="txttaskDescription" runat="server" ></asp:Label>
            </div>
            <div class="mb-3">

                <label>Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select"></asp:ListItem>
                    <asp:ListItem Text="NOT STARTED" Value="NOT STARTED"></asp:ListItem>
                    <asp:ListItem Text="HOLD" Value="ON HOLD"></asp:ListItem>
                    <asp:ListItem Text="IN PROGRESS" Value="IN PROGRESS"></asp:ListItem>
                    <asp:ListItem Text="COMPLETED" Value="COMPLETED"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <label for="txtDescription" class="form-label">Report Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
            </div>
            <div class="mb-3">
                <label for="fuReport" class="form-label">Report File:</label>
                <asp:FileUpload ID="fuReport" runat="server" CssClass="form-control" />
                <asp:Label ID="lblLastUpdate" runat="server" Text="" CssClass="text-muted"></asp:Label>
            </div>
            <div class="text-center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" OnClick="btnClear_Click" />
            </div>
            <div class="mt-3 text-center">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-success" />
            </div>
        </div>
    </div>
</asp:Content>
