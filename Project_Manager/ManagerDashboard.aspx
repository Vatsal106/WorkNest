<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="ManagerDashboard.aspx.cs" Inherits="WorkNest.Project_Manager.P_ManagerHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />

    <style>
        body {
            background-color: #F7F9FB;
            font-family: 'Arial', sans-serif;
        }
        .dashboard-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #333333;
            margin: 20px 0;
        }
        .stats-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .stats-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 23%;
            min-height: 150px;
        }
        .stats-card i {
            font-size: 40px;
            margin-bottom: 10px;
        }
        .stats-value {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
        }
        .section-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .table th {
            background-color: #4A6D85 !important;
            color: white !important;
        }
        .table tbody tr:hover {
            background-color: rgba(74, 109, 133, 0.1);
        }
        @media (max-width: 768px) {
            .stats-card {
                width: 48%;
            }
        }
        @media (max-width: 480px) {
            .stats-card {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="PM_Title" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    <div class="dashboard-title">Project Manager Dashboard</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="container">
        <div class="stats-container">
            <div class="stats-card text-primary">
                <i class="fa-solid fa-users"></i>
                <div class="stats-value"><asp:Label ID="lblTotalEmployees" runat="server" Text="0"></asp:Label></div>
                <div>Total Employees</div>
            </div>
            <div class="stats-card text-success">
                <i class="fa-solid fa-folder-open"></i>
                <div class="stats-value"><asp:Label ID="lblTotalProjects" runat="server" Text="0"></asp:Label></div>
                <div>Completed Projects</div>
            </div>
            <div class="stats-card text-warning">
                <i class="fa-solid fa-tasks"></i>
                <div class="stats-value"><asp:Label ID="lblTotalTasks" runat="server" Text="0"></asp:Label></div>
                <div>Ongoing Tasks</div>
            </div>
            <div class="stats-card text-danger">
                <i class="fa-solid fa-calendar-check"></i>
                <div class="stats-value"><asp:Label ID="lblPendingLeaves" runat="server" Text="0"></asp:Label></div>
                <div>Pending Leaves</div>
            </div>
        </div>

        <div class="section-container">
            <h4 class="text-primary">Project Overview</h4>
            <asp:GridView ID="gvProjectOverview" runat="server" CssClass="table table-bordered table-striped text-center" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project Name" />
                    <asp:BoundField DataField="CLIENT_NAME" HeaderText="Client Name" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="STATUS" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="section-container">
            <h4 class="text-primary">Task Management</h4>
            <asp:GridView ID="gvTaskManagement" runat="server" CssClass="table table-bordered table-striped text-center" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="STATUS" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="section-container">
            <h4 class="text-primary">Team Members & Workload</h4>
            <asp:GridView ID="gvTeamMembers" runat="server" CssClass="table table-bordered table-striped text-center" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="FULL_NAME" HeaderText="Full Name" />
                    <asp:BoundField DataField="EMAIL" HeaderText="Email" />
                    <asp:BoundField DataField="ROLE" HeaderText="Role" />
                </Columns>
            </asp:GridView>
        </div>
   



        <!-- Leave Requests Management -->
        <div class="section-container">
            <div class="text-primary">Leave Requests Management</div>
            <asp:GridView ID="gvLeaveRequests" runat="server" CssClass="table table-bordered table-striped text-center" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="Employee Name" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="REASON" HeaderText="Reason" />
                    <asp:BoundField DataField="STATUS" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- Activity Log & Task Report History -->
        <div class="section-container">
            <div class="text-primary">Activity Log & Task Report History</div>
            <asp:GridView ID="gvActivityLog" runat="server" CssClass="table table-bordered table-striped text-center" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
                    <asp:BoundField DataField="UPDATE_TIME" HeaderText="Update Time" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" />
                    <asp:BoundField DataField="FILE_ATTACHMENT" HeaderText="File Attachment" />
                </Columns>
            </asp:GridView>
        </div>
     </div>
</asp:Content>
