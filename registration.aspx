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
                lblEdept.textContent = "*";
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
                lblLength.style.color = "#0D0D30";

            }
            else if (password.length != 0) {
                //lblEpass.textContent = "";
                lblLength.style.color = "red";
            }
            else {
                //lblEpass.textContent = "Enter Password !";
                //lblEpass.style.color = "Red";
                lblLength.style.color = "red";
                validate = false;
            }

            if (/[0-9!@#$%^&*(),.?":{}|<>]/.test(password)) {
                lblNumberOrSymbol.style.color = "#0D0D30";
            } else {
                lblNumberOrSymbol.style.color = "red";
                validate = false;
            }

            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) {
                lblCase.style.color = "#0D0D30";
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
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #fff ;
            font-family: Arial, sans-serif;
            padding: 10px;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            background: #fff;
            width: 90%;
            border-radius: 10px;
            overflow: hidden;
           box-shadow: rgb(38, 57, 77) 0px 20px 30px -10px;
            padding:0;
        }
        .image-section img {
            width: 100%;
            height:640px;
        }
        .form-section {
            width: 50%;
            padding: 40px;
            background:#8B9EB2;
            color:#0D0D30;
        }
        .image-section{
            width:50%;
        }
        @media (max-width: 700px) {
            .container {
                flex-direction: column;
            }
            .image-section {
                width: 100%;
                height: 100%;
            }
            .form-section {
                width: 100%;
            }
        }
        .input-group{
            margin-bottom:10px;
            border-radius:13px;
            display:flex;
            justify-content:space-between;
            width:100%
            

        }
        .input-col{
            width:48%;
        }
       
    </style>
</head>
<body>
    <div class="container">
        <div class="image-section">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Add Emp.png"  />
        </div>
        <div class="form-section">
            <h2 class="text-center mb-4">Add new Employee</h2>
            <form id="registration" runat="server" class="form-Cont" novalidate>
                <div class="input-group">
                    <asp:TextBox class="mr-2" ID="txtName" runat="server" CssClass="form-control" oninput="checkName(this)" placeholder="Enter FullName"></asp:TextBox>
                     <asp:Label runat="server" Text="" ID="lblEname" ></asp:Label>
                </div>
                     
                <div class="input-group">
                    <asp:TextBox ID="txtPhone" runat="server" TextMode="Number" CssClass="form-control" oninput="PhoneSize(this)" placeholder="Enter Phone Number"></asp:TextBox>
                    <asp:Label ID="lblEphone" runat="server" CssClass="text-danger"></asp:Label>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" OnTextChanged="EmailChange" AutoPostBack="true" placeholder="Email Address"></asp:TextBox>
                    <asp:Label runat="server" Text="  " ID="lblEemail" CssClass="text-danger"></asp:Label>
                </div>
                   

                <div class="input-group md-12">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="checkUser" placeholder="Select Username"></asp:TextBox>
                    <asp:Label runat="server" Text="" ID="lblEuser" CssClass="text-danger"></asp:Label>
                </div>
                <div class="input-group">
                    <div class="input-col">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" oninput="validatePassword(this)" Enabled="false" placeholder="Enter Password"></asp:TextBox>
                    </div>
                    <div class="input-col">
                        <asp:TextBox ID="txtRepassword" runat="server" TextMode="Password" CssClass="form-control" oninput="matchPass(txtPassword, this)" Disabled="true" placeholder="Confirm your Password"></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblErepass" CssClass="text-danger"></asp:Label>
                    </div>
                </div>
                <div>
                        <asp:Label ID="lblLength" runat="server" Text="Password must Contain At least 8 characters , " ForeColor="#0D0D30"></asp:Label>
                        <asp:Label ID="lblNumberOrSymbol" runat="server" Text="At least one number (0-9) or a symbol, " ForeColor="#0D0D30"></asp:Label>
                        <asp:Label ID="lblCase" runat="server" Text="Lowercase (a-z) and uppercase (A-Z)." ForeColor="#0D0D30"></asp:Label>
                    </div>
                <div class="input-group">
                    <div class="input-col">
                        <asp:Label runat="server" Text="Date of Hiring:" AssociatedControlID="txtDate" CssClass="form-label" />
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="input-col">
                        <asp:Label runat="server" Text="Department:" AssociatedControlID="ddlDept" CssClass="form-label" /><asp:Label runat="server" Text="" ID="lblEdept" CssClass="text-danger"></asp:Label>
                        <asp:DropDownList ID="ddlDept" runat="server" CssClass="form-select" onchange="selectedDept(this)"></asp:DropDownList>
                    </div>
                </div>
                <div class="input-group">
                    <asp:Label runat="server" Text="Upload Image:" AssociatedControlID="fuImage" CssClass="form-label" />
                    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                </div>
                <div class="text-center">
                    <asp:Label ID="lblError" class="btn" runat="server" CssClass="text-danger"></asp:Label><br />
                    <asp:Button ID="btnSubmit" class="btn" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" OnClientClick="return fullFormvalidate()" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-secondary" OnClick="btnReset_Click" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>
