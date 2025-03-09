<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="UpdateEmployee.aspx.cs" Inherits="WorkNest.Admin.UpdateEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script type="text/javascript">
        let validate = true;

        function fullFormvalidate() {
            validate = true;
            let isValid = true;

            var nameInput = document.getElementById('<%= txtFullName.ClientID %>');
            var phoneInput = document.getElementById('<%= txtPhoneNumber.ClientID %>');
            var ddl = document.getElementById("<%= ddlDepartment.ClientID %>").selectedIndex;
            var lblEdept = document.getElementById('<%= lblEdept.ClientID %>');
            var email = document.getElementById('<%= txtEmail.ClientID %>');

            if (ddl === 0) {
                lblEdept.textContent = "*";
                isValid = false;
            } else {
                lblEdept.textContent = "";
            }

            checkName(nameInput);
            if (!validate) isValid = false;

            isEmailEmpty(email);
            if (!validate) isValid = false;

            PhoneSize(phoneInput);
            if (!validate) isValid = false;

            return isValid;
        }

        function isEmailEmpty(input) {
            const email = input.value;
            const lblEemail = document.getElementById('<%= lblEemail.ClientID %>');
            if (email.trim().length === 0) {
                lblEemail.textContent = "Enter Email Address!!";
                lblEemail.style.color = "Red";
                validate = false;
            } else {
                lblEemail.textContent = "";
                validate = true;
            }
        }

        function PhoneSize(input) {
            var phone = input.value;
            var lblE = document.getElementById('<%= lblEphone.ClientID %>');

            if (phone.length !== 10 || isNaN(phone)) {
                lblE.textContent = "Enter a valid 10-digit phone number!";
                lblE.style.color = "red";
                validate = false;
            } else {
                lblE.textContent = "";
            }
        }

        function checkName(input) {
            const name = input.value;
            const Fname = name.split(' ');
            const lblE = document.getElementById('<%= lblEname.ClientID %>');

            if (Fname.length < 2 || !isNaN(Fname[1])) {
                lblE.textContent = "Enter full name!!";
                lblE.style.color = "red";
                validate = false;
            } else {
                lblE.textContent = "";
            }
        }
        function selectedDept(input) {
            var lblEdept = document.getElementById('<%= lblEdept.ClientID %>');
            if (input.selectedIndex !== 0) {
                lblEdept.textContent = "";
            }
        }

        function validateEmail(input) {
            var email = input.value;
            var lblEemail = document.getElementById('<%= lblEemail.ClientID %>');
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailRegex.test(email)) {
                lblEemail.textContent = "Please enter a valid email address.";
                lblEemail.style.color = "red";
                validate = false;
            } else {
                lblEemail.textContent = "";
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .form-container {
            max-width: 600px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Update Employee
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="form-container mx-auto">
            <h3 class="text-center text-primary">Update Employee Details</h3>
            <asp:HiddenField ID="hfEmployeeID" runat="server" />

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" oninput="checkName(this)" />
                <asp:Label runat="server" Text="" ID="lblEname" CssClass="text-danger"></asp:Label>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" oninput="validateEmail(this);" CssClass="form-control" />
                <asp:Label runat="server" Text="" ID="lblEemail" CssClass="text-danger"></asp:Label>
            </div>

            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <asp:TextBox ID="txtPhoneNumber" runat="server" oninput="PhoneSize(this)" CssClass="form-control" />
                <asp:Label ID="lblEphone" runat="server" CssClass="text-danger"></asp:Label>
            </div>

            <div class="mb-3">
                <label class="form-label">Hire Date</label>
                <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control" TextMode="Date" />
            </div>

            <div class="mb-3">
                <label class="form-label">Department</label>
                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:Label runat="server" Text="" ID="lblEdept" CssClass="text-danger"></asp:Label>
            </div>

            <div class="mb-3">
                <label class="form-label">Profile Image</label>
                <asp:FileUpload ID="fuProfileImage" runat="server" CssClass="form-control" />
            </div>

            <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            
            <div class="d-flex justify-content-between">
                <asp:Button ID="BackToEmployee" runat="server" Text="Back" CssClass="btn btn-outline-secondary" PostBackUrl="~/Admin/Employees.aspx" />
                <asp:Button ID="btnUpdateEmployee" runat="server" Text="Update" CssClass="btn btn-primary" OnClientClick="return fullFormvalidate();" OnClick="btnUpdateEmployee_Click" />
            </div>
        </div>
    </div>
</asp:Content>