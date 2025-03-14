<%@ Page Title="" Language="C#" MasterPageFile="~/P_Member/MemberM.Master" AutoEventWireup="true" CodeBehind="SelectedProject.aspx.cs" Inherits="WorkNest.P_Member.SelectedProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Member_Head" runat="server">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
        }

            .card h4 {
                color: #4A6D85;
                border-bottom: 2px solid #8B9EB2;
                padding-bottom: 8px;
            }

        .label-title {
            font-weight: bold;
            color: #333;
            margin-top: 10px;
        }

        .detail-box {
            background: #F7F9FB;
            padding: 8px;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .table {
            background: #fff;
            border-radius: 5px;
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
    </style>
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="Member_Head_Title" runat="server">
    <h2 class="text-center text-primary">Project Details</h2>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Member_Content" runat="server">
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

                   
                   <%-- <asp:TemplateField HeaderText="Report File">
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
                    </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>

        </div>
    </div>
            <a href="Projects.aspx" class="floating-btn" title="Back to Tasks"><i class="fas fa-arrow-left"></i></a>

</asp:Content>
