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
            background-color: white;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 900px;
            background: #8B9EB2;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
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

        /* Form Layout */
        .form-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

/*        label {
            font-weight: bold;
            width: 30%;
            text-align: right;
            margin-right: 10px;
        }*/

       label {
           font-weight: bold;
           width: 35%; /* Increase width to fit long labels */
           text-align: right;
           margin-right: 10px;
           white-space: nowrap; /* Prevents label text from wrapping */
       }


        input, textarea {
            width: 65%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-submit:hover {
            background: #0056b3;
        }

        /* Responsive Styles */
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

                <div class="form-group">
                    <label for="txtClientName">Client Name:</label>
                    <asp:TextBox ID="txtClientName" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtEmail">Email:</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtPhoneNumber">Phone Number:</label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" TextMode="Number"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtCompanyName">Company Name:</label>
                    <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtAddress">Address:</label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:Button ID="btnSubmit" runat="server" CssClass="btn-submit" OnClick="btnSubmit_Click" Text="Submit" />
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

            </form>
        </div>
    </div>
</body>
</html>
