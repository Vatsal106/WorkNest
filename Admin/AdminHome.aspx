<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="WorkNest.Admin.AdminHome" %>

<asp:content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        /* General Styles */
        body {
            background: #F7F9FB;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Hero Section */
        .hero-section {
            background: url('../Images/ADMIN HOME PAGE (2).jpg') center/cover no-repeat;
            padding: 120px 20px;
            text-align: center;
            color: darkgray;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color:white;
        }

        .hero-text {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 15px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }

        .sub-text {
            font-size: 20px;
            max-width: 600px;
            line-height: 1.5;
            margin-bottom: 25px;
        }

        .btn-learn-more {
            background: #FF8C00;
            color: white;
            padding: 14px 24px;
            border: none;
            cursor: pointer;
            font-size: 18px;
            border-radius: 6px;
            transition: 0.3s ease-in-out;
        }

            .btn-learn-more:hover {
                background: #e67e00;
            }

        /* Sections */
        .section {
            padding: 60px 20px;
            text-align: center;
        }

            .section h2 {
                font-size: 30px;
                margin-bottom: 20px;
                color: #4A6D85;
                text-transform: uppercase;
            }

            .section p {
                font-size: 18px;
                color: #555;
                max-width: 800px;
                margin: 0 auto;
                line-height: 1.6;
            }

        /* Cards */
        .features,
        .client-reviews,
        .achievements,
        .stats {
            display: flex;
            justify-content: center;
            gap: 25px;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            width: 320px;
            text-align: left;
            transition: transform 0.3s ease-in-out;
        }

            .card:hover {
                transform: translateY(-5px);
            }

        .card-title {
            font-weight: bold;
            color: #4A6D85;
            margin-top: 12px;
        }

        .stats-card {
            font-size: 26px;
            font-weight: bold;
            background: #4A6D85;
            color: white;
            padding: 25px;
            border-radius: 10px;
            width: 220px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        /* Call to Action */
        .cta-section {
            text-align: center;
            padding: 50px 20px;
            background: #4A6D85;
            color: white;
        }

        .cta-btn {
            background: #FF8C00;
            color: white;
            padding: 16px 28px;
            border: none;
            font-size: 20px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s ease-in-out;
        }

            .cta-btn:hover {
                background: #e67e00;
            }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-text {
                font-size: 28px;
            }

            .sub-text {
                font-size: 16px;
            }

            .btn-learn-more {
                font-size: 16px;
                padding: 12px 20px;
            }

            .stats-card {
                width: 180px;
                font-size: 22px;
            }

            .card {
                width: 100%;
                max-width: 350px;
            }
        }
    </style>
</asp:content>
    <asp:Content ID="Title" ContentPlaceHolderID="Header_Title" runat="server">
        Welcome to WorkNest
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-text">Welcome to WorkNest</div>
        <div class="sub-text">Your trusted partner in project and employee management.</div>
        <asp:Button ID="btnLearnMore" runat="server" Text="Learn More" CssClass="btn-learn-more" PostBackUrl="~/Admin/AdminDashboard.aspx" />
    </div>

    <!-- About Us -->
    <div class="section">
        <h2>About WorkNest</h2>
        <p>WorkNest is a powerful platform designed to streamline project and employee management for companies. We provide a seamless workflow, enhanced collaboration, and efficiency-driven solutions.</p>
    </div>

    <!-- Key Features -->
    <div class="section">
        <h2>Core Features</h2>
        <div class="features">
            <div class="card">
                <p>📂 <b>Project Tracking</b> - Manage projects efficiently.</p>
            </div>
            <div class="card">
                <p>👨‍💻 <b>Employee Management</b> - Keep track of workforce.</p>
            </div>
            <div class="card">
                <p>📊 <b>Task Reporting</b> - Generate reports for insights.</p>
            </div>
        </div>
    </div>

    <!-- Client Reviews -->
    <div class="section">
        <h2>What Our Clients Say</h2>
        <div class="client-reviews">
            <div class="card">
                <p>
                    <asp:Label ID="lblReview1" runat="server" Text="Loading..."></asp:Label>
                </p>
                <span class="card-title">
                    <asp:Label ID="lblClient1" runat="server" Text=""></asp:Label>
                </span>
            </div>
            <div class="card">
                <p>
                    <asp:Label ID="lblReview2" runat="server" Text="Loading..."></asp:Label>
                </p>
                <span class="card-title">
                    <asp:Label ID="lblClient2" runat="server" Text=""></asp:Label>
                </span>
            </div>
        </div>
    </div>


    <!-- Company Achievements -->
    <div class="section">
        <h2>Our Achievements</h2>
        <div class="achievements">
            <div class="card">
                <p>🏆 Best Project Management Platform 2024</p>
                <span class="card-title">Awarded by TechReview</span>
            </div>
            <div class="card">
                <p>🚀 10,000+ Projects Managed</p>
                <span class="card-title">Trusted by industry leaders</span>
            </div>
        </div>
    </div>

    <!-- Statistics -->
    <div class="section">
        <h2>WorkNest in Numbers</h2>
        <div class="stats">
            <div class="stats-card">
                💼
                <asp:Label ID="lblTotalProject" runat="server" Text="0"></asp:Label><br />
                Projects
            </div>
            <div class="stats-card">
                👨‍💻
                <asp:Label ID="lblTotalEmployee" runat="server" Text="0"></asp:Label><br />
                Employees
            </div>
            <div class="stats-card">
                📊
                <asp:Label ID="lblTotalTask" runat="server" Text="0"></asp:Label><br />
                Tasks Completed
            </div>
        </div>
    </div>


    
</asp:Content>
