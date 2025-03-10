﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="P_ManagerHome.aspx.cs" Inherits="WorkNest.Project_Manager.P_ManagerHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        <style>
            .functionality-box {
                padding: 15px;
                margin-bottom: 15px;
                background-color: #f9f9f9;
                border-left: 5px solid #007bff;
                transition: transform 0.3s ease-in-out;
                border-radius: 8px;
                height: 100px;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            }

            .functionality-box:hover {
                transform: scale(1.02);
            }

            .Manager_Header_Title {
                color: black;
                font-size: 20px;
                margin-left: 0px;
                text-align: center;
            }

            /* Responsive Styling */
            @media (max-width: 1024px) { /* Tablet */
                .functionality-box {
                    padding: 12px;
                }
            }

            @media (max-width: 768px) { /* Mobile */
                .functionality-box {
                    text-align: center;
                }

                .Manager_Header_Title {
                    font-size: 20px;
                    text-align: center;
                }
            }

            @media (max-width: 480px) { /* Small Mobile */
                .functionality-box {
                    padding: 10px;
                    font-size: 14px;
                }

                .Manager_Header_Title {
                    font-size: 20px;
                    text-align: center;
                }
            }
        </style>
</asp:Content>
<asp:Content ID="PM_Title" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    <div class="Manager_Header_Title">Project Manager Dashboard</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="container">
        <div class="row mt-4">
            <asp:Repeater ID="rptFunctionalities" runat="server">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6 col-sm-12 col-12 mb-3">
                        <div class="functionality-box shadow-sm p-3">
                            <p><%# Eval("Description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
