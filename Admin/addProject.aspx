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
    align-items: center
    margin: 0;
}

form {
    background-color:#0A0A32;
    padding: 20px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    width: 35%;
    height:1000px;
   
}

form div {
    display: flex;
    flex-direction: column;
}
 #pp{
        font-weight: bold;
        margin-bottom: 5px;
        font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        color:white;
                
        }


#txtProjectName,#txtDesc,#dateStart,#dateEnd,#ddlStatus,#ddlProjectManager,#ddlClient{
    padding:12px;
    margin:9px;
    border-radius:10px;
}

#btnSubmit {
    background-color: skyblue;
    color: black;
    padding: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: 0.3s;
    margin: 10px;
    width:95%;
    border-radius:10px;
    
}

#btnReset{
 background-color: skyblue;
color: black;
padding: 10px;
display: flex;
justify-content: center;
align-items: center;
transition: 0.3s;
margin:10px;
width: 95%;
border-radius:10px;

}

#btnSubmit:hover{
    background-color:white;
    cursor:pointer;
    color:skyblue;
}


#btnReset:hover{
    background-color:white;
    cursor:pointer;
    color:skyblue;
}



#lblError {
    color: red;
    font-weight: bold;
    margin-top: 10px;
}


#im{
    height:1040px;
    width:35%;
    
}



    </style>
   

</head>
<body>
    
  <img id="im" src="../images/Project Add image.png" alt="Alternate Text"/>
    
    <form id="addProject" runat="server">
        <div class="abc">

           <label id="pp">Project Name :</label> 
            <asp:TextBox ID="txtProjectName" runat="server"></asp:TextBox>
            <br />
            <br />
           <lable id="pp"> Description :</lable>
            <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <br />
            <lable id="pp">Start Date :</lable>
            <asp:TextBox ID="dateStart" runat="server" TextMode="Date"></asp:TextBox>
&nbsp;<br />
            <br />
           <lable id="pp"> End Date:</lable> 
               <asp:TextBox ID="dateEnd" runat="server" TextMode="Date"></asp:TextBox>
            <br />
            <br />
            <lable id="pp">Status :</lable>
            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <br />
            <lable id="pp">Project Manager :</lable>
            <asp:DropDownList ID="ddlProjectManager" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <br />
            <lable id="pp">Client :</lable>
            <asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="SUBMIT" />
            <asp:Button ID="btnReset" runat="server" Text="RESET" OnClick="btnReset_Click" />
            <br>
            <br>
            <asp:Label ID="lblError" class="btn" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
