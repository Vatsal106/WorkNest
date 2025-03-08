<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="AllTasks.aspx.cs" Inherits="WorkNest.Admin.AllTasks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:Repeater ID="rptProjects" runat="server" OnItemDataBound="rptProjects_ItemDataBound">
        <ItemTemplate>
            <h2 style="color: #4A6D85;"><%# Eval("PROJECT_NAME") %></h2>
            <asp:GridView ID="gvTaskReports" runat="server" AutoGenerateColumns="false" CssClass="table">
                <Columns>
                    <asp:BoundField DataField="TASK_NAME" HeaderText="Task Name" />
                    <asp:BoundField DataField="TASK_DESC" HeaderText="Task Description" />
                    <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:dd-MMM-yyyy}" />
                    <asp:BoundField DataField="DUE_DATE" HeaderText="Due Date" DataFormatString="{0:dd-MMM-yyyy}" />
                    <asp:BoundField DataField="STATUS" HeaderText="Status" />
                    <asp:BoundField DataField="ASSIGNED_TO" HeaderText="Assigned To" />
                    <asp:BoundField DataField="LAST_UPDATE" HeaderText="Last Updated" DataFormatString="{0:dd-MMM-yyyy}" />
                    <asp:TemplateField HeaderText="Details">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkTaskDetails" runat="server"
                                NavigateUrl='<%# "TaskDetails.aspx?TaskID=" + Eval("TASK_ID") %>'
                                Text="View Details">
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
