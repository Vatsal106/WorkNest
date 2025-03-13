<%@ Page Title="Approve Leaves" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="ApproveLeaves.aspx.cs" Inherits="WorkNest.Admin.ApproveLeaves" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        /* Page Layout */
        .leave-container {
            max-width: auto;
            margin: 30px;
            padding: 25px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.15);
            transition: 0.3s ease-in-out;
        }

        .leave-container:hover {
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.18);
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Dropdown Styling */
        .ddlStatusFilter {
            display: block;
            width: 260px;
            margin: 15px auto;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background: #fff;
            cursor: pointer;
            text-align: center;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            transition: 0.3s;
        }

        .ddlStatusFilter:hover {
            border-color: #4A6D85;
        }

        /* Table Styling */
        .table-container {
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .table th {
            background: #4A6D85;
            color: white;
            padding: 15px;
            text-align: left;
            font-size: 16px;
            border-radius: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 14px;
            font-size: 15px;
            border-bottom: 1px solid #ddd;
        }

        .table tr:nth-child(even) {
            background: #f9f9f9;
        }

        .table tr:hover {
            background: #E4F1F9;
            transition: 0.3s;
        }

        /* Buttons */
        .action-bottons {
            display: flex;
            gap: 5px;
            justify-content: center;
        }
        .btn-approve, .btn-reject, .btn-download {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            font-size: 15px;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            text-transform: uppercase;
            transition: all 0.3s ease-in-out;
            font-weight: 500;
        }

        .btn-approve {
            background-color: #28a745;
            color: white;
        }

        .btn-approve:hover {
            background-color: #218838;
        }

        .btn-reject {
            background-color: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background-color: #c82333;
        }

        .btn-download {
            background-color: #FF8C00;
            color: white;
            text-decoration:none;
        }

        .btn-download:hover {
            background-color: #d97700;
        }

        /* Icons */
        .icon {
            font-size: 16px;
        }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .leave-container {
                width: 95%;
                padding: 20px;
            }

            h2 {
                font-size: 24px;
            }

            #ddlStatusFilter {
                width: 100%;
                font-size: 14px;
            }

            .btn-approve, .btn-reject, .btn-download {
                font-size: 13px;
                padding: 8px 12px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Header_Title" runat="server">
    Approve Leaves - Project Managers
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="leave-container">
        <h2>Approve Leaves - Project Managers</h2>

        <asp:DropDownList ID="ddlStatusFilter" CssClass="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
            <asp:ListItem Text="All" Value="All"></asp:ListItem>
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
        </asp:DropDownList>

        <div class="table-container">
            <asp:GridView ID="gvProjectManagerLeaves" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False" OnRowCommand="gvProjectManagerLeaves_RowCommand">
                <Columns>
                    <asp:BoundField DataField="LEAVE_ID" HeaderText="ID" />
                    <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="Project Manager" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="REASON" HeaderText="Reason" />
                    <asp:BoundField DataField="STATUS" HeaderText="Status" />

                    <asp:TemplateField HeaderText="Attachment">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkDownload" runat="server"
                                NavigateUrl='<%# "~/DownloadReport.aspx?LeaveID=" + Eval("LEAVE_ID") %>'
                                CssClass="btn-download">
                                <i class="icon">📥</i> Download
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate >
                            <div Class="action-bottons">
                            <asp:Button ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("LEAVE_ID") %>' CssClass="btn-approve" Text="✔Approve" />
                            <asp:Button ID="btnReject" runat="server" CommandName="Reject" CommandArgument='<%# Eval("LEAVE_ID") %>' CssClass="btn-reject" Text="✖Reject" />
                        </div></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
