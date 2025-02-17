<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="P_ManagerDashboard.aspx.cs" Inherits="WorkNest.Project_Manager.P_ManagerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .Manager_Header_Title {
            color: black;
            font-size: 20px;
            margin-left: 0px;
            text-align: center;
        }

        @media (max-width: 768px) { /* Mobile */


            .Manager_Header_Title {
                font-size: 20px;
                text-align: center;
            }
        }

        @media (max-width: 480px) { /* Small Mobile */


            .Manager_Header_Title {
                font-size: 20px;
                text-align: center;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    <div class="Manager_Header_Title">Dashboard</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
</asp:Content>
