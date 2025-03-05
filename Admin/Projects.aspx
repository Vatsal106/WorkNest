<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="WorkNest.Admin.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style> 
        .project-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .project-card {
            width: 300px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }

        .project-card:hover {
            transform: scale(1.05);
            box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.2);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
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
    Projects
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display: flex; justify-content: center; align-items: center; gap: 10px; margin-bottom: 20px;">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search projects..." Width="300px" />
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
    </div>

    <div class="project-container">
        <asp:Repeater ID="rptProjects" runat="server" OnItemCommand="rptProjects_ItemCommand">
            <ItemTemplate>
                <div class="project-card">
                    <h3><%# Eval("PROJECT_NAME") %></h3>
                    <p><strong>Manager:</strong> <%# Eval("PROJECT_MANAGER") %></p>
                    <p><strong>Client:</strong> <%# Eval("CLIENT_NAME") %></p>
                    <p><strong>Start Date:</strong> <%# Eval("START_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>End Date:</strong> <%# Eval("END_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>Status:</strong> <%# Eval("STATUS") %></p>

                    <div class="action-buttons">
                         <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update"
     OnClientClick='<%# "window.location.href=\"UpdateProjects.aspx?ProjectID=" + Eval("Project_ID") + "\"; return false;" %>' />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete"
                            CommandName="DeleteProject" CommandArgument='<%# Eval("PROJECT_ID") %>'
                            OnClientClick="return confirm('Are you sure you want to delete this project?');" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
