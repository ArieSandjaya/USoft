<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Items.aspx.cs" Inherits="USoft.Modules.Main.Master.Items" %>
<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Measurement Page</title>
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="../../../Javascript/jqwidgets/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jqwidgets/jqx-all.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var ddlActive =["Y","N"];
			$("#ddlActive").jqxComboBox({ source: ddlActive, selectedIndex: 0, width: '50px', height: '20px'});
			$("#ddlActive1").jqxComboBox({ source: ddlActive, selectedIndex: 0, width: '50px', height: '20px'});
			$('#ddlActive').on('select', function (event) {
                    var args = event.args;
                    if (args != undefined) {
                        var item = $('#ddlActive').jqxComboBox('getItem', args.index);
                        if (item != null) {
                            $('#txtActvie').val(item.label);
                        }
                    }
                });
			$('#ddlActive1').on('select', function (event) {
                    var args = event.args;
                    if (args != undefined) {
                        var item = $('#ddlActive1').jqxComboBox('getItem', args.index);
                        if (item != null) {
                            $('#Active').val(item.label);
                        }
                    }
                });
            var source =
            {   type: "GET",
                datatype: "json",
                datafields: [
                    { name: 'item_code', type: 'string' },
                    { name: 'item_name', type: 'string' },
                    { name: 'category_code', type: 'string' },
                    { name: 'price', type: 'number' },
                    { name: 'Active', type: 'string' },
                ],
                updaterow: function (rowid, rowdata, commit) {commit(true);},
                url: 'Items.aspx/GetItems'
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
                  { text: 'Code', datafield: 'item_code', width: '20%' },
                  { text: 'Item Name', datafield: 'item_name', width: '50%' },
                  { text: 'Category Type', datafield: 'category_code', width: '10%' },
                  { text: 'Price', datafield: 'price', cellsformat: 'd',width: '10%' },
                  { text: 'Active', datafield: 'Active', width: '5%' },
                  { text: 'Edit', datafield: 'Edit', columntype: 'button', cellsrenderer: function () {
                     return "Edit";
                     }, buttonclick: function (row) {
                         editrow = row;
                         var offset = $("#jqxgrid").offset();
                         $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 300, y: parseInt(offset.top) + 10 } });
                         var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
                         $("#item_code").val(dataRecord.item_code);
                         $("#item_name").val(dataRecord.item_name);
                         $("#category_code").val(dataRecord.category_code);
                         $("#price").val(dataRecord.price);
                         $("#Active").val(dataRecord.Active);
                         $("#ddlActive1").val(dataRecord.Active);
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
                        $("#txtItemCode").val("");
                        $("#txtItemName").val("");
                        $("#txtCategoryCode").val("");
                        $("#txtPrice").val("");
                        $("#txtActvie").val("Y");
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
                    $("#popupWindow").jqxWindow('hide');
                    var request =$.ajax({type: "POST",
                                url: "Items.aspx/UpdateItems",
                                data: "{'ItemCode':'"+$("#item_code").val()+"', 'ItemName':'"+$("#item_name").val()+"', 'CategoryCode':'"+$("#category_code").val()+"', 'Price':'"+$("#price").val()+"', 'Active':'"+$("#Active").val()+"'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json"});
                    request.done(function(msg) {var row = {item_code: $("#item_code").val(), item_name: $("#item_name").val(), category_code: $("#category_code").val(), price: $("#price").val(), Active: $("#Active").val()};
                                                var rowID = $('#jqxgrid').jqxGrid('getrowid', editrow);
                                                $('#jqxgrid').jqxGrid('updaterow', rowID, row);
                                                });
                    request.fail(function(jqXHR, responseText) {
                                                alert( "Request failed: " + responseText );
                                                });
                }
            });
            $("#btnSave").click(function () {
                    $("#popupadd").jqxWindow('hide');
                    var request = $.ajax({type: "POST",
                                          url: "Items.aspx/InsertItems",
                                          data: "{'ItemCode':'"+$("#txtItemCode").val()+"', 'ItemName':'"+$("#txtItemName").val()+"', 'CategoryCode':'"+$("#txtCategoryCode").val()+"', 'Price':'"+$("#txtPrice").val()+"', 'Active':'"+$("#txtActvie").val()+"'}",
                                          contentType: "application/json; charset=utf-8",
                                          dataType: "json"                  
                                           });
                    request.done(function(msg) {
                                var row = {item_code: $("#txtItemCode").val(), item_name: $("#txtItemName").val(), category_code: $("#txtCategoryCode").val(), price: $("#txtPrice").val(), Active: $("#txtActvie").val()};
                                $('#jqxgrid').jqxGrid('addrow', null, row);
                                                });
                    request.fail(function(jqXHR, responseText) {
                                                alert( "Request failed: " + responseText );
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
                            <td align="right">Item Code :</td>
                            <td align="left"><input id="item_code" readonly="readonly"/></td>
                        </tr>
                        <tr>
                            <td align="right">Item Name :</td>
                            <td align="left"><input id="item_name" /></td>
                        </tr>
                        <tr>
                            <td align="right">Category Code :</td>
                            <td align="left"><input id="category_code" /></td>
                        </tr>
                        <tr>
                            <td align="right">Price :</td>
                            <td align="left"><input id="price" style="text-align: right" /></td>
                        </tr>
                        <tr>
                            <td align="right">Active :</td>
                            <td align="left"><div id="ddlActive1"></div><input id="Active" type="hidden" /></td>
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
                            <td align="right">Item Code :</td>
                            <td align="left"><input id="txtItemCode"/></td>
                        </tr>
                        <tr>
                            <td align="right">Item Name :</td>
                            <td align="left"><input id="txtItemName" /></td>
                        </tr>
                        <tr>
                            <td align="right">Category Code :</td>
                            <td align="left"><input id="txtCategoryCode" /></td>
                        </tr>
                        <tr>
                            <td align="right">Price :</td>
                            <td align="left"><input id="txtPrice" style="text-align: right" /></td>
                        </tr>
                        <tr>
                            <td align="right">Active :</td>
                            <td align="left"><div id="ddlActive"></div><input id="txtActvie" type="hidden" /></td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td style="padding-top: 10px;" align="right"><input style="margin-right: 5px;" type="button" id="btnSave" value="Save" /><input id="Button2" type="button" value="Cancel" /></td>
                        </tr>
                    </table>
                </div>
        </div>
    </div>
    </form>
</body>
</html>

