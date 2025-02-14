<%@ Page Title="Add Client" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="addClients.aspx.cs" Inherits="WorkNest.Admin.addClients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 900px;
            background: #8B9EB2;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            margin: 0 auto;
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

        .form-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            width: 35%;
            text-align: right;
            margin-right: 10px;
            white-space: nowrap;
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Header_Title" runat="server">
    Add Client
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="image-section">
            <img src='<%= ResolveUrl("~/Images/ClientPagePhoto.png") %>' alt="Client Image" />
        </div>

        <div class="form-section">
            <h2>Add Client</h2>
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
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
        </div>
    </div>
</asp:Content>
