<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="WorkNest.Admin.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        body {
            background: #F7F9FB;
            color: #333;
            font-family: Arial, sans-serif;
        }

        .hero-section {
            background: url('Images/company-banner.jpg') center/cover no-repeat;
            padding: 100px 20px;
            text-align: center;
            color: white;
        }

        .hero-text {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .sub-text {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .btn-learn-more {
            background: #FF8C00;
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }

        .section {
            padding: 50px 20px;
            text-align: center;
        }

            .section h2 {
                font-size: 28px;
                margin-bottom: 20px;
                color: #4A6D85;
            }

        .client-reviews, .achievements, .features, .team, .stats {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: left;
        }

        .card-title {
            font-weight: bold;
            color: #007bff;
            margin-top: 10px;
        }

        .stats-card {
            font-size: 24px;
            font-weight: bold;
            background: #4A6D85;
            color: white;
            padding: 20px;
            border-radius: 8px;
            width: 200px;
            text-align: center;
        }

        .cta-section {
            text-align: center;
            padding: 40px 20px;
            background: #4A6D85;
            color: white;
        }

        .cta-btn {
            background: #FF8C00;
            color: white;
            padding: 15px 25px;
            border: none;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-text">Welcome to WorkNest</div>
        <div class="sub-text">Your trusted partner in project and employee management.</div>
        <asp:Button ID="btnLearnMore" runat="server" Text="Learn More" CssClass="btn-learn-more" />
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
            <div class="stats-card">💼
                <asp:Label ID="lblTotalProject" runat="server" Text="0"></asp:Label>
                Projects</div>
            <div class="stats-card">👨‍💻
                <asp:Label ID="lblTotalEmployee" runat="server" Text="0"></asp:Label>
                Employees</div>
            <div class="stats-card">📊
                <asp:Label ID="lblTotalTask" runat="server" Text="0"></asp:Label>
                Tasks Completed</div>
        </div>
    </div>


    <!-- Call to Action -->
    <div class="cta-section">
        <h2>Ready to Get Started?</h2>
        <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="cta-btn" PostBackUrl="~/Login.aspx" />
    </div>

</asp:Content>
