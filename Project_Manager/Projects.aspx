<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="WorkNest.Project_Manager.Projects" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <style>
        .project-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
        }
        .project-card {
            width: 300px;
            background: #ffffff;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            border-left: 5px solid #007bff;
        }
        .project-card h3 {
            margin-bottom: 10px;
            color: #007bff;
            font-size: 18px;
        }
        .project-card p {
            margin: 5px 0;
            font-size: 14px;
            color: #333;
        }
        .status {
            font-weight: bold;
        }
        .status.in-progress { color: orange; }
        .status.completed { color: blue; }
        .status.on-hold { color: red; }
    </style>

    <div class="project-container">
        <asp:Repeater ID="rptProjects" runat="server">
            <ItemTemplate>
                <div class="project-card">
                    <h3><%# Eval("PROJECT_NAME") %></h3>
                    <p><strong>Description:</strong> <%# Eval("DESCRIPTION") %></p>
                    <p><strong>Start Date:</strong> <%# Eval("START_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>End Date:</strong> <%# Eval("END_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>Client:</strong> <%# Eval("CLIENT_NAME") %></p>
                    <p class="status <%# Eval("STATUS").ToString().ToLower() %>">
                        <strong>Status:</strong> <%# Eval("STATUS") %>
                    </p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
