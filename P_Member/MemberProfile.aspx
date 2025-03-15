<%@ Page Title="" Language="C#" MasterPageFile="~/P_Member/MemberM.Master" AutoEventWireup="true" CodeBehind="MemberProfile.aspx.cs" Inherits="WorkNest.P_Member.MemberProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Member_Head" runat="server">
     <style>
     /* ====== General Styling ====== */
     .profile-container {
         background: #F7F9FB;
         padding: 15px;
         border-radius: 10px;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
         max-width: 550px;
         margin: 20px auto;
         font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
     }

     /* ====== Table Styling ====== */
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

     /* ====== Input Fields ====== */
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

     /* ====== Buttons ====== */
     .btn-edit, .btn-save, .btn-toggle, .btn-upload {
         background: #4A6D85;
         color: white;
         padding: 5px 10px;
         border: none;
         border-radius: 4px;
         cursor: pointer;
         font-size: 12px;
         font-weight: bold;
         margin-left: 6px;
         transition: background 0.3s ease-in-out;
     }

         .btn-edit:hover, .btn-save:hover, .btn-toggle:hover, .btn-upload:hover {
             background: #FF8C00;
         }

     /* ====== Profile Image Styling ====== */
     .profile-image {
         border-radius: 50%;
         border: 3px solid #8B9EB2;
         width: 60px;
         height: 60px;
     }

     /* ====== Error Message ====== */
     .error-message {
         text-align: center;
         font-weight: bold;
         font-size: 12px;
         color: red;
         margin-top: 8px;
     }

     /* ====== Mobile Optimization ====== */
     @media (max-width: 600px) {
         .profile-container {
             width: 95%;
             padding: 10px;
         }

         .profile-table tr {
             flex-direction: column;
             align-items: flex-start;
         }

         .input-field {
             width: 100%;
         }

         .btn-edit, .btn-save, .btn-toggle, .btn-upload {
             width: auto;
             margin-top: 4px;
         }
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
<asp:Content ID="Content2" ContentPlaceHolderID="Member_Head_Title" runat="server">
    Member Profile
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Member_Content" runat="server">
      <asp:Panel ID="pnlProfile" runat="server" CssClass="profile-container">
      <table class="profile-table">
          <tr>
              <td><strong>Profile Image:</strong></td>
              <td>
                  <asp:Image ID="imgProfile" runat="server" Width="100px" Height="100px" CssClass="profile-image" />
                  <br />
                  <asp:Button ID="btnEditImage" runat="server" Text="Edit" CssClass="btn-edit" OnClick="btnEditImage_Click" />
                  <asp:FileUpload ID="fuProfileImage" runat="server" CssClass="file-upload" Visible="false" />
                  <asp:Button ID="btnUploadImage" runat="server" Text="Upload" CssClass="btn-upload" OnClick="btnUploadImage_Click" Visible="false" />
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
                  <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" OnTextChanged="checkUser" Visible="false"></asp:TextBox>
                  <asp:Button ID="btnEditUsername" runat="server" Text="Edit" CssClass="btn-edit" OnClick="btnEditUsername_Click" />
                  <asp:Button ID="btnSaveUsername" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSaveUsername_Click" Visible="false" />
              </td>
          </tr>

          <tr>
              <td><strong>Password:</strong></td>
              <td>
                  <asp:Label ID="lblPassword" runat="server" Text="********"></asp:Label>
                  <asp:Button ID="btnShowPassword" runat="server" Text="Show" CssClass="btn-toggle" OnClick="btnShowPassword_Click" />
              </td>
          </tr>



          <tr>
              <td><strong>Full Name:</strong></td>
              <td>
                  <asp:Label ID="lblFullName" runat="server"></asp:Label>
                  <asp:TextBox ID="txtFullName" runat="server" CssClass="input-field" Visible="false" oninput="checkName(this)"></asp:TextBox>
                  <asp:Button ID="btnEditFullName" runat="server" Text="Edit" CssClass="btn-edit" OnClick="btnEditFullName_Click" />
                  <asp:Button ID="btnSaveFullName" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSaveFullName_Click" Visible="false" />
                  <asp:Label ID="lblEname" runat="server" CssClass="error-message"></asp:Label>
              </td>
          </tr>

          <tr>
              <td><strong>Email:</strong></td>
              <td>
                  <asp:Label ID="lblEmail" runat="server"></asp:Label>
              </td>
          </tr>

          <tr>
              <td><strong>Phone:</strong></td>
              <td>
                  <asp:Label ID="lblPhone" runat="server"></asp:Label>
                  <asp:TextBox ID="txtPhone" runat="server" CssClass="input-field" Visible="false"></asp:TextBox>
                  <asp:Button ID="btnEditPhone" runat="server" Text="Edit" CssClass="btn-edit" OnClick="btnEditPhone_Click" />
                  <asp:Button ID="btnSavePhone" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSavePhone_Click" Visible="false" />
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
      </table>
      <asp:Label ID="lblError" runat="server" CssClass="error-message" ForeColor="Red" Visible="false"></asp:Label>
  </asp:Panel>
</asp:Content>
