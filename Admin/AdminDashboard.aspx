﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="WorkNest.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .dashboard-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            padding: 20px;
            background-color: #F7F9FB;
            min-height: 100vh;
        }

        .dashboard-panel {
            padding: 15px;
            background: rgba(228, 241, 249, 0.9);
            border: 1px solid #8B9EB2;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow-y: auto;
            height: calc(100vh - 40px);
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        .dashboard-panel::-webkit-scrollbar {
            display: none;
        }

        .dashboard-panel:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .dashboard-panel h2 {
            color: #4A6D85;
            font-size: 1.4rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
            position: relative;
        }

        .dashboard-panel h2::after {
            content: "";
            width: 50px;
            height: 3px;
            background-color: #FF8C00;
            position: absolute;
            bottom: -5px;
            left: 0;
            border-radius: 2px;
        }

        .dashboard-panel .card {
            border: 1px solid #4A6D85;
            background: #F7F9FB;
            border-radius: 8px;
            padding: 12px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .dashboard-panel .card:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .dashboard-panel .card-title {
            color: #333333;
            font-weight: bold;
            font-size: 1.2rem;
        }

        .dashboard-panel .card-text {
            color: #4A6D85;
            font-size: 0.95rem;
            line-height: 1.4;
        }

        .dashboard-panel .text-muted {
            color: #8B9EB2;
        }

        @media (max-width: 1200px) {
            .dashboard-container {
                grid-template-columns: repeat(2, 1fr);
                grid-template-rows: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
                grid-template-rows: auto;
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
        <div class="dashboard-panel">
            <h2>In Progress Projects</h2>
            <asp:Repeater ID="rptInProgress" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %></small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="dashboard-panel">
            <h2>Completed Projects</h2>
            <asp:Repeater ID="rptCompleted" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %></small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="dashboard-panel">
            <h2>On Hold Projects</h2>
            <asp:Repeater ID="rptHold" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %></small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="dashboard-panel">
            <h2>In Testing Projects</h2>
            <asp:Repeater ID="rptTesting" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("PROJECT_NAME") %></h5>
                            <p class="card-text"><%# Eval("DESCRIPTION") %></p>
                            <p class="card-text">
                                <small class="text-muted">Start: <%# Eval("START_DATE", "{0:yyyy-MM-dd}") %> | End: <%# Eval("END_DATE", "{0:yyyy-MM-dd}") %></small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>