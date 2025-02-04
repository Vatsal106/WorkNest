<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorkNest.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | WorkNest</title>
    <%--<link rel="stylesheet" type="text/css" href="Style.css" />--%>
    <style>
        /* Reset and Base Styles */
body, html {
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Poppins', sans-serif;
    background: #eef2f7;
}

/* Main Container */
.container {
    display: flex;
    width: 80%;
    max-width: 900px;
    height: 500px;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: rgb(38, 57, 77) 0px 20px 30px -10px;
    background: white;
    align-items: center; /* Ensures both sections are aligned */
}
/* Left Section (Image) */
.image-section {
    width: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #eef2f7;
}

.login-image {
    width: 100%;
    height: 100%;
    object-fit: cover; /* Ensures the image scales properly */
}

/* Right Section (Login Form) */
.form-section {
    width: 50%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 40px;
    background: #8B9EB2;
    color:#0D0D30;
    height:100%;
}
h2 {
    font-size: 28px;
    font-weight: 600;
    margin-bottom: 10px;
    color:#0D0D30 ;
}

.subtext {
    font-size: 14px;
    color: #0D0D30;
    margin-bottom: 20px;
}

/* Input Fields */
.input-group {
    width: 100%;
    margin-bottom: 15px;
}

.input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    transition: 0.3s ease-in-out;
}

    .input:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0px 0px 8px rgba(0, 123, 255, 0.3);
    }

/* Button Styling */
.button-group {
    width: 100%;
}

.button {
    width: 100%;
    padding: 12px;
    border: none;
    background: #007bff;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    border-radius: 6px;
    transition: 0.3s ease-in-out;
}

    .button:hover {
        background: #0056b3;
    }

/* Sign-Up Link */
.bottom-text {
    font-size: 14px;
    margin-top: 10px;
    color: #666;
}

.signup-link {
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
}

    .signup-link:hover {
        text-decoration: underline;
    }

/* Error Message */
.error-message {
    color: red;
    font-size: 14px;
    margin-top: 10px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        flex-direction: column;
        width: 90%;
    }

    .image-section {
        width: 100%;
        height: 200px;
    }

    .form-section {
        width: 100%;
        padding: 30px;
    }

    .login-image {
        border-radius: 15px 15px 0 0;
    }
}

    </style>
</head>
<body>
    <div class="container">
        <!-- Left Half: Image Section -->
        <div class="image-section">
            <asp:Image ID="LoginImg" runat="server" ImageUrl="~/Images/LOGINIMAGE.png" CssClass="login-image"/>
        </div>

        <!-- Right Half: Form Section -->
        <div class="form-section">
            <form id="form1" runat="server">
                <h2>Welcome Back 👋</h2>
                <p class="subtext">Please enter your credentials to sign in.</p>

                <div class="input-group">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input" Placeholder="Username"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" Placeholder="Password"></asp:TextBox>
                </div>
                <div class="button-group input-group">
                    <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="button" OnClick="btnLogin_Click" />
                </div>

                <p class="bottom-text">
                    Don't have an account? Contact Admin/Management!! 
                   
                </p>

                <asp:Label runat="server" ID="lblMessage" CssClass="error-message"></asp:Label>
            </form>
        </div>
    </div>
</body>
</html>
