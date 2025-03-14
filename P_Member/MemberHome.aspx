<%@ Page Title="Member Home" Language="C#" MasterPageFile="~/P_Member/MemberM.Master" AutoEventWireup="true" CodeBehind="MemberHome.aspx.cs" Inherits="WorkNest.P_Member.MemberHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Member_Head" runat="server">
    <style>
        :root {
            --primary-color: #007bff;
            --secondary-color: #f8f9fa;
            --text-color: #333;
            --card-bg: #fff;
            --border-radius: 12px;
            --shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #eef1f7;
            color: var(--text-color);
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }

        .profile-card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            text-align: left;
            margin-bottom: 40px;
        }

        .profile-card h2 {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 5px;
            font-family: 'Roboto', sans-serif;
        }

        .section {
            background: var(--card-bg);
            padding: 20px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin-bottom: 40px;
        }

        .section h2 {
            font-size: 24px;
            color: var(--primary-color);
            font-weight: bold;
            border-bottom: 3px solid var(--primary-color);
            padding-bottom: 10px;
            font-family: 'Roboto', sans-serif;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background: var(--primary-color);
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background: #f2f2f2;
        }

        /* Responsive */
        @media (max-width: 768px) {
            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Member_Content" runat="server">
    <div class="container">
        <div class="profile-card">
            <h2 id="lblFullName" runat="server"></h2>
            <p>Email: <span id="lblEmail" runat="server"></span></p>
            <p>Phone: <span id="lblPhone" runat="server"></span></p>
        </div>

        <div class="section">
            <h2>Project Details</h2>
            <table>
                <thead>
                    <tr>
                        <th>Project Name</th>
                        <th>Description</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="projectDetails" runat="server"></tbody>
            </table>
        </div>

        <div class="section">
            <h2>Leave History</h2>
            <table>
                <thead>
                    <tr>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Leave Type</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="leaveHistory" runat="server"></tbody>
            </table>
        </div>

        <div class="section">
            <h2>My Tasks</h2>
            <table>
                <thead>
                    <tr>
                        <th>Task Name</th>
                        <th>Description</th>
                        <th>Start Date</th>
                        <th>Due Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="tasksList" runat="server"></tbody>
            </table>
        </div>

        <div class="section">
            <h2>Activity Log</h2>
            <table>
                <thead>
                    <tr>
                        <th>Task</th>
                        <th>Activity</th>
                        <th>Updated At</th>
                    </tr>
                </thead>
                <tbody id="activityLog" runat="server"></tbody>
            </table>
        </div>
    </div>
</asp:Content>
