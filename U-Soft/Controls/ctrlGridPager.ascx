<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlGridPager.ascx.cs" Inherits="USoft.Controls.ctrlGridPager" %>
<table class="tblPager">
    <tr>
        <td class="tdPagerNav" id="tdPagerNav" runat="server">
            <asp:ImageButton ID="imbFirst" runat="server" ImageUrl="~/Images/BtnPageFirst.png" ToolTip="First" OnClick="imbFirst_Click" />
            <asp:ImageButton ID="imbPrev" runat="server" ImageUrl="~/Images/BtnPagePrev.png" ToolTip="Previous" OnClick="imbPrev_Click" />
            <asp:ImageButton ID="imbNext" runat="server" ImageUrl="~/Images/BtnPageNext.png" ToolTip="Next" OnClick="imbNext_Click" />
            <asp:ImageButton ID="imbLast" runat="server" ImageUrl="~/Images/BtnPageLast.png" ToolTip="Last" OnClick="imbLast_Click" />
            <asp:Label ID="lblPageGo" runat="server" Text=" - Page " CssClass="spanPagerGo"></asp:Label>
            <asp:TextBox ID="txtPageGo" runat="server" Width="50"></asp:TextBox>
            <asp:ImageButton ID="imbGo" runat="server" ImageUrl="~/Images/BtnPageGo.png" ToolTip="Go to Page" OnClick="imbGo_Click" />
        </td>
        <td class="tdPagerInfo">
            Page <asp:Label ID="lblCurrPage" runat="server" Text="1"></asp:Label>
            of <asp:Label ID="lblTotalPage" runat="server" Text="0"></asp:Label> - 
            Total Data <asp:Label ID="lblTotalData" runat="server" Text="0"></asp:Label>
        </td>
    </tr>
</table>