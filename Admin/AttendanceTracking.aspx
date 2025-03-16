<%@ Page Title="Attendance Tracking" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AttendanceTracking.aspx.cs" Inherits="WorkNest.Admin.AttendanceTracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <title>Employee Attendance Tracking</title>
    <style>
        /* Calendar Styling */
        .calendar-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .aspNetCalendar {
            border-collapse: collapse;
            width: 100%;
            max-width: 300px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

            /* Header Styling */
            .aspNetCalendar th {
                background: #8B9EB2;
                color: white;
                font-weight: bold;
                padding: 12px;
            }

            /* Calendar Cell Styling */
            .aspNetCalendar td {
                text-align: center;
                padding: 10px;
                border: 1px solid #ddd;
                transition: 0.3s;
            }

            /* Current Day Highlight */
            .aspNetCalendar .TodayDayStyle {
                background: #FF8C00;
                color: white;
                font-weight: bold;
                border-radius: 50%;
            }

            /* Selected Day */
            .aspNetCalendar .SelectedDayStyle {
                background: #4A6D85;
                color: white;
                font-weight: bold;
                border-radius: 50%;
            }

            /* Hover Effect */
            .aspNetCalendar td:hover {
                background: #E4F1F9;
                cursor: pointer;
            }

            /* Weekend Styling */
            .aspNetCalendar .WeekendStyle {
                background: #F7F9FB;
                font-weight: bold;
            }

            /* Navigation Styling */
            .aspNetCalendar .PrevNextStyle {
                background: #4A6D85;
                color: white;
                font-size: 16px;
                padding: 8px;
                cursor: pointer;
            }

            /* Disable Past Dates */
            .aspNetCalendar .DisabledDayStyle {
                color: #ccc;
                pointer-events: none;
                background: #f0f0f0;
            }

        .container {
            width: 80%;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #4A6D85;
        }

        .calendar-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .filter-container {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            margin-right: 10px;
        }

        select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #E4F1F9;
            font-size: 14px;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            .gridview th {
                background-color: #8B9EB2;
                color: white;
                padding: 10px;
                border: 1px solid #ccc;
            }

            .gridview td {
                padding: 10px;
                border: 1px solid #ccc;
                background-color: #fff;
            }

        .absent {
            color: red;
            font-weight: bold;
        }

        .present {
            color: green;
            font-weight: bold;
        }

        .gridview tr:nth-child(even) {
            background-color: #E4F1F9;
        }
    </style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Employee Attendance Tracking
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Employee Attendance Tracking</h2>

        <div class="calendar-container">
            <asp:Calendar ID="Calendar1" runat="server"
                CssClass="aspNetCalendar"
                OnSelectionChanged="Calendar1_SelectionChanged"
                DayHeaderStyle-CssClass="HeaderStyle"
                NextPrevStyle-CssClass="PrevNextStyle"
                TodayDayStyle-CssClass="TodayDayStyle"
                SelectedDayStyle-CssClass="SelectedDayStyle"
                WeekendDayStyle-CssClass="WeekendStyle"
                DayStyle-CssClass="DayStyle"
                OtherMonthDayStyle-CssClass="DisabledDayStyle"></asp:Calendar>
        </div>


        <div class="filter-container">
            <label for="ddlDepartment">Select Department:</label>
            <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged"></asp:DropDownList>
        </div>

        <asp:GridView ID="gvAttendance" runat="server" CssClass="gridview" AutoGenerateColumns="False" BorderWidth="1">
            <Columns>
                <asp:BoundField DataField="FULL_NAME" HeaderText="Employee Name" />
                <asp:BoundField DataField="DEPARTMENT_NAME" HeaderText="Department" />
                <asp:BoundField DataField="LOGIN_TIME" HeaderText="First Login" DataFormatString="{0:hh:mm tt}" />
                <asp:BoundField DataField="LOGOUT_TIME" HeaderText="Last Logout" DataFormatString="{0:hh:mm tt}" />
                <asp:BoundField DataField="TOTAL_HOURS" HeaderText="Total Hours Worked" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <%# Eval("STATUS").ToString() == "Absent" ? "<span class='absent'>Absent</span>" : "<span class='present'>Present</span>" %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblError" runat="server"></asp:Label>
    </div>

</asp:Content>
