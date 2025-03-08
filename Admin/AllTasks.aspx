<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AllTasks.aspx.cs" Inherits="WorkNest.Admin.AllTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .task-container {
            max-width: 1000px;
            margin: auto;
            background: #F7F9FB;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .page-title {
            text-align: center;
            color: #4A6D85;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-box {
            width: 80%;
            padding: 10px;
            border: 1px solid #8B9EB2;
            border-radius: 5px;
            font-size: 16px;
        }

        .project-header {
            color: #333;
            font-size: 20px;
            margin-top: 20px;
        }

        .styled-table {
            width: 100%;
            border-collapse: collapse;
        }

            .styled-table th, .styled-table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .styled-table th {
                background: #8B9EB2;
                color: white;
            }

        .details-link {
            color: #FF8C00;
            font-weight: bold;
            text-decoration: none;
        }

            .details-link:hover {
                text-decoration: underline;
            }

        .no-tasks-message {
            color: #FF8C00;
            font-weight: bold;
            padding: 10px;
            display: block;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="task-container">
        <h1 class="page-title">📋 All Tasks</h1>

        <div class="search-container">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search by Project or Task..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
        </div>

        <asp:Repeater ID="rptProjects" runat="server" OnItemDataBound="rptProjects_ItemDataBound">
            <ItemTemplate>
                <h2 class="project-header"><%# Eval("PROJECT_NAME") %></h2>

                <asp:Label ID="lblNoTasks" runat="server" Text="No tasks available for this project." CssClass="no-tasks-message" Visible="false"></asp:Label>

                <asp:GridView ID="gvTaskReports" runat="server" AutoGenerateColumns="false" CssClass="styled-table">
                    <Columns>
                        <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
                        <asp:BoundField DataField="TASK_DESC" HeaderText="Task Description" />
<%--                        <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:dd-MMM-yyyy}" />--%>
                        <asp:BoundField DataField="DUE_DATE" HeaderText="Due Date" DataFormatString="{0:dd-MMM-yyyy}" />
                        <asp:BoundField DataField="STATUS" HeaderText="Status" />
                        <asp:BoundField DataField="ASSIGNED_TO" HeaderText="Assigned To" />
                        <asp:BoundField DataField="LAST_UPDATE" HeaderText="Last Updated" DataFormatString="{0:dd-MMM-yyyy}" />
                        <asp:TemplateField HeaderText="Details">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkTaskDetails" runat="server"
                                    NavigateUrl='<%# "TaskDetails.aspx?TaskID=" + Eval("TASK_ID") %>'
                                    CssClass="details-link"
                                    Text="View Details">
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkEditTask" runat="server"
                                    NavigateUrl='<%# "EditTask.aspx?TaskID=" + Eval("TASK_ID") %>'
                                    CssClass="details-link"
                                    Text="Edit">
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ItemTemplate>
        </asp:Repeater>

        <h2 class="project-header">Projects Without Tasks</h2>
        <asp:Label ID="lblNoProjectTasks" runat="server" CssClass="no-tasks-message"></asp:Label>

    </div>
</asp:Content>
