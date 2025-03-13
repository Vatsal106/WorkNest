<%@ Page Title="" Language="C#" MasterPageFile="~/P_Member/MemberM.Master" AutoEventWireup="true" CodeBehind="RequestLeave.aspx.cs" Inherits="WorkNest.P_Member.RequestLeave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Member_Head" runat="server">
        <style>
        .leave-container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Member_Head_Title" runat="server">
    Add Leave
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Member_Content" runat="server">
     <div class="leave-container">
     <h2>Request Leave</h2>

     <div class="form-group">
         <label>Leave Type:</label>
         <asp:DropDownList ID="ddlLeaveType" runat="server" CssClass="form-control">
             <asp:ListItem Text="Paid Leave" Value="Paid"></asp:ListItem>
             <asp:ListItem Text="Unpaid Leave" Value="Unpaid"></asp:ListItem>
             <asp:ListItem Text="Sick Leave" Value="Sick"></asp:ListItem>
         </asp:DropDownList>
     </div>

     <div class="form-group">
         <label>From Date:</label>
         <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
     </div>

     <div class="form-group">
         <label>To Date:</label>
         <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
     </div>

     <div class="form-group">
         <label>Reason:</label>
         <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
     </div>

     <div class="form-group">
         <label>Attachment:</label>
         <asp:FileUpload ID="fileAttachment" runat="server" CssClass="form-control" />
     </div>

     <div class="form-group">
         <asp:Button ID="btnSubmit" runat="server" CssClass="btn-primary" Text="Submit" OnClick="btnSubmit_Click" />
     </div>

     <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
 </div>
</asp:Content>
