<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="WorkNest.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <title>Registration</title>
    <script type="text/javascript">
        let validate = true;

        function fullFormvalidate() {
            validate = true;
            isValide = true;
            var nameInput = document.getElementById('<%= txtName.ClientID %>');
            var phoneInput = document.getElementById('<%= txtPhone.ClientID %>');
            var Pass = document.getElementById('<%= txtPassword.ClientID %>');
            var Repass = document.getElementById('<%= txtRepassword.ClientID %>');
            var ddl = document.getElementById("<%= ddlDept.ClientID %>").selectedIndex;
            const lblEdept = document.getElementById('<%= lblEdept.ClientID %>');
            var email = document.getElementById('<%= txtEmail.ClientID %>');
            var user = document.getElementById('<%= txtUsername.ClientID %>');
            if (ddl === 0) {
                lblEdept.textContent = "select dept!!";
                isValide = false;
            } else {
                lblEdept.textContent = "";
            }
            isEmailEmpty(email);
            if (validate == false) {
                isValide = false;
            }
            checkName(nameInput);
            if (validate == false) {
                isValide = false;
            }
            PhoneSize(phoneInput);
            if (validate == false) {
                isValide = false;
            }
            isUsernameEmpty(user);
            if (validate == false) {
                isValide = false;
            }
            validatePassword(Pass);
            if (validate == false) {
                isValide = false;
            }
            matchPass(Pass, Repass);
            if (validate == false) {
                isValide = false;
            }

            return isValide;
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
        function isUsernameEmpty(input) {
            const user = input.value;
            const lblEuser = document.getElementById('<%= lblEuser.ClientID %>');

            if (user.trim().length === 0) {
                lblEuser.textContent = "Enter UserName !!";
                lblEuser.style.color = "Red";
                validate = false;
            } else {
                lblEuser.textContent = "";
                validate = true;
            }
        }
        function validatePassword(input) {
            const password = input.value;
            const lblLength = document.getElementById('<%= lblLength.ClientID %>');
            const lblNumberOrSymbol = document.getElementById('<%= lblNumberOrSymbol.ClientID %>');
            const lblCase = document.getElementById('<%= lblCase.ClientID %>');
            const rePass = document.getElementById('<%= txtRepassword.ClientID %>');
            validate = true;

            if (password.length >= 8) {
                lblLength.style.color = "green";

            }
            else if (password.length != 0) {
                lblEpass.textContent = "";
            }
            else {
                lblEpass.textContent = "Enter Password !";
                lblEpass.style.color = "Red";
                lblLength.style.color = "red";
                validate = false;
            }

            if (/[0-9!@#$%^&*(),.?":{}|<>]/.test(password)) {
                lblNumberOrSymbol.style.color = "green";
            } else {
                lblNumberOrSymbol.style.color = "red";
                validate = false;
            }

            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) {
                lblCase.style.color = "green";
            } else {
                lblCase.style.color = "red";
                validate = false;
            }
            if (validate) {
                rePass.disabled = false;
            } else {
                rePass.disabled = true;
            }
        }

        function matchPass(passwordInput, repasswordInput) {
            const lblErepass = document.getElementById('<%= lblErepass.ClientID %>');
            if (passwordInput.value !== repasswordInput.value) {
                lblErepass.textContent = "Passwords do not match.";
                lblErepass.style.color = "red";
                validate = false;
            } else {
                lblErepass.textContent = "";
            }
        }

        function PhoneSize(input) {
            validate = true;
            const Phone = input.value;
            const lblE = document.getElementById('<%= lblEphone.ClientID %>');

            if (Phone.length != 10) {
                lblE.textContent = "Enter Valid 10 digit Number!!";
                lblE.style.color = "red";
                validate = false;
            }
            else {
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
            const i = input.selectedIndex;
            if (i !== 0) {
                lblEdept.textContent = "";

            }
        }
    </script>
    <style>
        body {
            background-color: #1C2529;
        }

        .container {
            margin-top: 10px;
        }

        .form-container {
            background: #1C2529;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin:0;
             height: 680px;
             color:#A1D1B1;
            
        }

        .image-container img {
            width: 80%;
            height: 675px;
            border-radius: 10px;
        }
        .image-container{
            padding:0;
            z-index:-1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6 image-container">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/registrationImage.png" />

            </div>
            <div class="col-md-6 form-container">
                <h2 class="text-center mb-4">Registration Form</h2>
                <form id="registration" runat="server" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <%-- <asp:Label runat="server" Text="Name:" AssociatedControlID="txtName" CssClass="form-label" />--%>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" oninput="checkName(this)" placeholder="Enter FullName"></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblEname" CssClass="text-danger"></asp:Label>
                    </div>

                    <div class="mb-3">
                        <%--<asp:Label runat="server" Text="Phone number:" AssociatedControlID="txtPhone" CssClass="form-label" />--%>
                        <asp:TextBox ID="txtPhone" runat="server" TextMode="Number" CssClass="form-control" oninput="PhoneSize(this)" placeholder="Enter Phone Number"></asp:TextBox>
                        <asp:Label ID="lblEphone" runat="server" CssClass="text-danger"></asp:Label>
                    </div>

                    <div class="mb-3">
                        <%--<asp:Label runat="server" Text="Email:" AssociatedControlID="txtEmail" CssClass="form-label" />--%>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" OnTextChanged="EmailChange" AutoPostBack="true" placeholder="Email Address"></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblEemail" CssClass="text-danger"></asp:Label>
                    </div>

                    <div class="mb-3">
                        <%--<asp:Label runat="server" Text="User Name:" AssociatedControlID="txtUsername" CssClass="form-label" />--%>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="checkUser" placeholder="Select Username"></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblEuser" CssClass="text-danger"></asp:Label>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <%--<asp:Label runat="server" Text="Password:" AssociatedControlID="txtPassword" CssClass="form-label" />--%>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" oninput="validatePassword(this)" Enabled="false" placeholder="Enter Password"></asp:TextBox>
                            <asp:Label runat="server" Text="" ID="lblEpass" CssClass="text-danger"></asp:Label>
                        </div>
                        <div class="col-md-6">
                            <%--<asp:Label runat="server" Text="Rewrite Password:" AssociatedControlID="txtRepassword" CssClass="form-label" />--%>
                            <asp:TextBox ID="txtRepassword" runat="server" TextMode="Password" CssClass="form-control" oninput="matchPass(txtPassword, this)" Disabled="true" placeholder="Confirm your Password"></asp:TextBox>
                            <asp:Label runat="server" Text="" ID="lblErepass" CssClass="text-danger"></asp:Label>
                        </div>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblLength" runat="server" Text="At least 8 characters" ForeColor="#A1D1B1"></asp:Label><br />
                        <asp:Label ID="lblNumberOrSymbol" runat="server" Text="At least one number (0-9) or a symbol" ForeColor="#A1D1B1"></asp:Label><br />
                        <asp:Label ID="lblCase" runat="server" Text="Lowercase (a-z) and uppercase (A-Z)" ForeColor="#A1D1B1"></asp:Label>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Date of Hiring:" AssociatedControlID="txtDate" CssClass="form-label" />
                            <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Department:" AssociatedControlID="ddlDept" CssClass="form-label" />
                            <asp:DropDownList ID="ddlDept" runat="server" CssClass="form-select" onchange="selectedDept(this)"></asp:DropDownList>
                            <asp:Label runat="server" Text="" ID="lblEdept" CssClass="text-danger"></asp:Label>
                        </div>
                    </div>
                    <div class="mb-1.5">
                        <asp:Label runat="server" Text="Upload Image:" AssociatedControlID="fuImage" CssClass="form-label" />
                        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                    </div>

                    <div class="text-center">
                        <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label><br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" OnClientClick="return fullFormvalidate()" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-secondary" OnClick="btnReset_Click" />
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
