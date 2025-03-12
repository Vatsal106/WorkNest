<%@ Page Title="Add Client" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="addClients.aspx.cs" Inherits="WorkNest.Admin.addClients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
       
        .container {
            display: flex;
            width: 80%;
            max-width: 900px;
            background: #8B9EB2;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            margin: 0 auto;
            padding: 0;
        }

        .image-section {
            width: 50%;
            background: #0D0D30;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

            .image-section img {
                width: 100%;
                height: auto;
                object-fit: cover;
            }

        .form-section {
            width: 50%;
            padding: 40px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            width: 35%;
            text-align: right;
            margin-right: 10px;
            white-space: nowrap;
        }

        input, textarea {
            width: 65%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 10px; 
            margin-top: 15px;
        }

        .btn-submit, .btn-reset {
            width: 48%; 
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
            text-align: center;
        }

        .btn-submit {
            background: #007BFF;
            color: white;
        }

            .btn-submit:hover {
                background: #0056b3;
                transform: scale(1.02);
            }

        .btn-reset {
            background: #FF8C00;
            color: white;
        }

            .btn-reset:hover {
                background: #cc7000;
                transform: scale(1.02);
            }

            .btn-submit:active, .btn-reset:active {
                transform: scale(0.98);
            }


        @media screen and (max-width: 768px) {
            .container {
                flex-direction: column;
                width: 90%;
            }

            .image-section {
                width: 100%;
                height: 250px;
            }

            .form-section {
                width: 100%;
                padding: 20px;
            }

            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }

            label {
                width: 100%;
                text-align: left;
                margin-bottom: 5px;
            }

            input, textarea {
                width: 100%;
            }

            .button-group {
                flex-direction: column; 
            }

            .btn-submit, .btn-reset {
                width: 100%;
            }
        }
    </style>
    <script>
        function validateForm() {
            var clientName = document.getElementById('<%= txtClientName.ClientID %>').value.trim();
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var phone = document.getElementById('<%= txtPhoneNumber.ClientID %>').value.trim();
            var companyName = document.getElementById('<%= txtCompanyName.ClientID %>').value.trim();
            var address = document.getElementById('<%= txtAddress.ClientID %>').value.trim();
            var errorLabel = document.getElementById('<%= lblError.ClientID %>');

            var errorMessage = "";

            if (!clientName) errorMessage += "Client Name is required.\n";
            if (!email) errorMessage += "Email is required.\n";
            if (!phone) errorMessage += "Phone Number is required.\n";
            if (!companyName) errorMessage += "Company Name is required.\n";
            if (!address) errorMessage += "Address is required.\n";

            if (email && !validateEmail(email)) {
                errorMessage += "Invalid email format.\n";
            }

            if (phone && !validatePhone(phone)) {
                errorMessage += "Phone number must be exactly 10 digits.\n";
            }

            if (errorMessage !== "") {
                errorLabel.innerText = errorMessage;
                return false; 
            }

            errorLabel.innerText = "";
            return true; 
        }

        function validateEmail(email) {
            var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return regex.test(email);
        }

        function validatePhone(phone) {
            return phone.length === 10;
        }

        function checkEmailFormat() {
            var emailInput = document.getElementById('<%= txtEmail.ClientID %>');
            if (!validateEmail(emailInput.value)) {
                emailInput.style.borderColor = "red";
            } else {
                emailInput.style.borderColor = "";
            }
        }

        function checkPhoneNumber() {
            var phoneInput = document.getElementById('<%= txtPhoneNumber.ClientID %>');
            phoneInput.value = phoneInput.value.replace(/\D/g, ''); 
            if (!validatePhone(phoneInput.value)) {
                phoneInput.style.borderColor = "red";
            } else {
                phoneInput.style.borderColor = "";
            }
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Header_Title" runat="server">
    Add Client
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="image-section">
            <img src='<%= ResolveUrl("~/Images/ClientPagePhoto.png") %>' alt="Client Image" />
        </div>

        <div class="form-section">
            <h2>Add Client</h2>
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            <div class="form-group">
                <label for="txtClientName">Client Name:</label>
                <asp:TextBox ID="txtClientName" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" oninput="checkEmailFormat()"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtPhoneNumber">Phone Number:</label>
                <asp:TextBox ID="txtPhoneNumber" runat="server" TextMode="Number" oninput="checkPhoneNumber()"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtCompanyName">Company Name:</label>
                <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtAddress">Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="button-group">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn-submit" OnClick="btnSubmit_Click" OnClientClick="return validateForm();" Text="Submit" />
                <asp:Button ID="btnReset" runat="server" CssClass="btn-reset"
                    OnClick="btnReset_Click" Text="Reset"
                    CausesValidation="false" UseSubmitBehavior="false"
                    />
            </div>
        </div>
    </div>
</asp:Content>
