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
</head>
<body>
    <form id="registration" runat="server">
        <div style="text-align: center; diaplay:flax;">
            <%--<asp:Label ID="lblCon" runat="server"></asp:Label>--%>
            <div style="font-size: xx-large;">Registration Form&nbsp;</div>

            <div>
                <asp:Label runat="server" Text="Name:" AssociatedControlID="txtName" />
                <asp:TextBox ID="txtName" runat="server" oninput="checkName(this)"></asp:TextBox>
                <asp:Label runat="server" Text="" ID="lblEname"></asp:Label>
            </div>

            <div>
                <asp:Label runat="server" Text="Phone number:" AssociatedControlID="txtPhone" />
                <asp:TextBox ID="txtPhone" runat="server" TextMode="Number" oninput="PhoneSize(this)"></asp:TextBox>
                <asp:Label ID="lblEphone" runat="server" ForeColor="Red"></asp:Label>
            </div>

            <div>
                <asp:Label runat="server" Text="Email:" AssociatedControlID="txtEmail" />
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" OnTextChanged="EmailChange" AutoPostBack="true"></asp:TextBox>
                <asp:Label runat="server" Text="" ID="lblEemail"></asp:Label>
            </div>

            <div>
                <asp:Label runat="server" Text="User Name:" AssociatedControlID="txtUsername" />
                <asp:TextBox ID="txtUsername" runat="server" AutoPostBack="True" OnTextChanged="checkUser"></asp:TextBox>
                <asp:Label runat="server" Text="" ID="lblEuser"></asp:Label>
            </div>

            <div>
                <asp:Label runat="server" Text="Password:" AssociatedControlID="txtPassword" />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" oninput="validatePassword(this)" Enabled="false"></asp:TextBox>
                <asp:Label runat="server" Text="" ID="lblEpass"></asp:Label>
            </div>

            <div>
                <asp:Label ID="lblLength" runat="server" ForeColor="Red" Text="At least 8 characters"></asp:Label><br />
                <asp:Label ID="lblNumberOrSymbol" runat="server" ForeColor="Red" Text="At least one number (0-9) or a symbol"></asp:Label><br />
                <asp:Label ID="lblCase" runat="server" ForeColor="Red" Text="Lowercase (a-z) and uppercase (A-Z)"></asp:Label><br />
            </div>

            <div>
                <asp:Label runat="server" Text="Rewrite Password:" AssociatedControlID="txtRepassword" />
                <asp:TextBox ID="txtRepassword" runat="server" TextMode="Password" oninput="matchPass(txtPassword, this)" Disabled="true"></asp:TextBox>
                <asp:Label runat="server" Text="" ID="lblErepass"></asp:Label>
            </div>

            <div>
                <asp:Label runat="server" Text="Date of Hiring:" AssociatedControlID="txtDate" />
                <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
            </div>

            <div>
                <asp:Label runat="server" Text="DEPT:" AssociatedControlID="ddlDept" />
                <asp:DropDownList ID="ddlDept" runat="server" onchange="selectedDept(this)"></asp:DropDownList>
                <asp:Label runat="server" Text="" ID="lblEdept" ForeColor="Red"></asp:Label>
            </div>

            <div>
                <asp:Label runat="server" Text="Image:" AssociatedControlID="fuImage" />
                <asp:FileUpload ID="fuImage" runat="server" />
            </div>

            <div>
                <asp:Label ID="lblError" runat="server"></asp:Label><br />
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="69px" OnClick="btnSubmit_Click" OnClientClick="return fullFormvalidate()" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
            </div>
        </div>
    </form>

</body>
</html>
