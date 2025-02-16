<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="WorkNest.Admin.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .functionality-box {
            padding: 15px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
            border-left: 5px solid #007bff;
        }

        @media (max-width: 1024px) { /* Tablet */
            .functionality-box {
                padding: 12px;
            }
        }

        @media (max-width: 768px) { /* Mobile */
            .functionality-box {
                text-align: center;
            }

        }

        @media (max-width: 480px) { /* Small Mobile */
            .functionality-box {
                padding: 10px;
                font-size: 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="title" ContentPlaceHolderID="Header_Title" runat="server">
    Functionalities
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:Repeater ID="rptfunctionalities" runat="server">
        <ItemTemplate>
            <div class="functionality-box">
                <strong><%# Eval("Title") %></strong>
                <p><%# Eval("Description") %></p>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
