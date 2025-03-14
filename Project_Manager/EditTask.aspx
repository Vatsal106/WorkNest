<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="EditTask.aspx.cs" Inherits="WorkNest.Project_Manager.EditTask" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Head" runat="server">
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
            background: #F7F9FB;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-title {
            text-align: center;
            color: #4A6D85;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            font-weight: bold;
            display: block;
        }

        .form-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #8B9EB2;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-submit {
            background: #4A6D85;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            width: 100%;
        }

            .btn-submit:hover {
                background: #3A5C74;
            }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="form-container">
        <h1 class="form-title">✏️ Edit Task</h1>

        <asp:HiddenField ID="hfTaskID" runat="server" />

        <div class="form-group">
            <label class="form-label">Task Name:</label>
            <asp:TextBox ID="txtTaskName" runat="server" CssClass="form-input"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label">Task Description:</label>
            <asp:TextBox ID="txtTaskDesc" runat="server" CssClass="form-input" TextMode="MultiLine" Rows="3"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label">Due Date:</label>
            <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-input" TextMode="Date"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label">Status:</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-input">
                <asp:ListItem Text="Select Status" Value="" />
                <asp:ListItem Text="NOT STARTED" Value="NOT STARTED" />
                <asp:ListItem Text="IN PROGRESS" Value="IN PROGRESS" />
                <asp:ListItem Text="ON HOLD" Value="ON HOLD" />
                <asp:ListItem Text="COMPLETED" Value="COMPLETED" />
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label class="form-label">Assigned To:</label>
            <asp:DropDownList ID="ddlAssignedTo" runat="server" CssClass="form-input"></asp:DropDownList>
        </div>

        <asp:Button ID="btnUpdate" runat="server" CssClass="btn-submit" Text="Update Task" OnClick="btnUpdate_Click" />
    </div>
</asp:Content>
