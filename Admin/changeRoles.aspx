<%@ Page Title="Change Roles" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="changeRoles.aspx.cs" Inherits="WorkNest.Admin.changeRoles" %>

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
            padding: 0;     
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

       
        input, textarea, select {
            width: 65%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        
        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 10px; 
            margin-top: 15px;
        }

        .btn-submit,
        .btn-reset {
            width: 48%; 
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
            text-align: center;
        }

        .btn-submit {
            background: #007BFF; 
            color: white;
        }
        .btn-submit:hover {
            background: #0056b3;
            transform: scale(1.02);
        }

        .btn-reset {
            background: #FF8C00;
            color: white;
        }
        .btn-reset:hover {
            background: #cc7000;
            transform: scale(1.02);
        }

        .btn-submit:active,
        .btn-reset:active {
            transform: scale(0.98);
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

            input, textarea, select {
                width: 100%;
            }

            .button-group {
                flex-direction: column; 
            }

            .btn-submit,
            .btn-reset {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Header_Title" runat="server">
    Change Roles
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        
        <div class="image-section">
            <img src='<%= ResolveUrl("~/Images/changeInRole.jpg") %>' alt="Placeholder Image" />
        </div>

        <div class="form-section">
            <h2>Change Roles</h2>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <div class="form-group">
                <label for="ddlName">NAME :</label>
                <asp:DropDownList ID="ddlName" runat="server" AutoPostBack="True" OnSelectedIndexChanged="bindCurrentRole">
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="txtCurrentRole">ROLE :</label>
                <asp:TextBox ID="txtCurrentRole" runat="server" ReadOnly="True"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="ddlChangedRole">CHANGE TO :</label>
                <asp:DropDownList ID="ddlChangedRole" runat="server" AutoPostBack="True">
                </asp:DropDownList>
            </div>

            
            <div class="button-group">
                <asp:Button ID="btnUpdateRole" runat="server"
                            Text="UPDATE"
                            CssClass="btn-submit"
                            OnClick="btnUpdateRole_Click" />

                <asp:Button ID="btnReset" runat="server"
                            Text="RESET"
                            CssClass="btn-reset"
                            OnClick="btnReset_Click" />
            </div>
        </div>
    </div>
</asp:Content>
