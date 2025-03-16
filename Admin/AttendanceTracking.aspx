<%@ Page Title="Attendance Tracking" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AttendanceTracking.aspx.cs" Inherits="WorkNest.Admin.AttendanceTracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <title>Employee Attendance Tracking</title>
    <style>
        .gridview th, .gridview td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .absent {
            color: red;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Employee Attendance Tracking
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged"></asp:Calendar>

    <br />

    <label for="ddlDepartment">Select Department:</label>
    <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
    </asp:DropDownList>

    <br /><br />

    <asp:GridView ID="gvAttendance" runat="server" CssClass="gridview" AutoGenerateColumns="False" BorderWidth="1">
        <Columns>
            <asp:BoundField DataField="FULL_NAME" HeaderText="Employee Name" />
            <asp:BoundField DataField="DEPARTMENT_NAME" HeaderText="Department" />
            <asp:BoundField DataField="LOGIN_TIME" HeaderText="First Login" DataFormatString="{0:hh:mm tt}" />
            <asp:BoundField DataField="LOGOUT_TIME" HeaderText="Last Logout" DataFormatString="{0:hh:mm tt}" />
            <asp:BoundField DataField="TOTAL_HOURS" HeaderText="Total Hours Worked" />
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <%# Eval("STATUS").ToString() == "Absent" ? "<span class='absent'>Absent</span>" : Eval("STATUS") %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
