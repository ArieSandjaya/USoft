<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashReward_Dealer.aspx.cs" Inherits="USoft.Modules.Marketing.Master.CashReward_Dealer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctrlArea.ascx" TagName="ctrlArea" TagPrefix="uc2" %>
<%@ Register Src="~/Controls/ctrlTenor.ascx" TagName="ctrlTenor" TagPrefix="uc3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cash Reward Dealer</title>
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.css" />
    <link rel="stylesheet" type="text/css" href="../../../CSS/black-tie/ui-layout.css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.blockUI.js"></script>
    <script type="text/javascript">
    function loadWait()
        {
            //window.parent.parent.loadWait();
            $.blockUI({message: '<img src="../../../CSS/black-tie/images/loading6.gif" />'});
        }         
    </script>
    <style type="text/css">     
        .hide {   display:none;  } 
        .show {   display:true;  }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <table style="width: 100%">
                <tr>
                    <td class="ui-widget-content">
                        <uc1:ctrlFormHeader ID="ucHeaderPage" runat="server" /></td></tr>
                <tr>
                    <td class="ui-widget-content">
                        <table style="width: 98%">
                            <tr>
                                <td class="T19">
                                    <asp:Label ID="Label10" runat="server" Text="Dealer Name : " Width="106px"></asp:Label></td>
                                <td class="T19">
                                    <asp:TextBox ID="TxtSearchDealer" runat="server" CssClass="watermarkOn" Width="550px" Font-Size="10pt"></asp:TextBox></td>
                                </tr>
                            <tr>
                                <td class="T19">
                                    <asp:Label ID="Label1" runat="server" Text="Brand Name : " Width="106px"></asp:Label></td>
                                <td class="T19">
                                    <asp:DropDownList ID="ddlBrand" runat="server" Width="148px">
                                        </asp:DropDownList></td>
                                </tr>
                            <tr>
                                <td class="T19">
                                    <asp:Label ID="Label2" runat="server" Text="Area : " Width="106px"></asp:Label></td>
                                <td class="T19">
                                    <uc2:ctrlArea ID="CtrlArea3" runat="server" />
                                </td>
                                </tr>
                            <tr>
                                <td class="T19"></td>
                                <td class="T19"></td>
                                </tr>
                            <tr>
                                <td class="T19">
                                    </td>
                                <td class="T19">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="ui-button ui-state-default" Text="Search" OnClick="btnSearch_Click" OnClientClick="loadWait()" />&nbsp;<br />
                                    <asp:Button ID="BtnAddNew" runat="server" CssClass="ui-button ui-state-default" Text="AddNew" OnClick="BtnAddNew_Click"  /></td>
                                </tr>
                        </table>
                    </td></tr>
                <tr class="T19">
                    <td class="ui-widget-content">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="gvDealer" runat="server" AutoGenerateColumns="False" 
                                    ShowFooter="True" Style="width: 100%" Font-Size="8pt" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvDealer_PageIndexChanging" OnRowCommand="gvDealer_RowCommand" OnRowEditing="gvDealer_RowEditing" OnRowDeleting="gvDealer_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID">
                                            <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                        <asp:BoundField DataField="BRAND_CODE" HeaderText="BRAND CODE" />
                                        <asp:BoundField DataField="BRAND_NAME" HeaderText="BRAND NAME" HtmlEncode="False" />
                                        <asp:BoundField DataField="AREA" HeaderText="AREA" />
                                        <asp:BoundField DataField="DEALER_CODE" HeaderText="DEALER CODE" />
                                        <asp:BoundField DataField="DEALER_NAME" HeaderText="DEALER NAME" />
                                        <asp:BoundField DataField="AMOUNT" HeaderText="AMOUNT" />
                                        <asp:BoundField DataField="USE_AREA" HeaderText="USE AREA" />
                                        <asp:BoundField DataField="UPDATE_BY" HeaderText="UPDATE BY">
                                            <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                        <asp:BoundField DataField="UPDATE_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="UPDATE DATE">
                                            <ControlStyle CssClass="hide" /><FooterStyle CssClass="hide" /><HeaderStyle CssClass="hide" /><ItemStyle CssClass="hide" />
                                            </asp:BoundField>
                                        <asp:BoundField DataField="ACTIVE" HeaderText="ACTIVE" />
                                        
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                    </Columns>
                                    <FooterStyle CssClass="ui-widget-header" />
                                    <HeaderStyle CssClass="ui-widget-header" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
           
                <cc1:modalpopupextender id="MpeAddDealer" runat="server" backgroundcssclass="ui-widget-shadow"
                            popupcontrolid="PanelAdd" targetcontrolid="BtnAddNew"></cc1:modalpopupextender>
                        <asp:Panel ID="PanelAdd" runat="server" BackColor="White" CssClass="show" Height="335px"
                            Style="border-right: black thin solid; padding-right: 0px; border-top: black thin solid;
                            display: none; padding-left: 0px; padding-bottom: 0px; margin: 0px; border-left: black thin solid;
                            padding-top: 0px; border-bottom: black thin solid" Width="434px" Wrap="False">
                            <asp:UpdatePanel ID="UpdatePanelAdd" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="width: 99%">
                                        <tr>
                                            <td class="ui-widget-header" colspan="2" style="height: 22px">Add Dealer</td>
                                            <td class="ui-widget-header" style="height: 14px; width: 16px;">
                                                <asp:ImageButton ID="ImageButton_Close" runat="server" ImageUrl="~/CSS/login/images/close.gif" OnClick="ImageButton_Close_Click" /></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Brand Code</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:TextBox ID="TxtBrandCode" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Brand Name</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:DropDownList ID="ddlAddBrand" runat="server" Width="148px">
                                                    </asp:DropDownList></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Area</td>
                                            <td style="width: 276px; height: 26px">
                                                <uc2:ctrlArea ID="CtrlArea" runat="server" />
                                            </td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Dealer Code</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:TextBox ID="TxtDealerCode" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Dealer Name</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:TextBox ID="TxtDealerName" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px">Amount</td>
                                            <td style="width: 276px">
                                                <asp:TextBox ID="TxtAmount" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td></td></tr>
                                        <tr>
                                            <td style="width: 113px">Use Area</td>
                                            <td style="width: 276px">
                                                <asp:CheckBox ID="chkUseArea" runat="server" /></td>
                                            <td></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 24px"></td>
                                            <td style="width: 276px; height: 24px">
                                                <asp:Button ID="btnCreate" runat="server" CssClass="ui-button ui-state-default" Text="Create" OnClick="btnCreate_Click" /></td>
                                            <td style="height: 24px"></td></tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        
                       
                        <cc1:modalpopupextender id="MpeEditDealer" runat="server" backgroundcssclass="ui-widget-shadow"
                                enabled="True" popupcontrolid="PanelEdit" targetcontrolid="Label10"></cc1:modalpopupextender>
                        <asp:Panel ID="PanelEdit" runat="server" BackColor="White" CssClass="show" Height="352px"
                            Style="border-right: black thin solid; padding-right: 0px; border-top: black thin solid;
                            display: none; padding-left: 0px; padding-bottom: 0px; margin: 0px; border-left: black thin solid;
                            padding-top: 0px; border-bottom: black thin solid" Width="437px" Wrap="False">
                            <asp:UpdatePanel ID="UpdatePanelEdit" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="width: 99%">
                                        <tr>
                                            <td class="ui-widget-header" colspan="2" style="height: 19px">Edit Dealer</td>
                                            <td class="ui-widget-header" style="width: 16px; height: 14px">
                                                <asp:ImageButton ID="ImgBtnEdit_Close" runat="server" Height="14px" ImageUrl="~/CSS/login/images/close.gif" Width="16px" OnClick="ImgBtnEdit_Close_Click" /></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Brand Code</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:TextBox ID="TxtEditBrandCode" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Brand Name</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:DropDownList ID="ddlEditBrandName" runat="server" Width="148px">
                                                    </asp:DropDownList></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Area</td>
                                            <td style="width: 276px; height: 26px">
                                                <uc2:ctrlArea ID="CtrlArea1" runat="server"  />
                                            </td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Dealer Code</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:TextBox ID="TxtEditDealerCode" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 26px">Dealer Name</td>
                                            <td style="width: 276px; height: 26px">
                                                <asp:TextBox ID="TxtEditDealerName" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td style="height: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px">Amount</td>
                                            <td style="width: 276px">
                                                <asp:TextBox ID="TxtEditAmount" runat="server" Width="242px" Font-Size="8pt"></asp:TextBox></td>
                                            <td></td></tr>
                                        <tr>
                                            <td style="width: 113px">Use Area</td>
                                            <td style="width: 276px">
                                                <asp:CheckBox ID="chkEditUseArea" runat="server" /></td>
                                            <td></td></tr>    
                                        <tr>
                                            <td style="width: 113px">Active</td>
                                            <td style="width: 229px">
                                                <asp:DropDownList ID="ddlEditActive" runat="server" Width="84px" Font-Size="8pt">
                                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                                    <asp:ListItem Value="N">No</asp:ListItem>
                                                </asp:DropDownList>
                                                </td>
                                            <td style="width: 26px"></td></tr>
                                        <tr>
                                            <td style="width: 113px; height: 7px"></td>
                                            <td style="width: 229px; height: 7px">
                                                <asp:Button ID="BtnSave" runat="server" CssClass="ui-button ui-state-default" Height="33px" Text="Save" Width="50px" OnClick="BtnSave_Click"  /></td>
                                            <td style="width: 26px; height: 7px"></td></tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
            
                         
                            <cc1:modalpopupextender id="MpeDeleteDealer" runat="server" backgroundcssclass="ui-widget-shadow"
                                 enabled="True" popupcontrolid="PanelDelete" TargetControlID="Button1" ></cc1:modalpopupextender>
                            <asp:Panel ID="PanelDelete" runat="server" BackColor="White" CssClass="show" Height="352px"
                                Style="border-right: black thin solid; padding-right: 0px; border-top: black thin solid;
                                display: none; padding-left: 0px; padding-bottom: 0px; margin: 0px; border-left: black thin solid;
                                padding-top: 0px; border-bottom: black thin solid" Width="437px" Wrap="False">
                                <asp:UpdatePanel ID="UpdatePanelDelete" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <table style="width: 99%">
                                            <tr>
                                                <td class="ui-widget-header" colspan="2" style="height: 19px">Delete Dealer</td>
                                                <td class="ui-widget-header" style="width: 16px; height: 14px">
                                                    <asp:ImageButton ID="imgBtnDel_Close" runat="server" Height="14px" ImageUrl="~/CSS/login/images/close.gif" Width="16px" OnClick="imgBtnDel_Close_Click" /></td></tr>
                                            <tr>
                                                <td style="width: 113px; height: 26px">Brand Code</td>
                                                <td style="width: 276px; height: 26px">
                                                    <asp:TextBox ID="TxtDeleteBrandCode" runat="server" Width="242px" Font-Size="8pt" Enabled="False"></asp:TextBox></td>
                                                <td style="height: 26px"></td></tr>
                                            <tr>
                                                <td style="width: 113px; height: 26px">Brand Name</td>
                                                <td style="width: 276px; height: 26px">
                                                    <asp:DropDownList ID="ddlDeleteBrandName" Enabled="false" runat="server" Width="148px">
                                                        </asp:DropDownList></td>
                                                <td style="height: 26px"></td></tr>
                                            <tr>
                                                <td style="width: 113px; height: 26px">Area</td>
                                                <td style="width: 276px; height: 26px">
                                                    <uc2:ctrlArea ID="CtrlArea2" runat="server" />
                                                </td>
                                                <td style="height: 26px"></td></tr>
                                            <tr>
                                                <td style="width: 113px; height: 26px">Dealer Code</td>
                                                <td style="width: 276px; height: 26px">
                                                    <asp:TextBox ID="TxtDeleteDealerCode" runat="server" Width="242px" Font-Size="8pt" Enabled="False"></asp:TextBox></td>
                                                <td style="height: 26px"></td></tr>
                                            <tr>
                                                <td style="width: 113px; height: 26px">Dealer Name</td>
                                                <td style="width: 276px; height: 26px">
                                                    <asp:TextBox ID="TxtDeleteDealerName" runat="server" Width="242px" Font-Size="8pt" Enabled="False"></asp:TextBox></td>
                                                <td style="height: 26px"></td></tr>
                                            <tr>
                                                <td style="width: 113px">Amount</td>
                                                <td style="width: 276px">
                                                    <asp:TextBox ID="TxtDeleteAmount" runat="server" Width="242px" Font-Size="8pt" Enabled="False"></asp:TextBox></td>
                                                <td></td></tr>
                                            <tr>
                                                <td style="width: 113px">Use Area</td>
                                                <td style="width: 276px">
                                                    <asp:CheckBox ID="chkDeleteUseArea" runat="server" Enabled="false" /></td>
                                                <td></td></tr>    
                                            <tr>
                                                <td style="width: 113px">Active</td>
                                                <td style="width: 229px">
                                                    <asp:DropDownList ID="ddlDeleteActive" runat="server" Width="84px" Font-Size="8pt" Enabled="False">
                                                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                                                        <asp:ListItem Value="N">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                    </td>
                                                <td style="width: 26px"></td></tr>
                                            <tr>
                                                <td style="width: 113px"></td>
                                                <td style="width: 229px" align="right">
                                                    * Are you sure to delete this data ?<br />
                                                    Click (X) button to cancel
                                                    <br />
                                                    <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="ui-button ui-state-default" OnClick="BtnDelete_Click" OnClientClick="loadWait()" /></td>
                                                <td style="width: 26px"></td></tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
            <asp:Button ID="Button1" runat="server" Text="Button" CssClass="hide" />
                            
                        
            
        </div>
    </form>
</body>
</html>

