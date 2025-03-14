<%@ Page Title="" Language="C#" MasterPageFile="~/P_Member/MemberM.Master" AutoEventWireup="true" CodeBehind="MemberTaskDetails.aspx.cs" Inherits="WorkNest.P_Member.MemberTaskDetails" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Member_Head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        .task-details-container {
            max-width: 900px;
            margin: auto;
            padding: 20px;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }


        .card {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            transition: transform 0.2s ease-in-out;
        }

            .card:hover {
                transform: scale(1.02);
            }

        .card-header {
            font-size: 22px;
            font-weight: bold;
            color: #4A6D85;
            border-bottom: 2px solid #E4F1F9;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }

        .card-body p {
            font-size: 16px;
            color: #333;
            margin: 10px 0;
            display: flex;
            justify-content: space-between;
        }

            .card-body p strong {
                color: #4A6D85;
                font-weight: 600;
            }




        /* Table Styling */
        .table-container {
            overflow-x: auto;
        }

        .table th, .table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        .table th {
            background: #8B9EB2;
            color: white;
        }

        .table-hover tbody tr:hover {
            background: #E4F1F9;
        }


        .floating-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #FF8C00;
            color: white;
            padding: 12px 15px;
            border-radius: 50%;
            font-size: 18px;
            text-decoration: none;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease-in-out;
        }

            .floating-btn:hover {
                background: #e67e00;
            }


        @media (max-width: 768px) {
            .task-details-container {
                padding: 10px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Member_Head_Title" runat="server">Task Details </asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Member_Content" runat="server">

    <div class="task-details-container">


        <div class="card">
            <div class="card-header"><i class="fas fa-tasks"></i>Task Details</div>
            <div class="card-body">
                <p>
                    <strong><i class="fas fa-project-diagram"></i>Project Name:</strong>
                    <asp:Label ID="lblProjectName" runat="server" />
                </p>
                <p>
                    <strong><i class="fas fa-tasks"></i>Task Name:</strong>
                    <asp:Label ID="lblTaskName" runat="server" />
                </p>
                <p>
                    <strong><i class="fas fa-chart-line"></i>Status:</strong>
                    <asp:Label ID="lblStatus" runat="server" BackColor="Yellow" />
                </p>
                <p>
                    <strong><i class="fas fa-user"></i>Assigned To:</strong>
                    <asp:Label ID="lblAssignedTo" runat="server" />
                </p>
                <p>
                    <strong><i class="fas fa-calendar-alt"></i>Due Date:</strong>
                    <asp:Label ID="lblDueDate" runat="server" />
                </p>
                <p>
                    <strong><i class="fas fa-align-left"></i>Description:</strong>
                    <asp:Label ID="lblDescription" runat="server" />
                </p>


            </div>
            <div class="text-center" style="margin-bottom: 20px;">
                <asp:Button ID="btnSubmitReport" runat="server" Text="📝 Submit Report"
                    CssClass="btn btn-success"
                    OnClick="btnSubmitReport_Click" />
            </div>
        </div>


        <div class="card">
            <div class="card-header"><i class="fas fa-file-alt"></i>Latest Task Report</div>
            <div class="card-body">
                <p>
                    <strong><i class="fas fa-calendar"></i>Report Date:</strong>
                    <asp:Label ID="lblReportDate" runat="server" />
                </p>
                <p>
                    <strong><i class="fas fa-align-left"></i>Report Description:</strong>
                    <asp:Label ID="lblReportDescription" runat="server" />
                </p>

                <asp:HyperLink ID="lnkLatestReport" runat="server" Text="📥 Download Report" Visible="false" CssClass="btn btn-primary" />
            </div>
        </div>


        <div class="card">
            <div class="card-header"><i class="fas fa-history"></i>Task History</div>
            <div class="card-body">
                <div class="table-container">
                    <asp:GridView ID="gvTaskReportHistory" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover">
                        <Columns>
                            <asp:BoundField DataField="UPDATED_AT" HeaderText="Updated At" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" />
                            <asp:TemplateField HeaderText="Download Report">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkDownloadHistory" runat="server"
                                        NavigateUrl='<%# Eval("TaskHistoryURL") %>'
                                        Text="📥 Download"
                                        Visible='<%# Eval("TaskHistoryURL") != null && Eval("TaskHistoryURL").ToString() != "" %>'>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Button ID="btnDeleteHistory" runat="server" Text="🗑 Delete"
                                        CssClass="btn btn-danger btn-sm"
                                        OnClick="btnDeleteHistory_Click"
                                        CommandArgument='<%# Eval("TRH_ID") %>'
                                        OnClientClick="return confirm('Are you sure you want to delete this task report history?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>


        <a href="AllTasks.aspx" class="floating-btn" title="Back to Tasks"><i class="fas fa-arrow-left"></i></a>

    </div>
</asp:Content>
