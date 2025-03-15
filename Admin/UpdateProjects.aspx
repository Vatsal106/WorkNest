<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="UpdateProjects.aspx.cs" Inherits="WorkNest.Admin.UpdateProjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script>
        function ValidateProject() {
            let isValid = true;
            let errorMessage = "";
            let projectName = document.getElementById("<%= txtProjectName.ClientID %>").value.trim();
            let description = document.getElementById("<%= txtDescription.ClientID %>").value.trim();
            let startDate = document.getElementById("<%= txtStartDate.ClientID %>").value;
            let endDate = document.getElementById("<%= txtEndDate.ClientID %>").value;
            let status = document.getElementById("<%= ddlStatus.ClientID %>").value;
            let projectManager = document.getElementById("<%= ddlProjectManager.ClientID %>").value;
            let client = document.getElementById("<%= ddlClient.ClientID %>").value;
            console.log("Project Name:", projectName);

            if (projectName === "") errorMessage += "⚠ Project Name is required.\n";
            if (description === "") errorMessage += "⚠ Description is required.\n";
            if (startDate === "") errorMessage += "⚠ Start Date is required.\n";
            if (endDate === "") errorMessage += "⚠ End Date is required.\n";
            if (startDate !== "" && endDate !== "") {
                let start = new Date(startDate);
                let end = new Date(endDate);
                if (start >= end) errorMessage += "⚠ End Date must be after Start Date.\n";
            }


            if (existingStartDate !== "" && new Date(startDate) < new Date(existingStartDate)) {
                errorMessage += "⚠ Start Date cannot be set before the existing Start Date.\n";
            }

            if (status === "") errorMessage += "⚠ Please select a project status.\n";
            if (projectManager == "0") errorMessage += "⚠ Please select a Project Manager.\n";
            if (client == "0") errorMessage += "⚠ Please select a Client.\n";


            let errorLabel = document.getElementById("<%= lblError.ClientID %>");
            if (errorMessage !== "") {
                errorLabel.innerText = errorMessage;
                errorLabel.style.color = "red";
                return false;
            } else {
                errorLabel.innerText = "";
                return true;
            }
        }

    </script>
    <style>
        .form-container {
            max-width: 700px;
            margin: 40px auto;
            padding: 20px;
            background: #F7F9FB;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }

        label {
            width: 180px;
            font-weight: bold;
            color: #333;
            text-align: right;
            padding-right: 10px;
        }

        .form-control {
            flex: 1;
            padding: 8px;
            border: 1px solid #8B9EB2;
            border-radius: 5px;
            background: white;
        }

            .form-control:focus {
                border-color: #4A6D85;
                outline: none;
                box-shadow: 0 0 5px rgba(74, 109, 133, 0.5);
            }

        .btn-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn-success {
            background: #FF8C00;
            color: white;
        }

            .btn-success:hover {
                background: #e67e00;
            }

        .btn-secondary {
            background: #8B9EB2;
            color: white;
        }

            .btn-secondary:hover {
                background: #4A6D85;
            }

        #lblError {
            color: red;
            font-weight: bold;
            display: block;
            text-align: center;
            margin-top: 10px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Update Project
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2 style="text-align: center;">Update Project</h2>

        <asp:HiddenField ID="hfProjectID" runat="server" />

        <div class="form-group">
            <label>Project Name:</label>
            <asp:TextBox ID="txtProjectName" runat="server" CssClass="form-control" />
        </div>

        <div class="form-group">
            <label>Description:</label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" />
        </div>

        <div class="form-group">
            <label>Start Date:</label>
            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date" />
        </div>

        <div class="form-group">
            <label>End Date:</label>
            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date" />
        </div>

        <div class="form-group">
            <label>Status:</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                <asp:ListItem Text="HOLD" Value="ON HOLD"></asp:ListItem>
                <asp:ListItem Text="IN PROGRESS" Value="IN PROGRESS"></asp:ListItem>
                <asp:ListItem Text="IN TESTING" Value="IN TESTING"></asp:ListItem>
                <asp:ListItem Text="COMPLETED" Value="COMPLETED"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label>Project Manager:</label>
            <asp:DropDownList ID="ddlProjectManager" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <div class="form-group">
            <label>Client:</label>
            <asp:DropDownList ID="ddlClient" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <asp:Label ID="lblError" Text="" runat="server" />

        <div class="btn-container">
            <asp:Button ID="btnUpdateProject" runat="server" Text="Update" CssClass="btn btn-success" OnClick="ValidateProject" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
        </div>
    </div>

    <a href="Projects.aspx" class="floating-btn" title="Back to Projects"><i class="fas fa-arrow-left"></i></a>


</asp:Content>
