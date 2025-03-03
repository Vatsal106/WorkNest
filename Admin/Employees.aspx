<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="WorkNest.Admin.Employees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .employee-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .employee-card {
            width: 250px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            padding: 15px;
            margin: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .employee-card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
        }

        .employee-card:hover {
            transform: scale(1.05);
            box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.2);
        }

        .action-buttons {
            margin-top: 10px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .btn-update {
            background: #007bff;
            color: white;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        .btn-update:hover {
            background: #0056b3;
        }

        .btn-delete:hover {
            background: #c82333;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Employees
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="employee-container">
        <asp:Repeater ID="rptEmployees" runat="server" OnItemCommand="rptEmployees_ItemCommand">
            <ItemTemplate>
                <div class="employee-card">
                    <img src='<%# Eval("IMAGE") %>' alt="Employee Photo">
                    <h3><%# Eval("FULL_NAME") %></h3>
                    <p>Email: <%# Eval("EMAIL") %></p>
                    <p>Phone: <%# Eval("PHONE_NUMBER") %></p>
                    <p>Hire Date: <%# Eval("HIRE_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p>Department: <%# Eval("DEPARTMENT_NAME") %></p>

                    <div class="action-buttons">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete" 
                            CommandName="DeleteEmployee" CommandArgument='<%# Eval("EMPLOYEE_ID") %>' />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
