<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="SelectedProject.aspx.cs" Inherits="WorkNest.Admin.SelectedProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <style>
        body {
            background-color: #F7F9FB;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.15);
            background-color: white;
            padding: 25px;
            margin-bottom: 25px;
            transition: transform 0.2s ease-in-out;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h4 {
            color: #4A6D85;
            border-bottom: 3px solid #8B9EB2;
            padding-bottom: 10px;
            font-weight: bold;
        }

        .label-title {
            font-weight: 600;
            color: #333;
            margin-top: 10px;
        }

        .detail-box {
            background: #E4F1F9;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 12px;
            font-weight: 500;
        }

        .table {
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .table thead {
            background: #8B9EB2;
            color: white;
            font-weight: bold;
        }

        .floating-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #FF8C00;
            color: white;
            padding: 15px 18px;
            border-radius: 50%;
            font-size: 20px;
            text-decoration: none;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.25);
            transition: background 0.3s ease-in-out, transform 0.2s ease-in-out;
        }

        .floating-btn:hover {
            background: #e67e00;
            transform: scale(1.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    <h2 class="text-center text-primary">Project Details</h2>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfProjectID" runat="server" />

    <div class="container">
        <div class="card">
            <h4>Project Information</h4>
            <div class="row">
                <div class="col-md-6">
                    <label class="label-title">Name:</label>
                    <div class="detail-box">
                        <asp:Label ID="lblProjectName" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="label-title">Status:</label>
                    <div class="detail-box">
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-12">
                    <label class="label-title">Description:</label>
                    <div class="detail-box">
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="label-title">Start Date:</label>
                    <div class="detail-box">
                        <asp:Label ID="lblStartDate" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="label-title">End Date:</label>
                    <div class="detail-box">
                        <asp:Label ID="lblEndDate" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="label-title">Project Manager:</label>
                    <div class="detail-box">
                        <asp:Label ID="lblProjectManager" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="label-title">Client:</label>
                    <div class="detail-box">
                        <asp:Label ID="lblClient" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <h4>Project Tasks</h4>
            <asp:GridView ID="gvTasks" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered">
                <Columns>
                    <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
                    <asp:BoundField DataField="STATUS" HeaderText="Status" />
                    <asp:BoundField DataField="ASSIGN_TO" HeaderText="Assigned To" />
                    <asp:BoundField DataField="DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />

                    <asp:TemplateField HeaderText="Report File">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkDownloadReport" runat="server"
                                NavigateUrl='<%# Eval("DownloadLink") %>'
                                Text="Download" Visible='<%# Eval("DownloadLink") != DBNull.Value %>'>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Details">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkTaskDetails" runat="server"
                                NavigateUrl='<%# "TaskDetails.aspx?TaskID=" + Eval("TASK_ID") %>'
                                Text="View Details">
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <a href="Projects.aspx" class="floating-btn" title="Back to Tasks"><i class="fas fa-arrow-left"></i></a>
</asp:Content>
