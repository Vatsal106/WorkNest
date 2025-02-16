<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="WorkNest.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            height: 100vh; /* Full viewport height */
        }


        .dashboard-panel {
            flex: 1 0 0%;
            border: 1px solid #ccc;
            padding: 20px;
            box-sizing: border-box;
            overflow-y: scroll; /* Enable scrolling */
            height: 100%;
            scrollbar-width: none; /* For Firefox */
        }

            /* Hide scrollbar for Webkit-based browsers (Chrome, Safari, Edge) */
            .dashboard-panel::-webkit-scrollbar {
                display: none;
            }

        .vertical-line {
            border-left: 1px solid #ccc;
            height: 100%;
            margin: 0 10px;
        }

        @media (max-width: 768px) {
            .dashboard-panel {
                flex-basis: 100%; /* Full width on smaller screens */
                margin-bottom: 10px;
                height: auto; /* Allow panels to take full available height when stacked */
            }

            .vertical-line {
                display: none;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
    Dashboard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <div class="dashboard-panel">
            <h2>Panel 1</h2>
            <p>Content for panel 1. Add lots of content here to test scrolling. For example:</p>
            <%-- Add your controls and content for panel 1 here --%>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>

            <%-- More Example Content --%>
            <p>This is some more content for panel 1.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 1.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 1.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 1.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 1.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 1.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 1.</p>
            <p>More content...</p>
            <p>Even more content...</p>

        </div>
        <div class="vertical-line"></div>
        <div class="dashboard-panel">
            <h2>Panel 2</h2>
            <p>Content for panel 2. Add lots of content here to test scrolling.</p>
            <%-- Add your controls and content for panel 2 here --%>
            <%-- More Example Content --%>
            <p>This is some more content for panel 2.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 2.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 2.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 2.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 2.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 2.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 2.</p>
            <p>More content...</p>
            <p>Even more content...</p>
        </div>
        <div class="vertical-line"></div>
        <div class="dashboard-panel">
            <h2>Panel 3</h2>
            <p>Content for panel 3. Add lots of content here to test scrolling.</p>
            <%-- Add your controls and content for panel 3 here --%>
            <%-- More Example Content --%>
            <p>This is some more content for panel 3.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 3.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 3.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 3.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 3.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 3.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 3.</p>
            <p>More content...</p>
            <p>Even more content...</p>
        </div>
        <div class="vertical-line"></div>
        <div class="dashboard-panel">
            <h2>Panel 4</h2>
            <p>Content for panel 4. Add lots of content here to test scrolling.</p>
            <%-- Add your controls and content for panel 4 here --%>
            <%-- More Example Content --%>
            <p>This is some more content for panel 4.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 4.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 4.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 4.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 4.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 4.</p>
            <p>More content...</p>
            <p>Even more content...</p>
            <p>This is some more content for panel 4.</p>
            <p>More content...</p>
            <p>Even more content...</p>
        </div>
    </div>
</asp:Content>
