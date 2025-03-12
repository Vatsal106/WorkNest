<%@ Page Title="Leave List" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="LeaveList.aspx.cs" Inherits="WorkNest.Project_Manager.LeaveList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <style>
        .leave-container {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }
        .btn-approve {
            background-color: green;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-reject {
            background-color: red;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    Leave Requests
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="leave-container">
        <h2>Leave Requests</h2>

        <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
            <asp:ListItem Text="All" Value="All"></asp:ListItem>
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
        </asp:DropDownList>

        <asp:GridView ID="gvLeaveRequests" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False" OnRowCommand="gvLeaveRequests_RowCommand">
            <Columns>
                <asp:BoundField DataField="LEAVE_ID" HeaderText="ID" />
                <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="Employee" />
                <%--<asp:BoundField DataField="LEAVE_TYPE" HeaderText="Type" />--%>
                <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="REASON" HeaderText="Reason" />
                <asp:BoundField DataField="STATUS" HeaderText="Status" />

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
