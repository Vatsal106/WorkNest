<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProject.aspx.cs" Inherits="WorkNest.Admin.addProject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            display: flex;
            width: 65%; /* Increased width */
            max-width: 1000px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.3); /* Increased shadow */
            border-radius: 10px;
            overflow: hidden;
            background: white;
            padding: 0px;
        }

        #im {
            width: 45%;
            max-width: 100%;
            height: auto;
            display: block;
        }

        form {
            background-color: #8B9EB2;
            padding: 30px;
            width: 55%;
            box-sizing: border-box;
            border-radius: 0 10px 10px 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            font-weight: bold;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            color: #0D0D30;
            text-align: center;
            margin-bottom: 15px;
            font-size: 28px;
        }

        form div {
            display: grid;
            grid-template-columns: 140px 1fr;
            gap: 10px;
            align-items: center;
            margin-bottom: 8px;
            width: 100%;
            max-width: 450px;
        }

        #pp {
            font-weight: bold;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            color: #0D0D30;
            text-align: right;
            padding-right: 5px;
        }

        /* Input Fields */
        #txtProjectName, #txtDesc, #dateStart, #dateEnd, #ddlStatus, #ddlProjectManager, #ddlClient {
            padding: 10px;
            border-radius: 5px;
            box-sizing: border-box;
            width: 100%;
            font-size: 14px;
            border: none; /* Removed Borders */
            outline: none;
        }

        #txtDesc {
            height: 60px;
        }

        /* Bootstrap Button Styles */
        .button-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 15px;
            width: 100%;
        }

        .btn-custom {
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                width: 90%;
            }

            #im {
                display: none; /* Hide image on small screens */
            }

            form {
                width: 100%;
                border-radius: 10px;
            }

                form div {
                    grid-template-columns: 1fr;
                    text-align: left;
                }

            #pp {
                text-align: left;
                padding-bottom: 5px;
            }

            .button-container {
                flex-direction: column;
            }
        }

        .Form-head {
            display: flex;
        }

            .Form-head .btn-custom {
                font-size: 25px;
                padding: 5px 15px;
                border-radius: 10%;
                transition: background 0.3s ease-in-out;
                margin-right: 120px;
            }

                .Form-head .btn-custom:hover {
                    background: #4A6D85; /* Darker Blue-Grey from your color scheme */
                    color: white;
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



</head>
<body>
    <div class="container">
        <img id="im" src="../images/Project Add image.png" alt="Project Image" />
        <form id="addProject" runat="server">
            <div class="Form-head">
                <a href="AdminHome.aspx" class="btn btn-secondary btn-custom">
                    <i class="bi bi-arrow-left"></i>
                </a>
                <h1>Add Project</h1>
            </div>
            <div>
                <label id="pp">Project Name:</label><asp:TextBox ID="txtProjectName" runat="server"></asp:TextBox>
            </div>
            <div>
                <label id="pp">Description:</label><asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div>
                <label id="pp">Start Date:</label><asp:TextBox ID="dateStart" runat="server" TextMode="Date"></asp:TextBox>
            </div>
            <div>
                <label id="pp">End Date:</label><asp:TextBox ID="dateEnd" runat="server" TextMode="Date"></asp:TextBox>
            </div>
            <div>
                <label id="pp">Status:</label><asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True"></asp:DropDownList>
            </div>
            <div>
                <label id="pp">Project Manager:</label><asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True"></asp:DropDownList>
            </div>
            <div>
                <label id="pp">Client:</label><asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True"></asp:DropDownList>
            </div>

            <!-- Bootstrap Styled Buttons -->
            <div class="button-container">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary btn-custom" OnClick="btnSubmit_Click" Text="SUBMIT" OnClientClick="return validateForm();" />
                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-secondary btn-custom" Text="RESET" OnClick="btnReset_Click" CausesValidation="False" OnClientClick="return confirm('Are you sure you want to reset the form?');" />
            </div>

            <asp:Label ID="lblError" runat="server"></asp:Label>
        </form>
    </div>
</body>
</html>
