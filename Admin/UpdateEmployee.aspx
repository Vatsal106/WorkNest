<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="UpdateEmployee.aspx.cs" Inherits="WorkNest.Admin.UpdateEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script type="text/javascript">
        // JavaScript functions from registration.aspx
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Update Employee Details</h2>

    <asp:HiddenField ID="hfEmployeeID" runat="server" />

    <div>
        <label>Full Name:</label>
        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" oninput="checkName(this)" />
        <asp:Label runat="server" Text="" ID="lblEname"></asp:Label>

    </div>
    <div>
        <label>Email:</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" oninput="validateEmail(this);" OnTextChanged="EmailChange" CssClass="form-control" />
        <asp:Label runat="server" Text="  " ID="lblEemail" CssClass="text-danger"></asp:Label>

    </div>
    <div>
        <label>Phone Number:</label>
        <asp:TextBox ID="txtPhoneNumber" runat="server" oninput="PhoneSize(this)" CssClass="form-control" />
        <asp:Label ID="lblEphone" runat="server" CssClass="text-danger"></asp:Label>
    </div>
    <div>
        <label>Hire Date:</label>
        <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control" TextMode="Date" />
    </div>
    <div>
        <label>Department:</label>
        <asp:Label runat="server" Text="" ID="lblEdept" CssClass="text-danger"></asp:Label>
        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" oninput="selectedDept(this)"></asp:DropDownList>
    </div>
    <div>
        <label>Profile Image:</label>
        <asp:FileUpload ID="fuProfileImage" runat="server" />
    </div>
    <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
    <asp:Button ID="btnUpdateEmployee" runat="server" Text="Update Employee" CssClass="btn btn-primary" OnClientClick="return fullFormvalidate();" OnClick="btnUpdateEmployee_Click" />

</asp:Content>
