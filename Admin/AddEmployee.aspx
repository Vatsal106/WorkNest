﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="WorkNest.Admin.registrations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    
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
            validateEmail(email);
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
        function validateEmail(input) {
            var email = input.value.trim(); 
            var lblEemail = document.getElementById('<%= lblEemail.ClientID %>');
            var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; 

            if (email.length === 0) {
                lblEemail.textContent = "Email cannot be empty!";
                lblEemail.style.color = "red";
                validate = false;
            } else if (!emailRegex.test(email)) {
                lblEemail.textContent = "Enter a valid email.!";
                lblEemail.style.color = "red";
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
       

        .container {
            display: flex;
            flex-wrap: wrap;
            background: #fff;
            width: 90%;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: rgb(38, 57, 77) 0px 20px 30px -10px;
            padding: 0;
        }

        .image-section img {
            width: 100%;
            height: 640px;
        }

        .form-section {
            width: 50%;
            padding: 40px;
            background: #8B9EB2;
            color: #0D0D30;
        }

        .image-section {
            width: 50%;
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

        .Btn {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        width: 45px;
        height: 45px;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        transition-duration: .3s;
        box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.199);
        background-color: rgb(255, 65, 65);
    }

    
    .sign {
        width: 100%;
        transition-duration: .3s;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .sign svg {
        width: 17px;
    }

    .sign svg path {
        fill: white;
    }

    
    .text {
        position: absolute;
        right: 0%;
        width: 0%;
        opacity: 0;
        color: white;
        font-size: 1.2em;
        font-weight: 600;
        transition-duration: .3s;
    }

    
    .Btn:hover {
        width: 125px;
        border-radius: 40px;
        transition-duration: .3s;
    }

    .Btn:hover .sign {
        width: 30%;
        transition-duration: .3s;
        padding-left: 20px;
    }

   
    .Btn:hover .text {
        opacity: 1;
        width: 70%;
        transition-duration: .3s;
        padding-right: 10px;
    }

    
    .Btn:active {
        transform: translate(2px, 2px);
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

        .input-group {
            margin-bottom: 10px;
            border-radius: 13px;
            display: flex;
            justify-content: space-between;
            width: 100%
        }

        .input-col {
            width: 48%;
        }

        .input-col-row {
            width: 48%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Add Employee
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="image-section">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Add Emp.png" />
        </div>
        <div class="form-section">
            <h2 class="text-center mb-4">Add new Employee</h2>
           

                <div class="input-group">
                    <asp:TextBox class="mr-2" ID="txtName" runat="server" CssClass="form-control" oninput="checkName(this)" placeholder="Enter FullName"></asp:TextBox>
                    <asp:Label runat="server" Text="" ID="lblEname"></asp:Label>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtPhone" runat="server" TextMode="Number" CssClass="form-control" oninput="PhoneSize(this)" placeholder="Enter Phone Number"></asp:TextBox>
                    <asp:Label ID="lblEphone" runat="server" CssClass="text-danger"></asp:Label>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" OnTextChanged="EmailChange" oninput="validateEmail(this)" AutoPostBack="true" placeholder="Email Address"></asp:TextBox>
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
                    <div class="input-col-row">
                        <asp:Label runat="server" Text="Date of Hiring:" AssociatedControlID="txtDate" CssClass="form-label" />
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="input-col-row">
                        <asp:Label runat="server" Text="Department:" AssociatedControlID="ddlDept" CssClass="form-label" /><asp:Label runat="server" Text="" ID="lblEdept" CssClass="text-danger"></asp:Label>
                        <asp:DropDownList ID="ddlDept" runat="server" CssClass="form-select" onchange="selectedDept(this)"></asp:DropDownList>
                    </div>
                    <%-- <div class="input-col-row">
                        <asp:Label runat="server" Text="Role:" AssociatedControlID="ddlRole" CssClass="form-label" /><asp:Label runat="server" Text="" ID="lblRole" CssClass="text-danger"></asp:Label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select" onchange="selectedDept(this)"></asp:DropDownList>
                    </div>--%>
                </div>

                <div class="input-group">
                    <asp:Label runat="server" Text="Upload Image:" AssociatedControlID="fuImage" CssClass="form-label" />
                    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                </div>
                <div class="text-center">
                    <asp:Label ID="lblError" class="btn" runat="server"></asp:Label><br />
                    <asp:Button ID="btnSubmit" class="btn" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" OnClientClick="return fullFormvalidate()" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-secondary" OnClick="btnReset_Click" OnClientClick="return confirm('Are you sure you want to reset the form?');" />
                </div>
            
        </div>
         <a href="Employees.aspx" class="floating-btn" title="Back to Employees"><i class="fas fa-arrow-left"></i></a>
    </div>
</asp:Content>