<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="WorkNest.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            height: 100vh;
            background-color: #F7F9FB; /* Light background */
            padding: 20px;
            gap: 10px;
        }

        .dashboard-panel {
            flex: 1;
            min-width: 280px;
            border: 1px solid #8B9EB2; /* Muted Blue-Grey border */
            padding: 20px;
            box-sizing: border-box;
            background-color: #E4F1F9; /* Light Sky Blue */
            border-radius: 12px;
            overflow-y: auto;
            height: 100%;
            scrollbar-width: none;
        }

        .dashboard-panel h2 {
            color: #4A6D85; /* Darker Blue-Grey */
            font-size: 1.5rem;
            font-weight: bold;
        }

        .dashboard-panel .card {
            border: 1px solid #4A6D85; /* Matching card border */
            background-color: #F7F9FB; /* Very Light Greyish Blue */
        }

        .dashboard-panel .card-title {
            color: #333333; /* Charcoal for text */
        }

        .dashboard-panel .card-text {
            color: #4A6D85;
        }

        .dashboard-panel .text-muted {
            color: #8B9EB2;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
                height: auto;
            }

            .dashboard-panel {
                height: auto;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Dashboard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <!-- In Progress Projects -->
        <div class="dashboard-panel">
            <h2>In Progress Projects</h2>
            <asp:Repeater ID="rptInProgress" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">
                                    Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %>
                                </small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Completed Projects -->
        <div class="dashboard-panel">
            <h2>Completed Projects</h2>
            <asp:Repeater ID="rptCompleted" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">
                                    Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %>
                                </small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- On Hold Projects -->
        <div class="dashboard-panel">
            <h2>On Hold Projects</h2>
            <asp:Repeater ID="rptHold" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">
                                    Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %>
                                </small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- In Testing Projects -->
        <div class="dashboard-panel">
            <h2>In Testing Projects</h2>
            <asp:Repeater ID="rptTesting" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">
                                    Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %>
                                </small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
