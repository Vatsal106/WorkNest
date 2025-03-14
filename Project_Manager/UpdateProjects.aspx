<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="UpdateProjects.aspx.cs" Inherits="WorkNest.Project_Manager.UpdateProjects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <script>
    function ValidateProject() {
        let isValid = true;
        let errorMessage = "";
        let projectName = document.getElementById("<%= txtProjectName.ClientID %>").value.trim();
        let description = document.getElementById("<%= txtDescription.ClientID %>").value.trim();
        let startDate = document.getElementById("<%= txtStartDate.ClientID %>").value;
        let endDate = document.getElementById("<%= txtEndDate.ClientID %>").value;
        let status = document.getElementById("<%= ddlStatus.ClientID %>").value;
        let projectManager = document.getElementById("<%= ddlProjectManager.ClientID %>").value;
        let client = document.getElementById("<%= ddlClient.ClientID %>").value;
        console.log("Project Name:", projectName);
        
        if (projectName === "") errorMessage += "⚠ Project Name is required.\n";
        if (description === "") errorMessage += "⚠ Description is required.\n";
        if (startDate === "") errorMessage += "⚠ Start Date is required.\n";
        if (endDate === "") errorMessage += "⚠ End Date is required.\n";
        if (startDate !== "" && endDate !== "") {
            let start = new Date(startDate);
            let end = new Date(endDate);
            if (start >= end) errorMessage += "⚠ End Date must be after Start Date.\n";
        }

        
        if (existingStartDate !== "" && new Date(startDate) < new Date(existingStartDate)) {
            errorMessage += "⚠ Start Date cannot be set before the existing Start Date.\n";
        }

        if (status === "") errorMessage += "⚠ Please select a project status.\n";
        if (projectManager == "0") errorMessage += "⚠ Please select a Project Manager.\n";
        if (client == "0") errorMessage += "⚠ Please select a Client.\n";

        
        let errorLabel = document.getElementById("<%= lblError.ClientID %>");
        if (errorMessage !== "") {
            errorLabel.innerText = errorMessage;
            errorLabel.style.color = "red";
            return false;
        } else {
            errorLabel.innerText = ""; 
            return true;
        }
    }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
      Update Project
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
      <h2>Update Project</h2>

  <asp:HiddenField ID="hfProjectID" runat="server" />

  <label>Project Name:</label>
  <asp:TextBox ID="txtProjectName" runat="server" CssClass="form-control" />

  <label>Description:</label>
  <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" />

  <label>Start Date:</label>
  <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date" />

  <label>End Date:</label>
  <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date" />

  <label>Status:</label>
  <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
      <asp:ListItem Text="HOLD" Value="ON HOLD"></asp:ListItem>
      <asp:ListItem Text="IN PROGRESS" Value="IN PROGRESS"></asp:ListItem>
      <asp:ListItem Text="IN TESTING" Value="IN TESTING"></asp:ListItem>
      <asp:ListItem Text="COMPLETED" Value="COMPLETED"></asp:ListItem>
  </asp:DropDownList>

  <label>Project Manager:</label>
  <asp:DropDownList ID="ddlProjectManager" runat="server" CssClass="form-control"></asp:DropDownList>

  <label>Client:</label>
  <asp:DropDownList ID="ddlClient" runat="server" CssClass="form-control"></asp:DropDownList>

  <br />
  <asp:Label ID="lblError" Text="" runat="server" />
  <asp:Button ID="btnUpdateProject" runat="server"
      Text="Update" CssClass="btn btn-success"
      OnClick="ValidateProject" />
  <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
</asp:Content>
