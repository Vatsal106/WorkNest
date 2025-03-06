<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="TaskDetails.aspx.cs" Inherits="WorkNest.Admin.TaskDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server"></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Task Information Section -->
    <div class="card">
        <div class="card-header">
            <h3>Task Details</h3>
        </div>
        <div class="card-body">
            <p><strong>Project Name:</strong>
                <asp:Label ID="lblProjectName" runat="server" /></p>
            <p><strong>Task Name:</strong>
                <asp:Label ID="lblTaskName" runat="server" /></p>
            <p><strong>Status:</strong>
                <asp:Label ID="lblStatus" runat="server" /></p>
            <p><strong>Assigned To:</strong>
                <asp:Label ID="lblAssignedTo" runat="server" /></p>
            <p><strong>Due Date:</strong>
                <asp:Label ID="lblDueDate" runat="server" /></p>
            <p><strong>Description:</strong>
                <asp:Label ID="lblDescription" runat="server" /></p>
        </div>
    </div>

    <!-- Task Report Section -->
    <div class="card mt-3">
        <div class="card-header">
            <h3>Latest Task Report</h3>
        </div>
        <div class="card-body">
            <p><strong>Report Date:</strong>
                <asp:Label ID="lblReportDate" runat="server" /></p>
            <p><strong>Report Description:</strong>
                <asp:Label ID="lblReportDescription" runat="server" /></p>
            <asp:HyperLink ID="lnkLatestReport" runat="server" Text="Download Report" Visible="false" CssClass="btn btn-primary"  />
        </div>
    </div>

    <!-- Task History Section -->
    <div class="card mt-3">
        <div class="card-header">
            <h3>Task History</h3>
        </div>
        <div class="card-body">
            <asp:GridView ID="gvTaskReportHistory" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered">
                <Columns>
                    <asp:BoundField DataField="UPDATED_AT" HeaderText="Updated At" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" />
                    <asp:TemplateField HeaderText="Task History Report">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkDownloadHistory" runat="server"
                                NavigateUrl='<%# Eval("TaskHistoryURL") %>'
                                Text="Download" Visible='<%# Eval("TaskHistoryURL") != null && Eval("TaskHistoryURL").ToString() != "" %>'>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
