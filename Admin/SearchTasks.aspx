<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="SearchTasks.aspx.cs" Inherits="WorkNest.Admin.SearchTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Project-Wise Task Reports</h2>

    <asp:DropDownList ID="ddlProjects" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged">
    </asp:DropDownList>

    <asp:GridView ID="gvTaskReports" runat="server" AutoGenerateColumns="false" CssClass="table">
        <columns>
            <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
            <asp:BoundField DataField="TASK_DESC" HeaderText="Task Description" />
            <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:dd-MMM-yyyy}" />
            <asp:BoundField DataField="DUE_DATE" HeaderText="Due Date" DataFormatString="{0:dd-MMM-yyyy}" />
            <asp:BoundField DataField="STATUS" HeaderText="Status" />
            <asp:BoundField DataField="ASSIGNED_TO" HeaderText="Assigned To" />

            <asp:BoundField DataField="LAST_UPDATE" HeaderText="Last Updated" DataFormatString="{0:dd-MMM-yyyy}" />
            <asp:TemplateField HeaderText="Details">
                <itemtemplate>
                    <asp:HyperLink ID="lnkTaskDetails" runat="server"
                        NavigateUrl='<%# "TaskDetails.aspx?TaskID=" + Eval("TASK_ID") %>'
                        Text="View Details">
                    </asp:HyperLink>
                </itemtemplate>
            </asp:TemplateField>
        </columns>
    </asp:GridView>

</asp:Content>
