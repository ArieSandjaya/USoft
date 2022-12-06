<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Supplier.aspx.cs" Inherits="USoft.Modules.Main.Master.Supplier" %>
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
                    { name: 'supplier_id', type: 'string' },
                    { name: 'supplier_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'city', type: 'string' },
                    { name: 'zipcode', type: 'string' },
                    { name: 'phone', type: 'string' },
                    { name: 'Active', type: 'string' },
                ],
                updaterow: function (rowid, rowdata, commit) {commit(true);},
                url: 'Supplier.aspx/GetSuppliers'
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
                  { text: 'Code', datafield: 'supplier_id', width: '10%' },
                  { text: 'Supplier Name', datafield: 'supplier_name', width: '25%' },
                  { text: 'Address', datafield: 'address', width: '30%' },
                  { text: 'City', datafield: 'city', width: '10%' },
                  { text: 'Zip Code', datafield: 'zipcode', width: '10%' },
                  { text: 'Phone', datafield: 'phone', width: '10%' },
                  { text: 'Active', datafield: 'Active', width: '3%' },
                  { text: 'Edit', datafield: 'Edit', columntype: 'button', cellsrenderer: function () {
                     return "Edit";
                     }, buttonclick: function (row) {
                         editrow = row;
                         var offset = $("#jqxgrid").offset();
                         $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 300, y: parseInt(offset.top) + 10 } });
                         var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
                         $("#supplier_id").val(dataRecord.supplier_id);
                         $("#supplier_name").val(dataRecord.supplier_name);
                         $("#address").val(dataRecord.address);
                         $("#city").val(dataRecord.city);
                         $("#zipcode").val(dataRecord.zipcode);
                         $("#phone").val(dataRecord.phone);
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
                                url: "Supplier.aspx/UpdateSuppliers",
                                data: "{'supplier_id':'"+$("#supplier_id").val()+"', 'supplier_name':'"+$("#supplier_name").val()+"', 'address':'"+$("#address").val()+"', 'city':'"+$("#city").val()+"', 'zipcode':'"+$("#zipcode").val()+"', 'phone':'"+$("#phone").val()+"', 'npwp':'"+$("#npwp").val()+"', 'Active':'"+$("#Active").val()+"'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json"});
                    request.done(function(msg) {var row = {supplier_id: $("#supplier_id").val(), supplier_name: $("#supplier_name").val(), address: $("#address").val(), city: $("#city").val(), zipcode: $("#zipcode").val(), phone: $("#phone").val(), npwp: $("#npwp").val(), Active: $("#Active").val()};
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
                                          url: "Supplier.aspx/InsertSuppliers",
                                          data: "{'supplier_id':'"+$("#txtSupplier_id").val()+"', 'supplier_name':'"+$("#txtsupplier_name").val()+"', 'address':'"+$("#txtaddress").val()+"', 'city':'"+$("#txtcity").val()+"', 'zipcode':'"+$("#txtzipcode").val()+"', 'phone':'"+$("#txtphone").val()+"', 'npwp':'"+$("#txtnpwp").val()+"', 'Active':'"+$("#txtActive").val()+"'}",
                                          contentType: "application/json; charset=utf-8",
                                          dataType: "json"                  
                                           });
                    request.done(function(msg) {
                                var row = {supplier_id: $("#txtsupplier_id").val(), supplier_name: $("#txtsupplier_name").val(), address: $("#txtaddress").val(), city: $("#txtcity").val(), zipcode: $("#txtzipcode").val(), phone: $("#txtphone").val(), npwp: $("#txtnpwp").val(), Active: $("#txtActive").val()};
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
                            <td align="right">Code :</td>
                            <td align="left"><input id="supplier_id" readonly="readonly"/></td>
                        </tr>
                        <tr>
                            <td align="right">Supplier Name :</td>
                            <td align="left"><input id="supplier_name" /></td>
                        </tr>
                        <tr>
                            <td align="right">Address :</td>
                            <td align="left"><input id="address" /></td>
                        </tr>
                        <tr>
                            <td align="right">City :</td>
                            <td align="left"><input id="city"/></td>
                        </tr>
                        <tr>
                            <td align="right">Zip Code :</td>
                            <td align="left"><input id="zipcode"/></td>
                        </tr>
                        <tr>
                            <td align="right">Phone :</td>
                            <td align="left"><input id="phone"/></td>
                        </tr>
                        <tr>
                            <td align="right">NPWP :</td>
                            <td align="left"><input id="npwp"/></td>
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
                            <td align="right">Code :</td>
                            <td align="left"><input id="txtSupplier_id"/></td>
                        </tr>
                        <tr>
                            <td align="right">Supplier Name :</td>
                            <td align="left"><input id="txtsupplier_name" /></td>
                        </tr>
                        <tr>
                            <td align="right">Address :</td>
                            <td align="left"><input id="txtaddress" /></td>
                        </tr>
                        <tr>
                            <td align="right">City :</td>
                            <td align="left"><input id="txtcity"/></td>
                        </tr>
                        <tr>
                            <td align="right">Zip Code :</td>
                            <td align="left"><input id="txtzipcode"/></td>
                        </tr>
                        <tr>
                            <td align="right">Phone :</td>
                            <td align="left"><input id="txtphone"/></td>
                        </tr>
                        <tr>
                            <td align="right">NPWP :</td>
                            <td align="left"><input id="txtnpwp"/></td>
                        </tr>
                        <tr>
                            <td align="right">Active :</td>
                            <td align="left"><div id="ddlActive"></div><input id="txtActive" type="hidden" /></td>
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


