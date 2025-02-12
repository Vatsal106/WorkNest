<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProject.aspx.cs" Inherits="WorkNest.Admin.addProject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0;
        min-height: 100vh;
        padding: 20px;
    }

    .container {
        display: flex;
        width: 65%; /* Increased width */
        max-width: 1000px;
        box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.3); /* Increased shadow */
        border-radius: 10px;
        overflow: hidden;
        background: white;
        padding:0px;
    }

    #im {
        width: 45%;
        max-width: 100%;
        height: auto;
        display: block;
    }

    form {
        background-color: #8B9EB2;
        padding: 30px;
        width: 55%;
        box-sizing: border-box;
        border-radius: 0 10px 10px 0;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    h1 {
        font-weight: bold;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        color: #0D0D30;
        text-align: center;
        margin-bottom: 15px;
        font-size: 28px;
    }

    form div {
        display: grid;
        grid-template-columns: 140px 1fr;
        gap: 10px;
        align-items: center;
        margin-bottom: 8px;
        width: 100%;
        max-width: 450px;
    }

    #pp {
        font-weight: bold;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        color: #0D0D30;
        text-align: right;
        padding-right: 5px;
    }

    /* Input Fields */
    #txtProjectName, #txtDesc, #dateStart, #dateEnd, #ddlStatus, #ddlProjectManager, #ddlClient {
        padding: 10px;
        border-radius: 5px;
        box-sizing: border-box;
        width: 100%;
        font-size: 14px;
        border: none;  /* Removed Borders */
        outline: none;
    }

    #txtDesc {
        height: 60px;
    }

    /* Bootstrap Button Styles */
    .button-container {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 15px;
        width: 100%;
    }

    .btn-custom {
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 14px;
        font-weight: bold;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .container {
            flex-direction: column;
            width: 90%;
        }

        #im {
            display: none; /* Hide image on small screens */
        }

        form {
            width: 100%;
            border-radius: 10px;
        }

        form div {
            grid-template-columns: 1fr;
            text-align: left;
        }

        #pp {
            text-align: left;
            padding-bottom: 5px;
        }

        .button-container {
            flex-direction: column;
        }
    }
</style>



</head>
<body>
  <div class="container">
    <img id="im" src="../images/Project Add image.png" alt="Project Image" />
    <form id="addProject" runat="server">
        <h1>Add Project</h1>
        <div><label id="pp">Project Name:</label><asp:TextBox ID="txtProjectName" runat="server"></asp:TextBox></div>
        <div><label id="pp">Description:</label><asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"></asp:TextBox></div>
        <div><label id="pp">Start Date:</label><asp:TextBox ID="dateStart" runat="server" TextMode="Date"></asp:TextBox></div>
        <div><label id="pp">End Date:</label><asp:TextBox ID="dateEnd" runat="server" TextMode="Date"></asp:TextBox></div>
        <div><label id="pp">Status:</label><asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True"></asp:DropDownList></div>
        <div><label id="pp">Project Manager:</label><asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True"></asp:DropDownList></div>
        <div><label id="pp">Client:</label><asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True"></asp:DropDownList></div>

        <!-- Bootstrap Styled Buttons -->
        <div class="button-container">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary btn-custom" OnClick="btnSubmit_Click" Text="SUBMIT" />
            <asp:Button ID="btnReset" runat="server" CssClass="btn btn-secondary btn-custom" Text="RESET" OnClick="btnReset_Click" />
        </div>

        <asp:Label ID="lblError" runat="server"></asp:Label>
    </form>
</div>
</body>
</html>