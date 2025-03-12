<%@ Page Title="Approve Leaves" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="ApproveLeaves.aspx.cs" Inherits="WorkNest.Admin.ApproveLeaves" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        /* General Page Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .leave-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }

        /* Dropdown Styling */
        #ddlStatusFilter {
            display: block;
            width: 100%;
            max-width: 250px;
            margin: 10px auto;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: white;
            cursor: pointer;
        }

        /* Table Styling */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            overflow-x: auto;
            display: block;
        }

            .table th {
                background: #007bff;
                color: white;
                padding: 12px;
                text-align: left;
            }

            .table td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            .table tr:nth-child(even) {
                background: #f9f9f9;
            }

            .table tr:hover {
                background: #f1f1f1;
                transition: 0.3s;
            }

        /* Buttons */
        .btn-approve, .btn-reject {
            padding: 8px 12px;
            font-size: 14px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease-in-out;
            text-transform: uppercase;
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

        /* Responsive Design */
        @media screen and (max-width: 1200px) { /* Laptops */
            .leave-container {
                max-width: 90%;
            }
        }

        @media screen and (max-width: 992px) { /* Tablets */
            .table th, .table td {
                font-size: 14px;
                padding: 10px;
            }

            .btn-approve, .btn-reject {
                padding: 6px 12px;
                font-size: 12px;
            }
        }

        @media screen and (max-width: 768px) { /* Large Mobiles */
            .leave-container {
                width: 95%;
                padding: 15px;
            }

            h2 {
                font-size: 22px;
            }

            #ddlStatusFilter {
                max-width: 100%;
                font-size: 14px;
            }

            .btn-approve, .btn-reject {
                font-size: 12px;
                padding: 6px 10px;
            }
        }

        @media screen and (max-width: 576px) { /* Medium Mobiles */
            .leave-container {
                width: 100%;
                padding: 10px;
            }

            .table th, .table td {
                font-size: 12px;
                padding: 8px;
            }

            .btn-approve, .btn-reject {
                padding: 5px 8px;
                font-size: 11px;
            }
        }

        @media screen and (max-width: 480px) { /* Small Mobiles */
            .leave-container {
                padding: 5px;
            }

            h2 {
                font-size: 18px;
            }

            .table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            .btn-approve, .btn-reject {
                padding: 4px 6px;
                font-size: 10px;
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

        <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
            <asp:ListItem Text="All" Value="All"></asp:ListItem>
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
        </asp:DropDownList>

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
                            NavigateUrl='<%# "~/Admin/DownloadReport.aspx?LeaveID=" + Eval("LEAVE_ID") %>'
                            Text="Download" CssClass="btn btn-info" />
                    </ItemTemplate>
                </asp:TemplateField>



                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("LEAVE_ID") %>' CssClass="btn-approve" Text="Approve" />
                        <asp:Button ID="btnReject" runat="server" CommandName="Reject" CommandArgument='<%# Eval("LEAVE_ID") %>' CssClass="btn-reject" Text="Reject" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
