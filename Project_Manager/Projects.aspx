<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="WorkNest.Project_Manager.Projects" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <style>
     .project-container {
         display: grid;
         grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
         gap: 20px;
         justify-items: center;
         padding: 20px;
     }

     .project-card {
         width: 100%;
         max-width: 350px;
         background: #fff;
         box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
         border-radius: 12px;
         padding: 20px;
         text-align: left;
         transition: transform 0.3s ease, box-shadow 0.3s ease;
         position: relative;
         overflow: hidden;
     }

         .project-card:hover {
             transform: translateY(-5px);
             box-shadow: 4px 8px 20px rgba(0, 0, 0, 0.2);
         }

     .project-header {
         font-size: 20px;
         font-weight: bold;
         color: #333;
         margin-bottom: 5px;
     }

     .project-description {
         font-size: 14px;
         color: #555;
         margin-bottom: 10px;
     }

     .status-badge {
         padding: 5px 12px;
         border-radius: 5px;
         font-size: 13px;
         font-weight: bold;
         display: inline-block;
     }

     .status-in-progress {
         background: #007bff;
         color: white;
     }

     .status-completed {
         background: #28a745;
         color: white;
     }

     .status-on-hold {
         background: #ffc107;
         color: black;
     }

     .status-in-testing {
         background: #17a2b8;
         color: white;
     }

     .action-buttons {
         display: flex;
         justify-content: space-between;
         margin-top: 15px;
     }

     .btn {margin:3px;
         padding: 8px 14px;
         border: none;
         border-radius: 5px;
         cursor: pointer;
         font-size: 14px;
         transition: background 0.3s ease;
         flex: 1;
         text-align: center;
         text-decoration: none;
     }

     .btn-update {
         background: #007bff;
         color: white;
     }

     .btn-Details {
         background: #ffc107;
         color: black;
     }

     .btn-delete {
         background: #dc3545;
         color: white;
     }

     .btn-Details:hover {
         background: #ff9800;
     }

     .btn-update:hover {
         background: #0056b3;
     }

     .btn-delete:hover {
         background: #c82333;
     }

     .search-container {
         display: flex;
         justify-content: center;
         align-items: center;
         gap: 12px;
         margin-bottom: 25px;
     }

     .search-input {
         width: 320px;
         padding: 10px;
         font-size: 14px;
         border: 1px solid #ccc;
         border-radius: 5px;
     }

     .search-button {
         padding: 10px 15px;
         font-size: 14px;
         border-radius: 5px;
         border: none;
         cursor: pointer;
         background: #007bff;
         color: white;
     }

         .search-button:hover {
             background: #0056b3;
         }
 </style>

    <div class="search-container">
    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" Placeholder="Search projects..." />
    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-button" OnClick="btnSearch_Click" />
</div>

    <div class="project-container">
        <asp:Repeater ID="rptProjects" runat="server" OnItemCommand="rptProjects_ItemCommand">
            <ItemTemplate>
                <div class="project-card">
                    <h3><%# Eval("PROJECT_NAME") %></h3>
                    <p><strong>Description:</strong> <%# Eval("DESCRIPTION") %></p>
                    <p><strong>Start Date:</strong> <%# Eval("START_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>End Date:</strong> <%# Eval("END_DATE", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>Client:</strong> <%# Eval("CLIENT_NAME") %></p>
                   <p>
    <strong>Status:</strong>
    <span class="status-badge <%# GetStatusClass(Eval("STATUS").ToString()) %>">
        <%# Eval("STATUS") %>
    </span>
</p>
                     <div class="action-buttons">
                     <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete"
     CommandName="DeleteProject" CommandArgument='<%# Eval("PROJECT_ID") %>'
     OnClientClick="return confirm('Are you sure you want to delete this project?');" />
                         </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
