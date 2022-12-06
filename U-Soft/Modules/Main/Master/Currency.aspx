<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Currency.aspx.cs" Inherits="USoft.Modules.Main.Master.Currency" %>

<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Currency Page</title>
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jqwidgets/jqx-all.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var source =
            {   type: "GET",
                datatype: "json",
                datafields: [
                    { name: 'currency_code', type: 'string' },
                    { name: 'description', type: 'string' }
                ],
                updaterow: function (rowid, rowdata, commit) {commit(true);},
                url: 'Currency.aspx/GetCurrency'
            };
            var dataAdapter = new $.jqx.dataAdapter(source, {
                contentType: 'application/json; charset=utf-8',
                loadError: function (xhr, status, error) {
                    alert(error);
                }
            });

            $("#jqxgrid").jqxGrid(
            {
                width: '100%',
                source: dataAdapter,
                columnsresize: true,
                showstatusbar: true,
                columns: [
                  { text: 'Code', datafield: 'currency_code', width: '20%' },
                  { text: 'Currency Name', datafield: 'description', width: '75%' },
                  { text: 'Edit', datafield: 'Edit', columntype: 'button', cellsrenderer: function () {
                     return "Edit";
                     }, buttonclick: function (row) {
                         editrow = row;
                         var offset = $("#jqxgrid").offset();
                          $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 300, y: parseInt(offset.top) + 10 } });
                         var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
                         $("#currency_code").val(dataRecord.currency_code);
                         $("#description").val(dataRecord.description);
                         $("#popupWindow").jqxWindow('open');
                     }
                   }
              ],
              renderstatusbar: function (statusbar) {
                var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
                var addButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../../Javascript/jqwidgets/styles/images/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Add</span></div>");
                container.append(addButton);
                statusbar.append(container);
                addButton.jqxButton({width: 60, height: 20});
                addButton.click(function (event) {
                        var offset = $("#jqxgrid").offset();
                        $("#txtCurrencyCode").val("");
                        $("#txtCurrencyName").val("");
                        $("#popupadd").jqxWindow('open');
                        $("#popupadd").jqxWindow({ position: { x: parseInt(offset.left) + 300, y: parseInt(offset.top) + 10 } });
                    });
                }
            });
            $("#popupWindow").jqxWindow({
                width: 350, resizable: false, isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01           
            });
            $("#popupadd").jqxWindow({
                width: 350, resizable: false, isModal: true, autoOpen: false, cancelButton: $("#btnCancel"), modalOpacity: 0.01           
            });
            $("#Save").click(function () {
                if (editrow >= 0) {
                    var row = {currency_code: $("#currency_code").val(), description: $("#description").val()};
                    var rowID = $('#jqxgrid').jqxGrid('getrowid', editrow);
                    $('#jqxgrid').jqxGrid('updaterow', rowID, row);
                    $("#popupWindow").jqxWindow('hide');
                    $.ajax({
                            type: "POST",
                            url: "Currency.aspx/UpdateCurrency",
                            data: "{'CcyCode':'"+$("#currency_code").val()+"', 'CcyName':'"+$("#description").val()+"'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json"                 
                           });
                }
            });
            $("#btnSave").click(function () {
                    var row = {currency_code: $("#txtCurrencyCode").val(), description: $("#txtCurrencyName").val()};
                    $('#jqxgrid').jqxGrid('addrow', null, row);
                    $("#popupadd").jqxWindow('hide');
                    $.ajax({
                            type: "POST",
                            url: "Currency.aspx/InsertCurrency",
                            data: "{'CcyCode':'"+$("#txtCurrencyCode").val()+"', 'CcyName':'"+$("#txtCurrencyName").val()+"'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json"                 
                           });
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 100%">
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
                            <td align="right">Currency Code :</td>
                            <td align="left"><input id="currency_code" readonly="readonly"/></td>
                        </tr>
                        <tr>
                            <td align="right">Currency Name :</td>
                            <td align="left"><input id="description" /></td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td style="padding-top: 10px;" align="right"><input style="margin-right: 5px;" type="button" id="Save" value="Save" /><input id="Cancel" type="button" value="Cancel" /></td>
                        </tr>
                    </table>
                </div>
        </div>
        <div id="popupadd">
            <div>New</div>
                <div style="overflow: hidden;">
                    <table>
                        <tr>
                            <td align="right">Currency Code :</td>
                            <td align="left"><input id="txtCurrencyCode" value=""/></td>
                        </tr>
                        <tr>
                            <td align="right">Currency Name :</td>
                            <td align="left"><input id="txtCurrencyName" value=""/></td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td style="padding-top: 10px;" align="right"><input style="margin-right: 5px;" type="button" id="btnSave" value="Save" /><input id="btnCancel" type="button" value="Cancel" /></td>
                        </tr>
                    </table>
                </div>
        </div>
    </div>
    </form>
</body>
</html>
