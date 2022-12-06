<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CityMap.aspx.cs" Inherits="USoft.Modules.Accounting.Master.CityMap" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>City Mapping Page</title>
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jqwidgets/jqx-all.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#jqxButton").jqxButton({ width: '150'});
                var ddlSource =
                {
                    datatype: "json",
                    type: 'GET',
                    datafields: [
                        { name: 'City_Code' },
                        { name: 'City_Desc' }],
                    url: 'CityMap.aspx/GetMappingCode',
                    async: false
                };
			var ddlDataAdapter = new $.jqx.dataAdapter(ddlSource, {contentType: 'application/json; charset=utf-8',
                loadError: function (xhr, status, error) {
                debugger;
                    alert(error);
                }
            });	
            $("#map_city").jqxDropDownList({
                    selectedIndex: 0, source: ddlDataAdapter, displayMember: "City_Desc", valueMember: "City_Code", width: 200, height: 25
                });

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
                datafields: [       {name:'city_code'},
                                    {name:'city_name'},
                                    {name:'map_code'},
                                    {name:'map_city'}],
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
                url: 'CityMap.aspx/Show'
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
                return args.data;},
                columns:[{text: 'City Code',dataField: 'city_code',width: 75},
                         {text: 'City Name',dataField: 'city_name',width: 450},
                         {text: 'Map Code',dataField: 'map_code',width: 75},
                         {text: 'Map City',dataField: 'map_city',width: 450},
                         {text: 'Edit', datafield: 'Edit', columntype: 'button', cellsrenderer: function () {
                                 return "Edit";
                             }, buttonclick: function (row) {
                                 editrow = row;
                                 var offset = $("#jqxgrid").offset();
                                 $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 300, y: parseInt(offset.top) + 10 } });
                                 var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
                                 $("#city_code").val(dataRecord.city_code);
                                 $("#city_name").val(dataRecord.city_name);
                                 $("#map_code").val(dataRecord.map_code);
                                 $("#map_city").val(dataRecord.map_city);
                                 $("#map_city_desc").val(dataRecord.map_city);
                                 $("#popupWindow").jqxWindow('open');
                             }}]
                });
                   $("#popupWindow").jqxWindow({
                        width: 400, resizable: false, isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01           
                    });
                    $("#popupWindow").on('open', function () {
                        $("#firstName").jqxInput('selectAll');
                    });
                    $("#Cancel").jqxButton({ });
                    $("#Save").jqxButton({  });

                    $("#Save").click(function () {
                        if (editrow >= 0) {
                            var row = { city_code: $("#city_code").val(), city_name: $("#city_name").val(), map_code: $("#map_code").val(),map_city: ($("#map_city_desc").val())};
                            var rowID = $('#jqxgrid').jqxGrid('getrowid', editrow);
                            $('#jqxgrid').jqxGrid('updaterow', rowID, row);
                            $("#popupWindow").jqxWindow('hide');
                                        $.ajax({
                                                 type: "POST",
                                                 url: "CityMap.aspx/SaveMapping",
                                                 data: "{'CityCode':'"+$("#city_code").val()+"', 'MapCode':'"+$("#map_code").val()+"', 'MapCity':'"+$("#map_city_desc").val()+"'}",
                                                 contentType: "application/json; charset=utf-8",
                                                 dataType: "json"                 
                                             });
                        }
                    });
                    $("#map_city").on('select', function (event) {
                    if (event.args) {
                        var item = event.args.item;
                        if (item) {
                            $("#map_code").val(item.value);
                            $("#map_city_desc").val(item.label);
                        }
                    }
                });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 100px">
                    <uc1:ctrlFormHeader ID="CtrlFormHeader" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <div id="jqxgrid"></div>
                </td>
            </tr>
        </table>
        <div id="popupWindow">
            <div>Edit</div>
            <div style="overflow: hidden;">
                <table>
                    <tr>
                        <td align="right">City Code:</td>
                        <td align="left"><input id="city_code" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td align="right">City Name:</td>
                        <td align="left"><input id="city_name" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td align="right">Map City Code:</td>
                        <td align="left"><input id='map_code' readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td align="right">Map City:</td>
                        <td align="left"><div id='map_city'></div><input id='map_city_desc' type="hidden" /></td>
                    </tr>
                    <tr>
                        <td align="right"></td>
                        <td style="padding-top: 10px;" align="right">
                        <input style="margin-right: 5px;" type="button" id="Save" value="Save" />
                        <input id="Cancel" type="button" value="Cancel" /></td>
                    </tr>
                </table>
            </div>
       </div>
    </div>
    </form>
</body>
</html>
