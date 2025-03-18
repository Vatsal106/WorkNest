<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="WorkNest.Admin.AdminProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .profile-container {
            background: #F7F9FB;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 550px;
            margin: 20px auto;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .profile-table {
            width: 100%;
            border-collapse: collapse;
        }

            .profile-table tr {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 8px;
            }

            .profile-table td {
                display: flex;
                align-items: center;
                padding: 5px;
            }

                .profile-table td:first-child {
                    font-weight: bold;
                    color: #333;
                    width: 35%;
                    white-space: nowrap;
                }

        .input-field {
            width: 55%;
            padding: 6px;
            border: 1px solid #8B9EB2;
            border-radius: 4px;
            font-size: 14px;
        }

            .input-field:focus {
                border-color: #FF8C00;
                outline: none;
            }

        .btn {
            background: #4A6D85;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            margin-left: 6px;
            transition: background 0.3s ease-in-out;
        }

            .btn:hover {
                background: #FF8C00;
            }

        .profile-image {
            border-radius: 50%;
            border: 3px solid #8B9EB2;
            width: 60px;
            height: 60px;
        }

        .error-message {
            text-align: center;
            font-weight: bold;
            font-size: 12px;
            color: red;
            margin-top: 8px;
        }
    </style>
    <script>
    function checkName(input) {
        const name = input.value.trim();
        const Fname = name.split(' ');
        const lblE = document.getElementById('<%= lblEname.ClientID %>');

        if (Fname.length < 2 || !isNaN(Fname[1])) {
            lblE.textContent = "Enter full name!!";
            lblE.style.color = "red";
        } else {
            lblE.textContent = "";
        }
    }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Admin Profile
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlProfile" runat="server" CssClass="profile-container">
        <table class="profile-table">
            <tr>
                <td><strong>Profile Image:</strong></td>
                <td>
                    <asp:Image ID="imgProfile" runat="server" Width="100px" Height="100px" CssClass="profile-image" />
                    <br />
                    <asp:Button ID="btnEditImage" runat="server" Text="✏️" CssClass="btn" OnClick="btnEditImage_Click" />
                    <asp:FileUpload ID="fuProfileImage" runat="server" CssClass="file-upload" Visible="false" />
                    <asp:Button ID="btnUploadImage" runat="server" Text="⬆️" CssClass="btn" OnClick="btnUploadImage_Click" Visible="false" />
                    <asp:Button ID="btnCancelImage" runat="server" Text="❌" CssClass="btn" OnClick="btnCancelImage_Click" CommandArgument="Image" Visible="false" />

                </td>
            </tr>
            <tr>
                <td><strong>Employee ID:</strong></td>
                <td>
                    <asp:Label ID="lblEmpID" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td><strong>Username:</strong></td>
                <td>
                    <asp:Label ID="lblUsername" runat="server"></asp:Label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" Visible="false" OnTextChanged="checkUser"></asp:TextBox>
                    <asp:Button ID="btnEditUsername" runat="server" Text="✏️" CssClass="btn" OnClick="btnEditUsername_Click" />
                    <asp:Button ID="btnSaveUsername" runat="server" Text="💾" CssClass="btn" OnClick="btnSaveUsername_Click" Visible="false" />
                    <asp:Button ID="btnCancelUsername" runat="server" Text="❌" CssClass="btn" OnClick="btnCancelUsername_Click" CommandArgument="Username" Visible="false" />

                </td>
            </tr>
            <tr>
                <td><strong>Password:</strong></td>
                <td>
                    <asp:Label ID="lblPassword" runat="server" Text="********"></asp:Label>
                    <asp:Button ID="btnShowPassword" runat="server" Text="👁️" CssClass="btn" OnClick="btnShowPassword_Click" />
                </td>
            </tr>
            <tr>
                <td><strong>Full Name:</strong></td>
                <td>
                    <asp:Label ID="lblFullName" runat="server"></asp:Label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="input-field" Visible="false" oninput="checkName(this)"></asp:TextBox>
                    <asp:Button ID="btnEditFullName" runat="server" Text="✏️" CssClass="btn" OnClick="btnEditFullName_Click" />
                    <asp:Button ID="btnSaveFullName" runat="server" Text="💾" CssClass="btn" OnClick="btnSaveFullName_Click" Visible="false" />
                    <asp:Button ID="btnCancelFullName" runat="server" Text="❌" CssClass="btn" OnClick="btnCancelFullName_Click" Visible="false" />
                    <asp:Label ID="lblEname" runat="server" CssClass="error-message"></asp:Label>
                </td>
            </tr>
            <tr>
                <td><strong>Email:</strong></td>
                <td>
                    <asp:Label ID="lblEmail" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td><strong>Phone:</strong></td>
                <td>
                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="input-field" Visible="false"></asp:TextBox>
                    <asp:Button ID="btnEditPhone" runat="server" Text="✏️" CssClass="btn" OnClick="btnEditPhone_Click" />
                    <asp:Button ID="btnSavePhone" runat="server" Text="💾" CssClass="btn" OnClick="btnSavePhone_Click" Visible="false" />
                    <asp:Button ID="btnCancelPhone" runat="server" Text="❌" CssClass="btn" OnClick="btnCancelPhone_Click" Visible="false" />

                </td>
            </tr>
            <tr>
                <td><strong>Hire Date:</strong></td>
                <td>
                    <asp:Label ID="lblHireDate" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td><strong>Department:</strong></td>
                <td>
                    <asp:Label ID="lblDepartment" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td><strong>Role:</strong></td>
                <td>
                    <asp:Label ID="lblRole" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <asp:Label ID="lblError" runat="server" CssClass="error-message" ForeColor="Red" Visible="false"></asp:Label>

            </tr>
        </table>
    </asp:Panel>
</asp:Content>
