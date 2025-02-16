<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="addProjects.aspx.cs" Inherits="WorkNest.Admin.addProjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        /* Improved CSS for Add Project Form */
        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0px;
           
            max-width: 900px;
            margin: auto;
            /*        gap: 20px;*/
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #0d0d30;
            border-radius: 10px;
        }

        #im {
            width: 50%;
            /*        max-width: 300px;*/
            min-height: 541.8px;
            height: 100%;
            /*         object-fit: cover;*/
            border-bottom-left-radius: 10px;
            border-top-left-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            background:;
            padding: 20px;
            /*        border-radius: 10px;*/
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            width: 50%;
            border-bottom-right-radius: 10px;
            border-top-right-radius: 10px;
            background-color: #8B9EB2;
            color: #000;
        }
            .form-container h3 {
                text-align: center;
                margin-bottom: 20px;
                color: #000;
            }
        .form-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            color: #333333;
            width: 35%;
            text-align: left;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        textarea,
        select {
            width: 65%;
            padding: 10px;
            border: 1px solid #8B9EB2;
            border-radius: 5px;
            font-size: 16px;
        }

            input:focus,
            textarea:focus,
            select:focus {
                border-color: #4A6D85;
                outline: none;
                box-shadow: 0px 0px 5px rgba(74, 109, 133, 0.5);
            }

        .button-container {
            display: flex;
            justify-content: space-between;
        }

        .btn-custom {
            width: 48%;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                align-items: center;
                max-width: 100%;
            }

            #im {
                width: 80%;
                max-width: 100%;
                min-height: auto;
            }

            .form-container {
                width: 90%;
            }

            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }

            label {
                width: 100%;
                margin-bottom: 5px;
            }

            input,
            select,
            textarea {
                width: 100%;
            }

            .button-container {
                flex-direction: column;
            }

            .btn-custom {
                width: 100%;
                margin-bottom: 10px;
            }
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

<asp:Content ID="Content2" ContentPlaceHolderID="Header_Title" runat="server">
    Add Project
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container">
        <img id="im" src="../images/Project Add image.png" alt="Project Image" />
        <div class="form-container">
            <h3>Add Project</h3>
            <div class="form-group">
                <label for="txtProjectName">Project Name:</label>
                <asp:TextBox ID="txtProjectName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtDesc">Description:</label>
                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="dateStart">Start Date:</label>
                <asp:TextBox ID="dateStart" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="dateEnd">End Date:</label>
                <asp:TextBox ID="dateEnd" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="ddlStatus">Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="ddlProjectManager">Project Manager:</label>
                <asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="ddlClient">Client:</label>
                <asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="button-container">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary btn-custom" OnClick="btnSubmit_Click" Text="SUBMIT" OnClientClick="return validateForm();" />
                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-secondary btn-custom" Text="RESET" OnClick="btnReset_Click" CausesValidation="False" OnClientClick="return confirm('Are you sure you want to reset the form?');" />
            </div>
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </div>
    </div>

</asp:Content>
