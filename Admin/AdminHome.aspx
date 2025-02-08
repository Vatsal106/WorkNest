<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="WorkNest.Admin.AdminHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .functionality-box {
            padding: 15px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
            border-left: 5px solid #007bff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h2>Admin Dashboard - Functionalities</h2>
    
    <asp:Repeater ID="rptFunctionalities" runat="server">
        <ItemTemplate>
            <div class="functionality-box">
                <strong><%# Eval("Title") %></strong>
                <p><%# Eval("Description") %></p>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
