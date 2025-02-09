<%@ Page Title="" Language="C#" MasterPageFile="~/P_Member/MemberM.Master" AutoEventWireup="true" CodeBehind="MemberHome.aspx.cs" Inherits="WorkNest.P_Member.MemberHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head3" runat="server">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .dashboard-box {
            padding: 15px;
            margin-bottom: 15px;
            background-color: #f1f1f1;
            border-left: 5px solid #28a745;
            transition: transform 0.3s ease-in-out;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        .dashboard-box:hover {
            transform: scale(1.02);
        }

        .dashboard-header {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Responsive Styling */
        @media (max-width: 768px) { /* Tablet & Mobile */
            .dashboard-box {
                text-align: center;
            }
        }

        @media (max-width: 480px) { /* Small Mobile */
            .dashboard-box {
                padding: 10px;
                font-size: 14px;
            }

            h2 {
                font-size: 18px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div class="container">
        <div class="dashboard-header">
            <h2>Project Member</h2>
        </div>
        
        <div class="row mt-4">
            <asp:Repeater ID="rptProjectMemberTasks" runat="server">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6 col-sm-12 col-12 mb-3">
                        <div class="dashboard-box">
                            <strong><%# Eval("Title") %></strong>
                            <p><%# Eval("Description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
