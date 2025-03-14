<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="StatusOfYourLeave.aspx.cs" Inherits="WorkNest.Project_Manager.StatusOfYourLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <style>
        /* General Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #F7F9FB;
            margin: 0;
            padding: 0;
        }

        /* GridView Container */
        .grid-container {
            max-width: 90%;
            margin: 20px auto;
            overflow-x: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* GridView Styling */
        .grid-view {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
        }

            /* Table Header */
            .grid-view th {
                background: #4A6D85;
                color: white;
                text-align: left;
                padding: 10px;
                font-size: 16px;
            }

            /* Table Rows */
            .grid-view td {
                padding: 10px;
                border-bottom: 1px solid #ccc;
                font-size: 14px;
                text-align: left;
            }

            /* Alternate row colors */
            .grid-view tr:nth-child(even) {
                background: #E4F1F9;
            }

            /* Hover Effect */
            .grid-view tr:hover {
                background: #FF8C00;
                color: white;
                transition: 0.3s ease-in-out;
            }

        /* Status Badge Styling */
        .status-badge {
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 12px;
            display: inline-block;
        }

        .status-approved {
            background: #28a745;
            color: white;
        }

        .status-pending {
            background: #ffc107;
            color: black;
        }

        .status-rejected {
            background: #dc3545;
            color: white;
        }

        /* Download Button */
        .btn-download {
            display: inline-flex;
            align-items: center;
            text-decoration: none;
            background: #8B9EB2;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
        }

            .btn-download i {
                margin-right: 5px;
            }

            .btn-download:hover {
                background: #4A6D85;
            }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .grid-container {
                max-width: 100%;
                padding: 10px;
            }

            .grid-view th,
            .grid-view td {
                font-size: 13px;
                padding: 8px;
            }

            .btn-download {
                font-size: 12px;
                padding: 5px 10px;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    Leave Status
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="grid-container">
        <h2 style="text-align: center; color: #4A6D85;">Your Leave Status</h2>

        <asp:GridView ID="gvLeaves" runat="server" AutoGenerateColumns="False" CssClass="grid-view"
            HeaderStyle-BackColor="#8B9EB2" HeaderStyle-ForeColor="White" BorderColor="#333"
            CellPadding="6" BorderWidth="1px" Width="100%">
            <Columns>
                <asp:BoundField DataField="LEAVE_ID" HeaderText="Leave ID" />
                <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="LEAVE_TYPE" HeaderText="Leave Type" />
                <asp:BoundField DataField="REASON" HeaderText="Reason" />


                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("STATUS") %>'
                            CssClass='<%# GetStatusClass(Eval("STATUS").ToString()) %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Attachment">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkDownload" runat="server"
                            NavigateUrl='<%# "~/DownloadReport.aspx?LeaveID=" + Eval("LEAVE_ID") %>'
                            CssClass="btn-download" Visible='<%# Eval("FILE_NAME") != DBNull.Value %>'>
                            <i class="icon">📥</i> Download
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

