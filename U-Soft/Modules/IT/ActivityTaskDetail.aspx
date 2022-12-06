<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActivityTaskDetail.aspx.cs" Inherits="USoft.Modules.IT.ActivityTaskDetail" %>

<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Activity Task Add Edit</title>
    <link href="../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/ui-layout.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/black-tie/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../../Javascript/date.js"></script>
    <script type="text/javascript" src="../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript" src="../../Javascript/NumberFormat.js"></script>
    <script type="text/javascript" src="../../Javascript/general.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="pnlDataPage" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="width: 100%">
                    <tr>
                        <td class="ui-widget-content">
                            <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" />
                        </td>
                    </tr>
                    <tr><td><asp:Label ID="lblMessage" runat="server" CssClass="InfoWarn"></asp:Label></td></tr>
                    <tr>
                        <td class="ui-widget-content">
                            <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td class="form_table_title" style="width: 120px;">Activity No</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label id="lblActivityNo" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Date</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblActivityDate" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Request By</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblRequestBy" runat="server"></asp:Label></td>
                                </tr>
                                <%--<tr>
                                    <td class="form_table_title">Email</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblEmail" runat="server"></asp:Label></td>
                                </tr>--%>
                                <tr>
                                    <td class="form_table_title">Branch</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblBranchName" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Departement</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblDepartementName" runat="server"></asp:Label></td>
                                </tr>  
                                <tr>
                                    <td class="form_table_title">Problem Type</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblProblemTypeName" runat="server"></asp:Label></td>
                                </tr>                      
                                <tr>
                                    <td class="form_table_title">Item Type</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblItemTypeName" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Description</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblDescription" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Priority</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblPriority" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="form_table_title">Status</td>
                                    <td class="form_table_sepp">:</td>
                                    <td class="form_table"><asp:Label ID="lblStatus" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td class="form_table_btn">
                                        <asp:ImageButton ID="imbEditHeader" runat="server" ImageUrl="~/Images/BtnEditHeader.png" OnClick="imbEditHeader_Click" />
                                        <asp:ImageButton ID="imbReOpen" runat="server" ImageUrl="~/Images/BtnReOpen.png" OnClick="imbReOpen_Click" />
                                        <asp:ImageButton ID="imbVerify" runat="server" ImageUrl="~/Images/BtnVerify.png" OnClick="imbVerify_Click" />
                                        <asp:ImageButton ID="imbBack" runat="server" ImageUrl="~/Images/BtnBack.png" OnClick="imbBack_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="trFormAssign" runat="server">
                        <td class="ui-widget-content">
                            <asp:UpdatePanel ID="pnlDataForm" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="width: 100%" cellspacing="1" cellpadding="1" border="0">
                                        <tr>
                                            <td colspan="3">
                                                <uc1:ctrlFormHeader ID="ucHeaderForm" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="form_table_title" style="width: 120px;">Action <span class="reqMark">*</span></td>
                                            <td class="form_table_sepp">:</td>
                                            <td class="form_table">
                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="validate[required]" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="trAssignTo" runat="server">
                                            <td class="form_table_title">PIC <span class="reqMark">*</span></td>
                                            <td class="form_table_sepp">:</td>
                                            <td class="form_table">
                                                <asp:DropDownList ID="ddlAssignTo" runat="server" CssClass="validate[required]"></asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="trDescription" runat="server">
                                            <td class="form_table_title">Description <span class="reqMark">*</span></td>
                                            <td class="form_table_sepp">:</td>
                                            <td class="form_table"><asp:TextBox ID="txtAssignDesc" runat="server" rows="5" TextMode="multiline" CssClass="validate[required]"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 27px">&nbsp;</td>
                                            <td class="form_table_btn" style="height: 27px">
                                                <asp:ImageButton ID="imbProcess" runat="server" ImageUrl="~/Images/BtnProcess.png" OnClientClick="javascript:return ValidatePage();" OnClick="imbProcess_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlStatus" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="ui-widget-content">
                            <uc1:ctrlFormHeader ID="ucHeaderGrid" runat="server" />
                            <asp:UpdatePanel ID="pnlDataTable" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView ID="gvAssignTask" runat="server" AutoGenerateColumns="False"
                                         Font-Size="8pt" Style="width: 100%" EmptyDataText="No Data Available" OnRowDataBound="gvAssignTask_RowDataBound">
                                        <Columns>
                                            <asp:BoundField DataField="DATEASSIGN" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="DATE">
                                                <ItemStyle HorizontalAlign="Center" Width="130px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="STATUSACTIVITY" HeaderText="STATUS">
                                                <ItemStyle Width="200px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DESCRIPTION" HeaderText="DESCRIPTION" />
                                        </Columns>
                                        <HeaderStyle CssClass="ui-widget-header" />
                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table> 
            </ContentTemplate>
        </asp:UpdatePanel>            
    </div>                      
    </form>
</body>
</html>