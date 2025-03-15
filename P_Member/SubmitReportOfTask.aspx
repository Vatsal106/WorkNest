<%@ Page Title="" Language="C#" MasterPageFile="~/P_Member/MemberM.Master" AutoEventWireup="true" CodeBehind="SubmitReportOfTask.aspx.cs" Inherits="WorkNest.P_Member.SubmitReportOfTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Member_Head" runat="server">
    <style>
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
<asp:Content ID="Content2" ContentPlaceHolderID="Member_Head_Title" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Member_Content" runat="server">
    <div class="container mt-4">
        <h2 class="mb-3">Insert Task Report</h2>
        <div class="card p-4 shadow-sm">
            <asp:HiddenField ID="hfTaskID" runat="server" />
            <div class="mb-3">
                <label for="ddlTasks" class="form-label">Select Task:</label>
                <asp:DropDownList ID="ddlTasks" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlTasks_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <asp:Label ID="Label1" runat="server" Text="Task Name: "></asp:Label>
                <asp:Label ID="txtTaskName" runat="server" class="form-label"></asp:Label>
            </div>
            <div class="mb-3">
                <label for="txttaskDescription" class="form-label">Task Description:</label>
                <asp:Label ID="txttaskDescription" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="mb-3">

                <label>Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select"></asp:ListItem>
                    <asp:ListItem Text="NOT STARTED" Value="NOT STARTED"></asp:ListItem>
                    <asp:ListItem Text="HOLD" Value="ON HOLD"></asp:ListItem>
                    <asp:ListItem Text="IN PROGRESS" Value="IN PROGRESS"></asp:ListItem>
                    <asp:ListItem Text="COMPLETED" Value="COMPLETED"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <label for="txtDescription" class="form-label">Report Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
            </div>
            <div class="mb-3">
                <label for="fuReport" class="form-label">Report File:</label>
                <asp:FileUpload ID="fuReport" runat="server" CssClass="form-control" />
                <asp:Label ID="lblLastUpdate" runat="server" Text="" CssClass="text-muted"></asp:Label>
            </div>
            <div class="text-center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" OnClick="btnClear_Click" />
            </div>
            <div class="mt-3 text-center">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-success" />
            </div>
        </div>
          <a href="MemberTasks.aspx" class="floating-btn" title="Back to Tasks"><i class="fas fa-arrow-left"></i></a>
    </div>
</asp:Content>
