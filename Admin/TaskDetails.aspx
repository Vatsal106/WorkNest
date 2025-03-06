<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminM.Master" AutoEventWireup="true" CodeBehind="TaskDetails.aspx.cs" Inherits="WorkNest.Admin.TaskDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header_Title" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="gvTaskReportHistory" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered">
        <Columns>
            <asp:BoundField DataField="UPDATED_AT" HeaderText="Updated At" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" />
            <asp:TemplateField HeaderText="Task History Report">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkDownloadHistory" runat="server"
                        NavigateUrl='<%# Eval("TaskHistoryURL") %>'
                        Text="Download" Visible='<%# Eval("TaskHistoryURL") != null && Eval("TaskHistoryURL").ToString() != "" %>'>
                    </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
