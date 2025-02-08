<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="P_ManagerHome.aspx.cs" Inherits="WorkNest.Project_Manager.P_ManagerHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .functionality-box {
            padding: 15px;
            margin-bottom: 15px;
            background-color: #f9f9f9;
            border-left: 5px solid #007bff;
            transition: transform 0.3s ease-in-out;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        .functionality-box:hover {
            transform: scale(1.02);
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
        }

        @media (max-width: 480px) { /* Small Mobile */
            .functionality-box {
                padding: 10px;
                font-size: 14px;
            }

            h2 {
                font-size: 18px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2 class="text-center mt-4">Project Manager Dashboard</h2>

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
