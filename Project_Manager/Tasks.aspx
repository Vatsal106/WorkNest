<%@ Page Title="Tasks" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="WorkNest.Project_Manager.Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <style>
        .task-table {
            width: 100%;
            border-collapse: collapse;
        }

        .task-table th, .task-table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        .task-table th {
            background-color: #007bff;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    <h2>My Assigned Tasks</h2>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <asp:GridView ID="gvTasks" runat="server" CssClass="task-table" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="TASK_ID" HeaderText="Task ID" />
            <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" />
            <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="DUE_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="STATUS" HeaderText="Status" />
            <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project" />
           
        </Columns>
    </asp:GridView>
</asp:Content>
