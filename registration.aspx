<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="WorkNest.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        function isEmailEmpty(input){
           const email=input.value;
           const lblEemail = document.getElementById('<%= lblEemail.ClientID %>');
            if (email.trim().length===0) {
                lblEemail.textContent = "Enter Email Address!!";
                lblEemail.style.color = "Red";
                validate = false;
             } else {
                lblEemail.textContent = "";
                validate=true;
             }
        }
        function isUsernameEmpty(input){
            const user=input.value;
            const lblEuser = document.getElementById('<%= lblEuser.ClientID %>');

            if (user.trim().length===0) {
                lblEuser.textContent = "Enter UserName !!";
                 lblEuser.style.color = "Red";
                validate = false;
            } else {
                lblEuser.textContent = "";
                validate=true; 
            }
        }
        function validatePassword(input) {
            const password = input.value;
            const lblLength = document.getElementById('<%= lblLength.ClientID %>');
            const lblNumberOrSymbol = document.getElementById('<%= lblNumberOrSymbol.ClientID %>');
            const lblCase = document.getElementById('<%= lblCase.ClientID %>');

            validate = true;
            
            if (password.length >= 8) {
                lblLength.style.color = "green";
            }
            else if (password.length!=0){
                 lblEpass.textContent ="";
                }
                else {
                lblEpass.textContent = "Enter Password !!"
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
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="date"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .error-message {
            color: red;
            font-size: 0.9em;
        }

        .auto-style4 {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .form-group button {
            background-color: #5cb85c;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 48%;
            margin: 1%;
        }

        .form-group button:hover {
            background-color: #4cae4c;
        }

        .form-group #btnReset {
            background-color: #d9534f;
        }

        .form-group #btnReset:hover {
            background-color: #c9302c;
        }

        .form-group {
            text-align: center;
        }
    </style>
</head><body>
    <form id="registration" runat="server">
        <div>
            <table align="center" class="auto-style1" style="width: 50%">
                <tr>
                    <td colspan="2" style="text-align: center; font-size: xx-large;">Registration Form&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">Name:</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtName" runat="server" oninput="checkName(this)"></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblEname"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Phone number:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtPhone" runat="server" TextMode="Number" oninput="PhoneSize(this)"></asp:TextBox>
                        <asp:Label ID="lblEphone" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Email:</td>
                    <td class="auto-style6">
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" OnTextChanged="EmailChange" AutoPostBack="true"></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblEemail"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">User  Name:</td>
                    <td class="auto-style6">
                        <asp:TextBox ID="txtUsername" runat="server" AutoPostBack="True" OnTextChanged="checkUser "></asp:TextBox>
                         <asp:Label runat="server" Text="" ID="lblEuser"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Password:</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" oninput="validatePassword(this)" ></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblEpass"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td class="auto-style4">
                        <asp:Label ID="lblLength" runat="server" ForeColor="Red" Text="At least 8 characters"></asp:Label><br />
                        <asp:Label ID="lblNumberOrSymbol" runat="server" ForeColor="Red" Text="At least one number (0-9) or a symbol"></asp:Label><br />
                        <asp:Label ID="lblCase" runat="server" ForeColor="Red" Text="Lowercase (a-z) and uppercase (A-Z)"></asp:Label><br />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Rewrite Password:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtRepassword" runat="server" TextMode="Password" oninput="matchPass(txtPassword, this)"></asp:TextBox>
                        <asp:Label runat="server" Text="" ID="lblErepass"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Date of Hiring:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">DEPT:</td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="ddlDept" runat="server" onchange="selectedDept(this)"></asp:DropDownList>
                        <asp:Label runat="server" Text="" ID="lblEdept" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Image:</td>
                    <td class="auto-style5">
                        <asp:FileUpload ID="fuImage" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-right: 10px;">
                        <br />
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                        <br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="69px" OnClick="btnSubmit_Click" OnClientClick="return fullFormvalidate()" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:Label ID="lblCon" runat="server"></asp:Label>
    </form>
</body>
</html>
