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

        form {
            background-color: #0A0A32;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 50%;
            max-width: 500px;
            display: flex;
            flex-direction: column;
            
        }

        form div {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
        }

        #pp {
            font-weight: bold;
            margin-bottom: 5px;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            color: white;
        }

        #txtProjectName, #txtDesc, #dateStart, #dateEnd, #ddlStatus, #ddlProjectManager, #ddlClient {
            padding: 7px;
            margin: 5px 0;
            border-radius: 5px;
            box-sizing: border-box;
            width: calc(100% - 14px); 
        }

        #txtDesc {
            height: 60px;
        }

        #btnSubmit, #btnReset {
            background-color: skyblue;
            color: black;
            padding: 8px;
            display: block;
            margin: 10px auto;
            width: 95%;
            border-radius: 5px; 
            transition: 0.3s;
            box-sizing: border-box;
        }

        #btnSubmit:hover, #btnReset:hover {
            background-color: white;
            cursor: pointer;
            color: skyblue;
        }

        #lblError {
            color: red;
            font-weight: bold;
            margin-top: 10px;
            text-align: center;
            font-size: smaller;
        }

        #im {
            height:750px;
            width:35%;
            
        }
    </style>

</head>
<body>

     <img id="im" src="../images/Project Add image.png" alt="Alternate Text"/>



    <form id="addProject" runat="server">
        <div><label id="pp">Project Name:</label><asp:TextBox ID="txtProjectName" runat="server"></asp:TextBox></div>
        <div><label id="pp">Description:</label><asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"></asp:TextBox></div>
        <div><label id="pp">Start Date:</label><asp:TextBox ID="dateStart" runat="server" TextMode="Date"></asp:TextBox></div>
        <div><label id="pp">End Date:</label><asp:TextBox ID="dateEnd" runat="server" TextMode="Date"></asp:TextBox></div>
        <div><label id="pp">Status:</label><asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True"></asp:DropDownList></div>
        <div><label id="pp">Project Manager:</label><asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True"></asp:DropDownList></div>
        <div><label id="pp">Client:</label><asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True"></asp:DropDownList></div>
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SUBMIT" />
        <asp:Button ID="btnReset" runat="server" Text="RESET" OnClick="btnReset_Click" />
        <asp:Label ID="lblError" runat="server"></asp:Label>
    </form>
</body>
</html>