<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="EmployeesUnderYou.aspx.cs" Inherits="WorkNest.Project_Manager.EmployeesUnderYou" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
        <style>
        /* Main Container */
        .employee-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            padding: 30px;
            justify-content: center;
            max-width: 1300px;
            margin: auto;
        }

        /* Employee Card */
        .employee-card {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0px 12px 35px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 24px;
            transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
            border: 1px solid #ddd;
            position: relative;
            overflow: hidden;
        }

            .employee-card:hover {
                transform: translateY(-10px);
                box-shadow: 0px 14px 40px rgba(0, 0, 0, 0.2);
                background: #f8f9fa;
            }

            /* Employee Image */
            .employee-card img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid white;
                transition: transform 0.3s ease, border-color 0.3s ease;
            }

            .employee-card:hover img {
                transform: scale(1.08);
                border-color: #ddd;
            }

            /* Employee Details */
            .employee-card h3 {
                margin-top: 12px;
                font-size: 22px;
                font-weight: bold;
                color: #333;
            }

            .employee-card p {
                font-size: 15px;
                color: #555;
                margin: 6px 0;
            }

        /* Buttons */
        .action-buttons {
            margin-top: 18px;
            display: flex;
            justify-content: center;
            gap: 14px;
        }

        .btn {
            padding: 10px 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
            display: flex;
            align-items: center;
            gap: 8px;
            text-transform: uppercase;
        }

        .btn-update {
            background: #007bff;
            color: white;
            box-shadow: 0 5px 10px rgba(0, 123, 255, 0.3);
        }

        .btn-delete {
            background: #dc3545;
            color: white;
            box-shadow: 0 5px 10px rgba(220, 53, 69, 0.3);
        }

        .btn-update:hover {
            background: #0056b3;
            box-shadow: 0 6px 14px rgba(0, 123, 255, 0.5);
            transform: scale(1.05);
        }

        .btn-delete:hover {
            background: #c82333;
            box-shadow: 0 6px 14px rgba(220, 53, 69, 0.5);
            transform: scale(1.05);
        }

        .btn-details {
            background: #28a745;
            color: white;
            box-shadow: 0 5px 10px rgba(40, 167, 69, 0.3);
        }

            .btn-details:hover {
                background: #218838;
                box-shadow: 0 6px 14px rgba(40, 167, 69, 0.5);
                transform: scale(1.05);
            }

        /* Search Bar */
        .search-container {
            margin-left: 20%;
            margin-right: 20%;
            width: 60%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 25px;
            position: relative;
        }

            .search-container input {
                width: 80%;
                padding: 12px;
                font-size: 16px;
                border-radius: 8px;
                border: 1px solid #ccc;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease-in-out;
            }

                .search-container input:focus {
                    border-color: #007bff;
                    box-shadow: 0 5px 12px rgba(0, 123, 255, 0.3);
                    outline: none;
                }

            .search-container .btn {
                width: 20%;
                margin-left: 12px;
            }

        /* Responsive Design */
        @media (max-width: 768px) {
            .search-container input {
                width: 100%;
            }

            .employee-container {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }

            .employee-card {
                padding: 20px;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    Employees under You!!
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="search-container">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search employees..." />
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
    </div>

    <!-- Employee List -->
    <div class="employee-container">
        <asp:Repeater ID="rptEmployees" runat="server" OnItemCommand="rptEmployees_ItemCommand">
            <ItemTemplate>
                <div class="employee-card">
                    <img src='<%# Eval("IMAGE_BASE64") %>' alt="Employee Photo">
                    <h3><%# Eval("FULL_NAME") %></h3>
                    <p><strong>Email:</strong> <%# Eval("EMAIL") %></p>
                    <p><strong>Phone:</strong> <%# Eval("PHONE_NUMBER") %></p>
                    <p><strong>Hire Date:</strong> <%# Eval("HIRE_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>Department:</strong> <%# Eval("DEPARTMENT_NAME") %></p>
                    <p><strong>Role:</strong> <%# Eval("ROLE_NAME") %></p>

                    <div class="action-buttons">

                        <%--<asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update"
                            OnClientClick='<%# "window.location.href=\"../UpdateEmployee.aspx?EmployeeID=" + Eval("EMPLOYEE_ID") + "\"; return false;" %>' />

                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete"
                            CommandName="DeleteEmployee" CommandArgument='<%# Eval("EMPLOYEE_ID") %>'
                            OnClientClick="return confirm('Are you sure you want to delete this employee?');" />--%>
                        <asp:Button ID="btnDetails" runat="server" Text="See Details" CssClass="btn btn-details"
                            OnClientClick='<%# "window.location.href=\"EmployeeDetails.aspx?EmployeeID=" + Eval("EMPLOYEE_ID") + "\"; return false;" %>' />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

