<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pembiayaankonsumen.aspx.cs" Inherits="USoft.Modules.Accounting.Bapepam.Pembiayaankonsumen" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Pembiayaan Konsumen</title>
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jqwidgets/jqx-all.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#jqxButton").jqxButton({ width: '150'});
            var type = $("#ddlReportType").val();
            function buildQueryString(data) {
                var str = '';
                for (var prop in data) {
                    if (data.hasOwnProperty(prop)) {
                        str += prop + '=' + data[prop] + '&';
                    }
                }
                return str.substr(0, str.length - 1);
            }
            var formatedData = '';
            var totalrecords = 0;
            var source = {
                datatype: "json",
                datafields: [       {name:'RowNumber'},
                                    {name:'bulan'},
                                    {name:'golongan_debitur'},
                                    {name:'hubungan_dengan_perusahaan'},
                                    {name:'jumlah_kontrak'},
                                    {name:'kualitas'},
                                    {name:'Lokasi_Proyek'},
                                    {name:'customer_name'},
                                    {name:'finance_amount'},
                                    {name:'nilaiJaminanBarang'},
                                    {name:'TotalAr'},
                                    {name:'sektorEkonomi'},
                                    {name:'dueDate'},
                                    {name:'tingkatBunga'},
                                    {name:'SumTotalAR'}],
                sort: function () {
                    $("#jqxgrid").jqxGrid('updatebounddata', 'sort');
                },
                filter: function () {
                    $("#jqxgrid").jqxGrid('updatebounddata', 'filter');
                },
                beforeprocessing: function (data) {
                    var returnData = {};
                    totalrecords = data.count;
                    returnData.totalrecords = data.count;
                    returnData.records = data.data;
                    return returnData;
                },
                type: 'GET',
                sortcolumn: 'CompanyName',
                sortdirection: 'asc',
                formatdata: function (data) {
                    data.sortdatafield = data.sortdatafield || 'contract_number';
                    data.sortorder = data.sortorder || 'asc';
                    data.filterscount = data.filterscount || 0;
                    formatedData = buildQueryString(data);
                    return formatedData;
                },
                url: 'PembiayaanKonsumenServ.asmx/Show?FormType='+type
            };

            var dataAdapter = new $.jqx.dataAdapter(source, {
                contentType: 'application/json; charset=utf-8',
                loadError: function (xhr, status, error) {
                    alert(error);
                }
            });
            $("#jqxgrid").jqxGrid({
                source: dataAdapter,
                virtualmode: true,
                width:'100%',
                showstatusbar: true,
                statusbarheight: 20,
                filterable: true,
                showaggregates: true,
                columnsresize: true,
                rendergridrows: function (args) {
                    return args.data;
                },
                columns:[{text: 'No.',dataField: 'RowNumber',width: 30},
                         {text: 'bulan',dataField: 'bulan',width: 50},
                         {text: 'Gol',dataField: 'golongan_debitur',width: 50},
                         {text: 'Hubungan',dataField: 'hubungan_dengan_perusahaan',width: 50},
                         {text: 'Jumlah',dataField: 'jumlah_kontrak',width: 50},
                         {text: 'Qty',dataField: 'kualitas',width: 50},
                         {text: 'Lokasi Klien',dataField: 'Lokasi_Proyek',width: 100},
                         {text: 'Nama Debitur',dataField: 'customer_name',width: 200},
                         {text: 'Nilai Awal',dataField: 'finance_amount',cellsalign: 'right', cellsformat: 'n2',width: 125},
                         {text: 'Nilai Jaminan',cellsalign: 'right', cellsformat: 'n2',dataField: 'nilaiJaminanBarang',width: 125},
                         { text: 'Saldo Brutto', datafield: 'TotalAr', cellsalign: 'right', cellsformat: 'n2', aggregates: [{ '<b>Total</b>':
                                    function (aggregatedValue, currentValue, column, record) {
                                        return parseInt(record['SumTotalAR']);
                                    }
                              }]                  
                          ,width: 125},
                         {text: 'Sek. Ekonomi',dataField: 'sektorEkonomi',width: 100},
                         {text: 'Due Date',dataField: 'dueDate',width: 100},
                         {text: 'Tingkat Bunga',dataField: 'tingkatBunga',width: 100}]
            });
            $("#ddlReportType").change(function(){
                type = $("#ddlReportType").val();
                source.url= 'PembiayaanKonsumenServ.asmx/Show?FormType='+type
                $("#jqxgrid").jqxGrid({ source: dataAdapter });
            })
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
    </div>
        <table style="width: 100%">
            <tr>
                <td style="width: 100%">
                    <uc1:ctrlFormHeader ID="CtrlFormHeader" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label1" runat="server" Text="Report Type" Width="92px"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlReportType" runat="server" Width="133px">
                                    <asp:ListItem Value="11">Sewa Guna Usaha</asp:ListItem>
                                    <asp:ListItem Value="40">Konsumen</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <div id="jqxgrid"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button id='jqxButton' runat="server" OnClick="btnConvert_Click" Text="Convert" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
