<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProject.aspx.cs" Inherits="WorkNest.Admin.addProject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            min-height: 100vh;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 1200px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
        }

        #im {
            width: 40%;
            height: auto;
            display: block;
        }

        form {
            background-color: #8B9EB2;
            padding: 20px;
            width: 60%;
            box-sizing: border-box;
            border-radius: 0 10px 10px 0;
        }

        #formTitle { /* Style for the title */
            font-weight: bold;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            color: #0D0D30; /* Corrected color code */
            text-align: center; /* Center the title */
            margin-bottom: 20px; /* Add some space below */
            font-size: 1.2em; /* Slightly larger font size */
        }

        form div {
            display: grid;
            grid-template-columns: 120px 1fr; /* Increased label width slightly */
            gap: 10px;
            align-items: center;
            margin-bottom: 10px;
        }

        #pp {
            font-weight: bold;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            color: #0D0D30; /* Corrected color code */
            text-align: right;
            padding-right: 5px;
        }

        #txtProjectName, #txtDesc, #dateStart, #dateEnd, #ddlStatus, #ddlProjectManager, #ddlClient {
            padding: 7px;
            border-radius: 5px;
            box-sizing: border-box;
            width: calc(100% - 14px);
            font-size: smaller; /* Make the fields smaller */
        }

        #txtDesc {
            height: 60px;
        }

        .button-container {
            grid-column: 1 / 3;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        #btnSubmit, #btnReset {
            background-color: skyblue;
            color: black;
            padding: 8px 16px;
            display: inline-block;
            width: auto;
            border-radius: 5px;
            transition: 0.3s;
            cursor: pointer;
            font-size: smaller; /* Make the buttons smaller */
        }

        #btnSubmit:hover, #btnReset:hover {
            background-color: white;
            color: skyblue;
        }

        #lblError {
            color: red;
            font-weight: bold;
            margin-top: 10px;
            text-align: center;
            font-size: smaller;
        }


         h1{
    font-weight: bold;
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
    color: #0D0D30;
    display:flex;
    text-align: center; 
    margin-bottom: 20px;
    font-size: 30px;
} 


    </style>

</head>
<body>
    <div class="container">
        <img id="im" src="../images/Project Add image.png" alt="Project Image" />
        <form id="addProject" runat="server">
            <div><h1>Add Project</h1></div> <%-- Title in same line and centered --%>
            <div><label id="pp">Project Name:</label><asp:TextBox ID="txtProjectName" runat="server"></asp:TextBox></div>
            <div><label id="pp">Description:</label><asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"></asp:TextBox></div>
            <div><label id="pp">Start Date:</label><asp:TextBox ID="dateStart" runat="server" TextMode="Date"></asp:TextBox></div>
            <div><label id="pp">End Date:</label><asp:TextBox ID="dateEnd" runat="server" TextMode="Date"></asp:TextBox></div>
            <div><label id="pp">Status:</label><asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True"></asp:DropDownList></div>
            <div><label id="pp">Project Manager:</label><asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True"></asp:DropDownList></div>
            <div><label id="pp">Client:</label><asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True"></asp:DropDownList></div>

            <div class="button-container">
                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SUBMIT" />
                <asp:Button ID="btnReset" runat="server" Text="RESET" OnClick="btnReset_Click" />
            </div>

            <asp:Label ID="lblError" runat="server"></asp:Label>
        </form>
    </div>
</body>
</html>