<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctrlCashRewardRecipient.ascx.cs" Inherits="USoft.Controls.ctrlCashRewardRecipient" %>
<table>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label1" runat="server" Text="Recipient Name"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px" class="form_table">
            <asp:Label ID="lblRecipientName" runat="server" BorderColor="#4297D7" BorderStyle="Solid"
                BorderWidth="1px" Width="269px"></asp:Label></td>
        <td class="form_table" style="width: 37px">
            <asp:ImageButton ID="imgAdd" runat="server" ImageUrl="~/Images/BtnAdd.png" OnClick="imgAdd_Click"
                /></td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label2" runat="server" Text="Position"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblPosition" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label3" runat="server" Text="Bank Name"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblBankName" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label4" runat="server" Text="Bank Location"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblBankLocation" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label5" runat="server" Text="Account Name"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblAccountName" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label6" runat="server" Text="Account Number" Width="107px"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblAccountNumber" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label7" runat="server" Text="NPWP" Width="107px"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblNPWP" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label8" runat="server" Text="Tax Procentage" Width="107px"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblTaxProcentage" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label9" runat="server" Text="Amount" Width="107px"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:TextBox ID="txtAmount" runat="server" CssClass="T28" Width="175px" Wrap="False"></asp:TextBox></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label10" runat="server" Text="Tax Amount" Width="107px"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblTaxAmount" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td style="width: 100px" class="form_table_title">
            <asp:Label ID="Label11" runat="server" Text="Net Amount" Width="107px"></asp:Label></td>
        <td class="form_table_sepp">
            :</td>
        <td style="width: 100px"class="form_table">
            <asp:Label ID="lblNetAmount" runat="server"></asp:Label></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
    <tr>
        <td class="form_table_title" style="width: 100px">
        </td>
        <td class="form_table_sepp">
        </td>
        <td class="form_table" style="width: 100px">
            <asp:ImageButton ID="imgSave" runat="server" ImageUrl="~/Images/BtnSave.png" OnClick="imgSave_Click" /></td>
        <td class="form_table" style="width: 37px">
        </td>
    </tr>
</table>
