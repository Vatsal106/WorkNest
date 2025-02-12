<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addClient.aspx.cs" Inherits="WorkNest.Admin.addClient" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Client</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f8f9fa;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 900px;
            background: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .image-section {
            width: 50%;
            background: #e9ecef;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px; /* Ensures proper spacing */
        }

        .image-section img {
            width: 100%;
            height: auto;
            border-radius: 10px;
            object-fit: cover; /* Ensures full image coverage */
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

        label {
            font-weight: bold;
            display: block;
            margin: 10px 0 5px;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-submit:hover {
            background: #218838;
        }

        @media screen and (max-width: 768px) {
            .container {
                flex-direction: column;
                width: 90%;
            }

            .image-section {
                width: 100%;
                height: 250px;
                padding: 10px; /* Adjust padding for mobile */
            }

            .form-section {
                width: 100%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Image Section -->
        <div class="image-section">
            <img src='<%= ResolveUrl("~/Images/ClientPagePhoto.png") %>' alt="Client Image" />
        </div>

        <!-- Form Section -->
        <div class="form-section">
            <h2>Add Client</h2>
            <form id="form1" runat="server">
                <label>CLIENT NAME :</label>
                <asp:TextBox ID="txtClientName" runat="server"></asp:TextBox>

                <label>EMAIL :</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>

                <label>PHONE NUMBER :</label>
                <asp:TextBox ID="txtPhoneNumber" runat="server" TextMode="Number"></asp:TextBox>

                <label>COMPANY NAME :</label>
                <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>

                <label>ADDRESS :</label>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>

                <asp:Button ID="btnSubmit" runat="server" CssClass="btn-submit" OnClick="btnSubmit_Click" Text="SUBMIT" />

                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            </form>
        </div>
    </div>
</body>
</html>
