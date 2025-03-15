<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="EmployeeDetails.aspx.cs" Inherits="WorkNest.Admin.EmployeeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        /* Employee Details Container */
        .employee-details-container {
            max-width: 900px;
            margin: auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Employee Information */
        .employee-info {
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 2px solid #ddd;
        }

        .profile-img {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #8B9EB2;
            box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.15);
        }

        /* GridView Styling */
        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.08);
        }

        .table th {
            background: #8B9EB2;
            color: white;
            padding: 12px;
            text-align: left;
        }

        .table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        .table tr:hover {
            background: #E4F1F9;
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

        /* Project and Task Sections */
        .project-section {
            margin-top: 30px;
        }

        .project-card {
            background: #f9f9f9;
            padding: 15px;
            margin: 15px 0;
            border-radius: 8px;
            box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.08);
        }

        .task-item {
            background: white;
            padding: 12px;
            border-radius: 5px;
            margin: 8px 0;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.08);
        }

        /* Button Styling */
        .btn-primary {
            background: #FF8C00;
            color: white;
            padding: 8px 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-primary:hover {
            background: #e07a00;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Employee Details
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="employee-details-container">
        <!-- Employee Info -->
        <div class="employee-info">
            <img id="employeePhoto" runat="server" class="profile-img" />
            <h2 id="employeeName" runat="server"></h2>
            <p><strong>Email:</strong> <span id="employeeEmail" runat="server"></span></p>
            <p><strong>Phone:</strong> <span id="employeePhone" runat="server"></span></p>
            <p><strong>Department:</strong> <span id="employeeDepartment" runat="server"></span></p>
            <p><strong>Role:</strong> <span id="employeeRole" runat="server"></span></p>
        </div>

        <!-- Projects GridView -->
        <div class="project-section">
            <h3>Assigned Projects</h3>
            <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="False" CssClass="table">
                <Columns>
                    <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project Name" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:dd-MMM-yyyy}" />
                    <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:dd-MMM-yyyy}" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- Task List by Project -->
        <div class="project-section">
            <h3>Assigned Tasks</h3>
            <asp:Repeater ID="rptTasks" runat="server">
                <ItemTemplate>
                    <div class="project-card">
                        <h4><%# Eval("ProjectName") %></h4>
                        <asp:GridView ID="gvTasks" runat="server" AutoGenerateColumns="False" CssClass="table" DataSource='<%# Eval("Tasks") %>'>
                            <Columns>
                                <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
                                <asp:BoundField DataField="STATUS" HeaderText="Status" />
                                <asp:BoundField DataField="DUE_DATE" HeaderText="Deadline" DataFormatString="{0:dd-MMM-yyyy}" />
                                <asp:TemplateField HeaderText="Details & Rports">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDetails" runat="server" Text="View Details" CssClass="btn-primary"
                                            OnClick="btnDetails_Click" CommandArgument='<%# Eval("TASK_ID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <a href="Employees.aspx" class="floating-btn" title="Back to Employees"><i class="fas fa-arrow-left"></i></a>
    </div>
</asp:Content>
