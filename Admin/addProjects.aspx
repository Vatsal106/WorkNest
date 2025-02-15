<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="addProjects.aspx.cs" Inherits="WorkNest.Admin.addProjects" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.3);
            max-width: 700px;
            margin: auto;
            text-align: center;
        }
        .form-container h2 {
            color: #0D0D30;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .form-container div {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }
        .form-container label {
            font-weight: bold;
            color: #0D0D30;
            text-align: left;
            width: 100%;
        }
        .form-container input, .form-container select, .form-container textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
            box-sizing: border-box;
        }
        .button-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            width: 100%;
        }
        .btn-custom {
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            background-color: #FF8C00;
            color: white;
            border: none;
            cursor: pointer;
        }
        .btn-custom:hover {
            background: #e07b00;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let startDate = document.getElementById('<%= dateStart.ClientID %>');
            let endDate = document.getElementById('<%= dateEnd.ClientID %>');

            // Get today's date in YYYY-MM-DD format
            let today = new Date().toISOString().split('T')[0];

            // Set min attribute for Start Date
            startDate.setAttribute("min", today);

            // Ensure End Date is not before Start Date
            startDate.addEventListener("change", function () {
                endDate.setAttribute("min", startDate.value);
            });
        });

        function validateForm() {
            let projectName = document.getElementById('<%= txtProjectName.ClientID %>').value.trim();
            let description = document.getElementById('<%= txtDesc.ClientID %>').value.trim();
            let startDate = document.getElementById('<%= dateStart.ClientID %>').value;
            let endDate = document.getElementById('<%= dateEnd.ClientID %>').value;
            let status = document.getElementById('<%= ddlStatus.ClientID %>').value;
            let projectManager = document.getElementById('<%= ddlProjectManager.ClientID %>').value;
            let client = document.getElementById('<%= ddlClient.ClientID %>').value;
            let errorLabel = document.getElementById('<%= lblError.ClientID %>');

            errorLabel.innerHTML = ""; // Clear previous errors
            errorLabel.style.color = "red";

            if (projectName === "") {
                errorLabel.innerHTML = "Project Name is required.";
                return false;
            }
            if (description === "") {
                errorLabel.innerHTML = "Description is required.";
                return false;
            }
            if (startDate === "") {
                errorLabel.innerHTML = "Start Date is required.";
                return false;
            }
            if (endDate === "") {
                errorLabel.innerHTML = "End Date is required.";
                return false;
            }
            if (new Date(startDate) < new Date()) {
                errorLabel.innerHTML = "Start Date cannot be in the past.";
                return false;
            }
            if (new Date(startDate) > new Date(endDate)) {
                errorLabel.innerHTML = "Start Date cannot be later than End Date.";
                return false;
            }
            if (status === "0") {
                errorLabel.innerHTML = "Please select a Status.";
                return false;
            }
            if (projectManager === "0") {
                errorLabel.innerHTML = "Please select a Project Manager.";
                return false;
            }
            if (client === "0") {
                errorLabel.innerHTML = "Please select a Client.";
                return false;
            }

            return true; // Submit form if everything is valid
        }
    </script>

</asp:Content>

<asp:Content ID="Title" ContentPlaceHolderID="Header_Title" runat="server">
    Add Project
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>Add New Project</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        
        <label>Project Name</label>
        <asp:TextBox ID="txtProjectName" runat="server" placeholder="Project Name"></asp:TextBox>
        
        <label>Start Date</label>
        <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
        
        <label>End Date</label>
        <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
        
        <label>Client Name</label>
        <asp:TextBox ID="txtClient" runat="server" placeholder="Client Name"></asp:TextBox>
        
        <label>Budget</label>
        <asp:TextBox ID="txtBudget" runat="server" TextMode="Number"></asp:TextBox>
        
        <label>Status</label>
        <asp:DropDownList ID="ddlStatus" runat="server">
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Ongoing" Value="Ongoing"></asp:ListItem>
            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
        </asp:DropDownList>
        
        <label>Project Description</label>
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
        
        <div class="button-container">
            <asp:Button ID="btnSubmit" runat="server" Text="Add Project" CssClass="btn-custom" />
        </div>
    </div>
</asp:Content>


