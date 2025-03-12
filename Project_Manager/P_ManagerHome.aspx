<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="P_ManagerHome.aspx.cs" Inherits="WorkNest.Project_Manager.P_ManagerHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />

    <style>
        /* General Styles */
        body {
            background-color: #f4f7fc;
            font-family: 'Arial', sans-serif;
        }

        .dashboard-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #333;
            margin-top: 20px;
        }

        /* Stats Cards */
        .stats-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            text-align: center;
            border-left: 5px solid #007bff;
            min-height: 150px;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .stats-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .stats-value {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .stats-label {
            font-size: 16px;
            color: #666;
        }

        /* Table Styles */
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .table-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #007bff;
            text-align: center;
        }

        .table th {
            background-color: #007bff !important;
            color: white !important;
            text-align: center;
        }

        .table tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .stats-card {
                min-height: 140px;
            }
        }

        @media (max-width: 768px) {
            .stats-card {
                padding: 15px;
            }

            .dashboard-title {
                font-size: 24px;
            }

            .stats-icon {
                font-size: 35px;
            }

            .stats-value {
                font-size: 22px;
            }

            .table-container {
                padding: 15px;
            }

            .table-title {
                font-size: 18px;
            }
        }

        @media (max-width: 480px) {
            .stats-card {
                padding: 12px;
                min-height: 120px;
            }

            .dashboard-title {
                font-size: 20px;
            }

            .stats-icon {
                font-size: 30px;
            }

            .stats-value {
                font-size: 20px;
            }

            .stats-label {
                font-size: 14px;
            }

            .table-container {
                padding: 10px;
            }

            .table-title {
                font-size: 16px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="PM_Title" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    <div class="dashboard-title">Project Manager Dashboard</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="container">
        <!-- Stats Row -->
        <div class="row mt-4">
            <div class="col-lg-3 col-md-6 col-sm-6 col-12 mb-3">
                <div class="stats-card">
                    <i class="fa-solid fa-users stats-icon text-primary"></i>
                    <div class="stats-value"><asp:Label ID="lblTotalEmployees" runat="server" Text="0"></asp:Label></div>
                    <div class="stats-label">Total Employees</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-12 mb-3">
                <div class="stats-card">
                    <i class="fa-solid fa-folder-open stats-icon text-success"></i>
                    <div class="stats-value"><asp:Label ID="lblTotalProjects" runat="server" Text="0"></asp:Label></div>
                    <div class="stats-label">Active Projects</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-12 mb-3">
                <div class="stats-card">
                    <i class="fa-solid fa-tasks stats-icon text-warning"></i>
                    <div class="stats-value"><asp:Label ID="lblTotalTasks" runat="server" Text="0"></asp:Label></div>
                    <div class="stats-label">Ongoing Tasks</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-12 mb-3">
                <div class="stats-card">
                    <i class="fa-solid fa-calendar-check stats-icon text-danger"></i>
                    <div class="stats-value"><asp:Label ID="lblPendingLeaves" runat="server" Text="0"></asp:Label></div>
                    <div class="stats-label">Pending Leaves</div>
                </div>
            </div>
        </div>

        <!-- Recent Projects Table -->
        <div class="table-container">
            <div class="table-title">Recent Projects</div>
            <asp:GridView ID="gvRecentProjects" runat="server" CssClass="table table-bordered table-striped text-center" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project Name" />
                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- Upcoming Leaves Table -->
        <div class="table-container">
            <div class="table-title">Upcoming Leaves</div>
            <asp:GridView ID="gvUpcomingLeaves" runat="server" CssClass="table table-bordered table-striped text-center" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="FULL_NAME" HeaderText="Employee Name" />
                    <asp:BoundField DataField="LEAVE_TYPE" HeaderText="Leave Type" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
