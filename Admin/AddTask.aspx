<%@ Page Title="Add Task" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AddTask.aspx.cs" Inherits="WorkNest.Admin.AddTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        
        body {
            background-color: #f4f7f8;
            font-family: 'Poppins', sans-serif;
        }

        
        .form-container {
            max-width: 600px;
            margin: 0px auto;
            padding: 25px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .form-container:hover {
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.15);
        }

        
        label {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        
        .form-control {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            background-color: #f9f9f9;
            transition: border 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.2);
            outline: none;
        }

        
        .form-control select {
            cursor: pointer;
        }

        
        .btn-primary {
            background: linear-gradient(to right, #007bff, #0056b3);
            border: none;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 8px;
            color: white;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
            width: 100%;
        }

        .btn-primary:hover {
            background: linear-gradient(to right, #0056b3, #003c7e);
            transform: scale(1.05);
        }

        
        @media screen and (max-width: 425px) {
            .form-container {
                max-width: 90%;
                padding: 20px;
            }
        }

        @media screen and (max-width: 768px) {
            .form-container {
                max-width: 85%;
            }
        }

        @media screen and (min-width: 1024px) {
            .form-container {
                max-width: 50%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    <h2 class="text-center">Add New Task</h2>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="form-container">
            <div class="mb-3">
                <label for="txtTaskName">Task Name:</label>
                <asp:TextBox ID="txtTaskName" runat="server" CssClass="form-control" required></asp:TextBox>
            </div>

            <div class="mb-3">
                <label for="ddlProject">Project:</label>
                <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="mb-3">
                <label for="txtDescription">Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label for="txtStartDate">Start Date:</label>
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label for="txtDueDate">Due Date:</label>
                <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label for="ddlStatus">Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
                    <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="mb-3">
                <label for="ddlDepartment">Department:</label>
                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <div class="mb-3">
                <label for="ddlAssignTo">Assign To:</label>
                <asp:DropDownList ID="ddlAssignTo" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="text-center">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Add Task" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </div>
</asp:Content>
