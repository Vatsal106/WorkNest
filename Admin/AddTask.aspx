<%@ Page Title="Add Task" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AddTask.aspx.cs" Inherits="WorkNest.Admin.AddTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        body {
            background-color: #f4f7f8;
        }


        .form-container {
            max-width: 600px;
            margin: 0px auto;
            padding: 25px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

            .form-container:hover {
                box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.15);
            }


        label {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
            display: block;
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


        .form-control {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            background-color: #f9f9f9;
            transition: border 0.3s ease, box-shadow 0.3s ease;
        }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.2);
                outline: none;
            }


            .form-control select {
                cursor: pointer;
            }


        .btn-primary {
            background: linear-gradient(to right, #007bff, #0056b3);
            border: none;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 8px;
            color: white;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
            width: 100%;
        }

            .btn-primary:hover {
                background: linear-gradient(to right, #0056b3, #003c7e);
                transform: scale(1.05);
            }


        @media screen and (max-width: 425px) {
            .form-container {
                max-width: 90%;
                padding: 20px;
            }
        }

        @media screen and (max-width: 768px) {
            .form-container {
                max-width: 85%;
            }
        }

        @media screen and (min-width: 1024px) {
            .form-container {
                max-width: 50%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    <h2 class="text-center">Add New Task</h2>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="text-center">Add New Task</h2>
    <div class="container">
        <div class="form-container">
            <div class="mb-3">
                <label for="txtTaskName">Task Name:</label>
                <asp:TextBox ID="txtTaskName" runat="server" CssClass="form-control"></asp:TextBox>
                <span id="taskNameError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label for="ddlProject">Project:</label>
                <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Project" Value="" />
                </asp:DropDownList>
                <span id="projectError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label for="txtDescription">Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                <span id="descriptionError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label for="txtStartDate">Start Date:</label>
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <span id="startDateError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label for="txtDueDate">Due Date:</label>
                <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <span id="dueDateError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label for="ddlStatus">Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Status" Value="" />
                    <asp:ListItem Text="Completed" Value="COMPLETED" />
                    <asp:ListItem Text="In Progress" Value="IN PROGRESS" />
                    <asp:ListItem Text="Not Started" Value="NOT STARTED" />
                    <asp:ListItem Text="On Hold" Value="ON HOLD" />
                </asp:DropDownList>
                <span id="statusError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label for="ddlDepartment">Department:</label>
                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                </asp:DropDownList>
                <span id="departmentError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label for="ddlAssignTo">Assign To:</label>
                <asp:DropDownList ID="ddlAssignTo" runat="server" CssClass="form-control"></asp:DropDownList>
                <span id="assignToError" class="text-danger"></span>
            </div>

            <div class="text-center">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Add Task" OnClick="btnSubmit_Click"
                    OnClientClick="return validateForm();" />
            </div>
        </div>
        <a href="AllTasks.aspx" class="floating-btn" title="Back to Tasks"><i class="fas fa-arrow-left"></i></a>
    </div>

    <script>
        function validateForm() {
            let isValid = true;

            // Get input values
            let taskName = document.getElementById('<%= txtTaskName.ClientID %>').value.trim();
            let project = document.getElementById('<%= ddlProject.ClientID %>').value;
            let description = document.getElementById('<%= txtDescription.ClientID %>').value.trim();
            let startDate = document.getElementById('<%= txtStartDate.ClientID %>').value;
            let dueDate = document.getElementById('<%= txtDueDate.ClientID %>').value;
            let status = document.getElementById('<%= ddlStatus.ClientID %>').value;
            let department = document.getElementById('<%= ddlDepartment.ClientID %>').value;
            let assignTo = document.getElementById('<%= ddlAssignTo.ClientID %>').value;

            // Clear previous errors
            document.getElementById("taskNameError").innerText = "";
            document.getElementById("projectError").innerText = "";
            document.getElementById("descriptionError").innerText = "";
            document.getElementById("startDateError").innerText = "";
            document.getElementById("dueDateError").innerText = "";
            document.getElementById("statusError").innerText = "";
            document.getElementById("departmentError").innerText = "";
            document.getElementById("assignToError").innerText = "";

            // Validate fields
            if (taskName === "") {
                document.getElementById("taskNameError").innerText = "Task Name is required.";
                isValid = false;
            }

            if (project === "") {
                document.getElementById("projectError").innerText = "Please select a project.";
                isValid = false;
            }

            if (description === "") {
                document.getElementById("descriptionError").innerText = "Description is required.";
                isValid = false;
            }

            if (startDate === "") {
                document.getElementById("startDateError").innerText = "Start Date is required.";
                isValid = false;
            }

            if (dueDate === "") {
                document.getElementById("dueDateError").innerText = "Due Date is required.";
                isValid = false;
            }

            if (startDate !== "" && dueDate !== "") {
                let start = new Date(startDate);
                let due = new Date(dueDate);
                if (due <= start) {
                    document.getElementById("dueDateError").innerText = "Due Date must be after Start Date.";
                    isValid = false;
                }
            }

            if (status === "") {
                document.getElementById("statusError").innerText = "Please select a status.";
                isValid = false;
            }

            if (department === "") {
                document.getElementById("departmentError").innerText = "Please select a department.";
                isValid = false;
            }

            if (assignTo === "") {
                document.getElementById("assignToError").innerText = "Please select an assignee.";
                isValid = false;
            }

            return isValid;
        }
    </script>
</asp:Content>
