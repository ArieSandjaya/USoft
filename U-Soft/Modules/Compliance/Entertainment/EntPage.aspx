<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntPage.aspx.cs" Inherits="USoft.Modules.Compliance.Entertainment.EntPage" %>
<%@ Register Src="../../../Controls/ctrlFormHeader.ascx" TagName="ctrlFormHeader"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Entertainment Page</title>
    <link href="../../../CSS/black-tie/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/ui-layout.css"rel="stylesheet" type="text/css" />
    <link href="../../../CSS/black-tie/validationEngine.jquery.css"rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../../Javascript/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/jquery.formatCurrency-1.4.0.min.js"></script>
    <script type="text/javascript" src="../../../Javascript/date.js"></script>
    <script type="text/javascript" src="../../../Javascript/ScriptSession.js"></script>
    <script type="text/javascript">
       $(document).ready(function()
            {
                $("#EntPage").validationEngine();
                //$("#txtCountpartyType").hide();
                $("#trReason").hide();
                $("#trAnti").hide();
                $("#txtAnti").val("Not Required");
                $("#tr2").show();
                $("#tr1").hide();
                $("#lblValAccountDetail").hide();
                $("#txtAcceptance").val("Acceptance");
                $("input[type=radio][id*=rdAcceptanceOffer]").click(function()
                    {
                        $('#EntPage').validationEngine('hide');
                        if($(this).val() == "Acceptance")
                        {
                            $("#lblValAccountDetail").hide();
                            $("#trRegulerSudden").hide();
                            $("#trEstimated").show();
                            $("#txtAcceptance").val("Acceptance");
                            $("#txtOffer").val("");
                            if($("#lblNo").text() !="")
                            {
                                $("#trTotalAmount").show();
                            }
                            else
                            {
                                $("#trTotalAmount").hide();
                            }
                        }
                        else
                        {
                            $("#lblValAccountDetail").show();                      
                            $("#trEstimated").show();
                            $("#trRegulerSudden").show();
                            if($('#trRegulerSudden input:checked').val()  == "Reguler")
                            {
                                $("#trEstimated").show();
                                if($("#lblNo").text() !="")
                                    {
                                        $("#trTotalAmount").show();
                                    }
                                    else
                                    {
                                        $("#trTotalAmount").hide();
                                    }
                            }
                            else
                            {
                                $("#trEstimated").hide();
                                $("#trTotalAmount").show();
                            }
                            $("#txtAcceptance").val("");$("#txtOffer").val("Offer");
                        }
                    });
                 $("input[type=radio][id*=rdCounterparty]").click(function()
                    {
                        if($(this).val() == "DealerName")
                        {$("#ddlCompanyNa").show();$("#txtCountpartyType").hide();$("#txtCounterParty").val("");
                            if($("#ddlCompanyNa option:selected").text() == "Not In The Lists...")
                            {
                                $("#txtCounterPartyAddOthers").show()
                            }
                            else
                            {
                                $("#txtCounterPartyAddOthers").hide()
                            }
                        }
                        else
                        {$("#ddlCompanyNa").hide();$("#txtCounterPartyAddOthers").hide();$("#txtCountpartyType").show();$("#txtCounterParty").val("ISI");}
                    });
                  $("input[type=radio][id*=rdAntiSocialCheck]").click(function()
                    {if($(this).val() == "Not Required")
                        {$("#txtAnti").val("Not Required");$("#trReason").hide();$("#tr2").show();$("#tr1").hide();}
                        else
                        {$("#txtAnti").val("");$("#trReason").hide();$("#tr2").hide();$("#tr1").hide();}});
                 $("input[type=radio][id*=rdlRegulerSudden]").click(function()
                    {if($(this).val() == "Reguler")
                        {
                            $("#trEstimated").show();
                            if($("#lblNo").text() !="")
                                    {
                                        $("#trTotalAmount").show();
                                    }
                                    else
                                    {
                                        $("#trTotalAmount").hide();
                                    }
                            $("#txtAcceptance").val("Acceptance");
                            $("#txtOffer").val("");}
                        else
                        {$("#trEstimated").hide();$("#trTotalAmount").show();$("#txtAcceptance").val("");$("#txtOffer").val("Offer");}
                    });
                 $("[id*=ddlCompanyNa]").change(function()
                    {
                    if($("#ddlCompanyNa option:selected").text() == "Not In The Lists...")
                        {$("#txtCounterPartyAddOthers").val("");$("#txtCounterPartyAddOthers").show();}
                        else
                        {$("#txtCounterPartyAddOthers").hide();$("#txtCounterPartyAddOthers").val($("#ddlCompanyNa option:selected").text());}});});
            function ShowPercentage()
		    {var p1;var p2;var p3;
                p1 = $('#TxtPercentage1').val().replace(/,/gi,"");
                p2 = $('#TxtPercentage2').val().replace(/,/gi,"");
                p3 = $('#TxtPercentage3').val().replace(/,/gi,"");
    	            if ( p1 == "") {p1 = 0}; 
    	            if ( p2 == "") {p2 = 0};
    	            if ( p3 == "") {p3 = 0};
    	             if((parseFloat(p1) + parseFloat(p2) + parseFloat(p3)) > 100)
    	             {alert('Not more than 100%');}
    	     };
            function getDate(dateValue){var DateValue=new Date(dateValue);var DateNw=new Date();var DateNow=DateNw.getFullYear()+"/"+(DateNw.getMonth()+1)+"/"+DateNw.getDate();
						            if(DateValue<DateNow){alert('oi');}};
    	    $(function(){$("#datepicker").datepicker();
    	    $("#datepicker").datepicker("option", "dateFormat", "dd-M-yy");});
    	    $(function($){$("#txtTime").mask("99:99");});
    	    $(function(){$('#txtEstBudget').blur(function(){$(this).formatCurrency({colorize:true,negativeFormat:'-%s%n',roundToDecimalPlace:0});}).keyup(function(e){var e=window.event||e;var keyUnicode=e.charCode||e.keyCode;if(e!==undefined){switch(keyUnicode){case 16:break;case 17:break;case 18:break;case 27:this.value='';break;case 35:break;case 36:break;case 37:break;case 38:break;case 39:break;case 40:break;case 78:break;case 110:break;case 190:break;default:$(this).formatCurrency({colorize:true,negativeFormat:'-%s%n',roundToDecimalPlace:0,eventOnDecimalsEntered:true});}}});
    	                 $('#txtTotalAmount').blur(function(){$(this).formatCurrency({colorize:true,negativeFormat:'-%s%n',roundToDecimalPlace:0});}).keyup(function(e){var e=window.event||e;var keyUnicode=e.charCode||e.keyCode;if(e!==undefined){switch(keyUnicode){case 16:break;case 17:break;case 18:break;case 27:this.value='';break;case 35:break;case 36:break;case 37:break;case 38:break;case 39:break;case 40:break;case 78:break;case 110:break;case 190:break;default:$(this).formatCurrency({colorize:true,negativeFormat:'-%s%n',roundToDecimalPlace:0,eventOnDecimalsEntered:true});}}});});
			function Val_RegulerOrSuddenDate()
    	     {
    	         var EvenDate = $('#datepicker').val().replace(/,/gi,"");
    	         var tmp = $('#txtTime').val();
    	         EvenDate = Date.parse(EvenDate+" " +tmp);
    	         var Now =  new Date();
    	         var CreateDate = Date.parse(Now.format("dd-MMM-yyyy HH:mm"));
    	         if($('#hdAction').val() == 'New')
    	         {
    	             if (CreateDate < EvenDate )
    	                {
    	                  if($('#trRegulerSudden input:checked').val()  != "Reguler" && $('#trOfferAcceptance input:checked').val()!="Acceptance")
    	                  {
    	                   alert ('Sorry, but your entertainment type was wrong');
    	                   return false;
    	                  }
						  else
						  {
						    return true;
						  }
    	              }
    	             else
    	              {
                        if($('#trRegulerSudden input:checked').val()  != "Sudden" && $('#trOfferAcceptance input:checked').val()!="Acceptance")
    	                  {
    	                    alert ('Sorry, but your entertainment type was wrong');
    	                    return false;
    	                  }
						  else
						  {
						  return true;
						  }
    	                }
    	              }
    	             else
    	             {
    	                return true;
    	             }
    	     };
			 function ValidatePage()
                {
                if ($('#trOfferAcceptance input:checked').val()=="Acceptance")
                  { 
                      $('#TxtBankName').removeClass();
                      $('#TxtAccName').removeClass();
                      $('#TxtAccNo').removeClass();
                  }
                  else
                  {
                      $('#TxtBankName').removeClass();
                      $('#TxtAccName').removeClass();
                      $('#TxtAccNo').removeClass();
                      $('#TxtBankName').addClass('validate[required] text-input');
                      $('#TxtAccName').addClass('validate[required] text-input');
                      $('#TxtAccNo').addClass('validate[required] text-input');
                  }
               if($('#EntPage').validationEngine('validate')==true)
                    {           
                        if(Val_RegulerOrSuddenDate()==true)
						{
						    window.parent.parent.loadWait();
							return true;
						}
						else
						{
							return false;
						}
					}
                    else
					{
                        return false;
                    } 
             }; 
             function CekAmount(field, rules, i, options)
             {
                    if(parseFloat($("#txtTotalAmount").val().replace(/,/gi,"")) > parseFloat($("#txtEstBudget").val().replace(/,/gi,"")))
                    {
                        if($('#trRegulerSudden input:checked').val() != "Reguler")
                            {
                                return options.allrules.validate2fieldsTotal.alertText;
                            }
                        else
                        {
                            $("#trReason").show();
                        }
                    }
                    else
                    {
                        $("#trReason").hide();
                    }

             };       
             function CekProcentage(field, rules, i, options)
             {
                var p1;var p2;var p3;
                p1 = $('#TxtPercentage1').val().replace(/,/gi,"");
                p2 = $('#TxtPercentage2').val().replace(/,/gi,"");
                p3 = $('#TxtPercentage3').val().replace(/,/gi,"");
    	            if ( p1 == "") {p1 = 0}; 
    	            if ( p2 == "") {p2 = 0};
    	            if ( p3 == "") {p3 = 0};
    	             if((parseFloat(p1) + parseFloat(p2) + parseFloat(p3)) > 100)
    	             {return options.allrules.validate2fieldsProcentage.alertText;}
             };   
	</script>
</head>
<body>
    <form id="EntPage" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td colspan="4">
                    <uc1:ctrlFormHeader ID="CtrlFormHeader" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 20%">
                    <asp:Label ID="Label1" runat="server" Text="Sequence Number" Width="158px"></asp:Label></td>
                <td style="width: 2%">
                    :</td>
                <td style="width: 2%">
                </td>
                <td style="width: 708px">
                                <asp:Label ID="lblNo" runat="server" BackColor="WhiteSmoke" Width="100%"></asp:Label></td>
            </tr>
            <tr id="trOfferAcceptance">
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="Label3" runat="server" Text="Acceptance / Offer" Width="158px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px">
                                <asp:RadioButtonList ID="rdAcceptanceOffer" runat="server" CellPadding="0" CellSpacing="0"
                                    Font-Size="8pt" RepeatDirection="Horizontal" Width="46%">
                                    <asp:ListItem Selected="True" Value="Acceptance">Acceptance</asp:ListItem>
                                    <asp:ListItem Value="Offer">Offer</asp:ListItem>
                                </asp:RadioButtonList>
                                <input id="txtAcceptance" type="hidden" runat="server"/>
                                <input id="txtOffer" type="hidden" runat="server"/></td>
            </tr>
            <tr id="trRegulerSudden" runat="server">
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="Label4" runat="server" Text="Entertainment Type" Width="158px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px">
                                <asp:RadioButtonList ID="rdlRegulerSudden" runat="server" CellPadding="0" CellSpacing="0"
                                    Font-Size="8pt" Height="23px"
                                    RepeatDirection="Horizontal" Width="57%">
                                    <asp:ListItem Selected="True" Value="Reguler">Reguler</asp:ListItem>
                                    <asp:ListItem Value="Sudden">Sudden</asp:ListItem>
                                </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label5" runat="server" Text="Applicant Name" Width="158px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValApplicationName" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="TxtApplName" runat="server" CssClass="ui-widget-text validate[required] text-input"
                                    Font-Size="8pt" MaxLength="50" Style="padding-right: 0px; padding-left: 0px;
                                    padding-bottom: 0px; margin: 0px; text-transform: none; padding-top: 0px" Width="99%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="Label6" runat="server" Text="Account Details" Width="158px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="vertical-align: top; width: 11px; text-align: left">
                    <asp:Label ID="lblValAccountDetail" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr valign="top">
                                        <td align="left" style="font-size: 8pt">
                                            Bank Name</td>
                                        <td align="left">
                                            :</td>
                                        <td align="left" style="width: 149px">
                                            <asp:TextBox ID="TxtBankName" runat="server" CssClass="validate[required] text-input"
                                                Font-Size="8pt" Height="14px" MaxLength="50" Width="124px"></asp:TextBox></td>
                                        <td align="left" style="font-size: 8pt">
                                            A/C No</td>
                                        <td>
                                            :</td>
                                        <td align="left" style="width: 227px">
                                            <asp:TextBox ID="TxtAccNo" runat="server" CssClass="validate[required] text-input"
                                                Font-Size="8pt" Height="14px" MaxLength="50" Width="141px"></asp:TextBox></td>
                                    </tr>
                                    <tr valign="top">
                                        <td align="left" style="font-size: 8pt">
                                            A/C Name</td>
                                        <td>
                                            :</td>
                                        <td align="left" colspan="4">
                                            <asp:TextBox ID="TxtAccName" runat="server" CssClass="validate[required] text-input" 
                                                Font-Size="8pt" MaxLength="50" Width="405px"></asp:TextBox></td>
                                    </tr>
                                </table>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="Label7" runat="server" Text="Branch" Width="158px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="vertical-align: top; width: 11px; text-align: left">
                    <asp:Label ID="Label8" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                            <asp:DropDownList ID="ddlBranch" runat="server" CssClass="textfont validate[required]"
                                                Font-Names="Trebuchet MS" Font-Size="0.9em" Width="207px">
                                            </asp:DropDownList><asp:DropDownList ID="ddlDept" runat="server" Font-Italic="False" Font-Names="Trebuchet MS"
                                                Font-Size="0.9em" Height="20px" Width="248px" CssClass="textfont validate[required]">
                                            </asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label9" runat="server" Text="Company Name in Japan" Width="158px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px">
                                <asp:TextBox ID="TxtCompanyJPN" runat="server" Font-Size="8pt" MaxLength="50" Width="98%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 100px; vertical-align: top; text-align: left;">
                    <asp:Label ID="Label2" runat="server" Font-Size="8pt" Text="Type Of Counterparty"
                        Width="233px"></asp:Label><br />
                </td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px; vertical-align: top; text-align: left;">
                                <asp:RadioButtonList ID="rdCounterparty" runat="server" CellPadding="0" CellSpacing="0"
                                    Font-Size="8pt" RepeatDirection="Horizontal" Width="398px">
                                    <asp:ListItem Selected="True" Value="DealerName">DealerName</asp:ListItem>
                                    <asp:ListItem Value="OutSource">Outsource</asp:ListItem>
                                    <asp:ListItem Value="Others">Others</asp:ListItem>
                                </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px; vertical-align: top; text-align: left;">
                    <asp:Label ID="Label23" runat="server" Font-Italic="True" Font-Size="7pt" Text="Company Name in Here"
                        Width="233px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                </td>
                <td style="width: 11px">
                </td>
                <td style="vertical-align: top; width: 708px; text-align: left">
                    <asp:DropDownList ID="ddlCompanyNa" runat="server" DataTextField="organization_name"
                                    DataValueField="organization_name" Font-Size="8pt"
                                    Width="99%">
                                </asp:DropDownList>
                    <input id="txtCounterParty" style="width: 193px" type="hidden" runat="server"/><asp:TextBox ID="txtCounterPartyAddOthers" runat="server" Font-Size="8pt"
                                    MaxLength="200" Rows="100" Width="98%"></asp:TextBox><asp:TextBox ID="txtCountpartyType" runat="server"
                                    Font-Size="8pt" MaxLength="200" Width="98%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label10" runat="server" Font-Size="8pt" Text="Line Of Bussiness" Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValLineOfBussiness" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtLineBussines" runat="server" CssClass="validate[required] text-input" 
                                    Font-Size="8pt" MaxLength="50" Width="98%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label11" runat="server" Font-Size="8pt" Text="Purpose/Reason for Offer/Acceptance"
                        Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValPurpose" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtPurpose" runat="server" CssClass="validate[required] text-input" 
                                    Font-Size="8pt" MaxLength="2000" Width="98%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="Label12" runat="server" Font-Size="8pt" Text="Event(s) or Item(s)"
                        Width="233px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="vertical-align: top; width: 11px; text-align: left">
                    <asp:Label ID="lblValItem" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:RadioButtonList ID="RdEvents" runat="server" BorderStyle="Solid" Font-Size="8pt"
                                    RepeatColumns="2" Width="477px">
                                    <asp:ListItem Selected="True" Value="0">Lunch</asp:ListItem>
                                    <asp:ListItem Value="1">Dinner</asp:ListItem>
                                    <asp:ListItem Value="2">Drink</asp:ListItem>
                                    <asp:ListItem Value="3">Amusement (Golf,Mahjong,ect)</asp:ListItem>
                                    <asp:ListItem Value="4">Gift (Cakes,Parcels,Flowers,etc)</asp:ListItem>
                                    <asp:ListItem Value="5">Invitation to events</asp:ListItem>
                                    <asp:ListItem Value="6">Others</asp:ListItem>
                                </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label13" runat="server" Font-Size="8pt" Text="Place, date, time" Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValPlace" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtPlace" runat="server" CssClass="validate[required] text-input" 
                                    Font-Size="8pt" MaxLength="50" Width="314px"></asp:TextBox>,<asp:TextBox ID="datepicker" runat="server" CssClass="validate[required] text-input datepicker" 
                                    Font-Size="8pt" onChange="getDate(this.value);" Width="94px"></asp:TextBox>,<asp:TextBox ID="txtTime" runat="server" CssClass="validate[required] text-input" 
                                    Font-Italic="False" Font-Size="8pt" Width="33px"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label14" runat="server" Font-Size="8pt" Text="Our Attendee(s)" Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValAttendee" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtOurAttendee" runat="server" CssClass="validate[required] text-input" 
                                    Font-Size="8pt" MaxLength="100" Width="98%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label15" runat="server" Font-Size="8pt" Text="Counterparty Attendee(s)"
                        Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValCounterparty" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtCounterAttendee" runat="server" CssClass="validate[required] text-input" 
                                    Font-Size="8pt" MaxLength="1000" Width="98%"></asp:TextBox></td>
            </tr>
            <tr id="trEstimated" runat="server">
                <td style="width: 100px">
                    <asp:Label ID="Label16" runat="server" Font-Size="8pt" Text="Estimated Budget" Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValEstimamte" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtEstBudget" runat="server"
                                    Font-Size="8pt" Style="text-align: right"></asp:TextBox></td>
            </tr>
            <tr id="trTotalAmount" runat="server">
                <td style="width: 100px">
                    <asp:Label ID="Label17" runat="server" Font-Size="8pt" Text="Total Amount" Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValTotalAmount" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtTotalAmount" runat="server" 
                                    Font-Size="8pt" Style="text-align: right"></asp:TextBox></td>
            </tr>
            <tr id="trReason">
                <td style="width: 100px">
                    <asp:Label ID="Label18" runat="server" Font-Size="8pt" Text="Reason For Exceeding Budget"
                        Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                    <asp:Label ID="lblValReason" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtReason" runat="server" CssClass="validate[required] text-input" 
                                    Font-Size="8pt" MaxLength="1000" Width="98%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:Label ID="Label19" runat="server" Font-Size="8pt" Text="Original ReceiptNo"
                        Width="233px"></asp:Label></td>
                <td style="width: 10px">
                    :</td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtReceiptNo" runat="server" Font-Size="8pt" MaxLength="30" Width="78%"></asp:TextBox>
                    <asp:CheckBox ID="ChkOriReceiptAttach" runat="server" Font-Size="7pt" Height="23px"
                                    Text="Attached" Width="67px" /></td>
            </tr>
            <tr>
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="Label20" runat="server" Font-Size="8pt" Text="Expense" Width="233px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="vertical-align: top; width: 11px; text-align: left">
                    <asp:Label ID="lblValExpense" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <table cellpadding="0" cellspacing="0" style="border-right: black thin solid; border-top: black thin solid;
                                    border-left: black thin solid; width: 481px; border-bottom: black thin solid;
                                    height: 108px">
                                    <tr valign="top">
                                        <td align="center" style="border-top-width: thin; border-right: black thin solid;
                                            border-left-width: thin; font-size: 8pt; border-left-color: black; border-top-color: black;
                                            border-bottom: black thin solid; background-color: whitesmoke" width="80%">
                                            Participant's Sites</td>
                                        <td align="center" style="border-top-width: thin; font-size: 8pt; border-top-color: black;
                                            border-bottom: black thin solid; background-color: whitesmoke">
                                            Percentage</td>
                                    </tr>
                                    <tr valign="top">
                                        <td style="border-right: black thin solid; border-left-width: thin; border-left-color: black; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; clip: rect(0px 0px 0px 0px); padding-top: 0px; height: 14px;">
                                            <asp:TextBox ID="TxtParticipant1" runat="server" CssClass="validate[groupRequired[Expense]] text-input" 
                                                Font-Size="8pt" MaxLength="50" Style="padding-right: 0px; padding-left: 0px;
                                                padding-bottom: 0px; margin: 0px 0px 0px 1px; border-top-style: none; padding-top: 0px;
                                                border-right-style: none; border-left-style: none; border-bottom-style: none"
                                                Width="98%"></asp:TextBox></td>
                                        <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; height: 14px;">
                                            <asp:TextBox ID="TxtPercentage1" runat="server" Font-Size="8pt" CssClass="validate[funcCall[CekProcentage]] text-input"
                                                Style="padding-right: 2px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                                                border-top-style: none; padding-top: 0px; border-right-style: none; border-left-style: none;
                                                text-align: right; border-bottom-style: none" Width="75%"></asp:TextBox>&nbsp;%</td>
                                    </tr>
                                    <tr valign="top">
                                        <td style="border-right: black thin solid; border-top: black thin solid; border-left-width: thin;
                                            border-left-color: black; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; height: 14px;">
                                            <asp:TextBox ID="TxtParticipant2" runat="server" CssClass="validate[groupRequired[Expense]] text-input" 
                                                Font-Size="8pt" MaxLength="50" Style="padding-right: 0px; padding-left: 0px;
                                                padding-bottom: 0px; margin: 0px 0px 0px 1px; border-top-style: none; padding-top: 0px;
                                                border-right-style: none; border-left-style: none; border-bottom-style: none"
                                                Width="98%"></asp:TextBox></td>
                                        <td style="border-top: black thin solid; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; height: 14px;">
                                            <asp:TextBox ID="TxtPercentage2" runat="server" Font-Size="8pt" CssClass="validate[funcCall[CekProcentage]] text-input"
                                                Style="padding-right: 2px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                                                border-top-style: none; padding-top: 0px; border-right-style: none; border-left-style: none;
                                                text-align: right; border-bottom-style: none" Width="75%"></asp:TextBox>&nbsp;%</td>
                                    </tr>
                                    <tr valign="top">
                                        <td style="border-right: black thin solid; border-top: black thin solid; border-left-width: thin;
                                            border-left-color: black; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; height: 14px;">
                                            <asp:TextBox ID="TxtParticipant3" runat="server" CssClass="validate[groupRequired[Expense]] text-input" 
                                                Font-Size="8pt" MaxLength="50" Style="padding-right: 0px; padding-left: 0px;
                                                padding-bottom: 0px; margin: 0px 0px 0px 1px; border-top-style: none; padding-top: 0px;
                                                border-right-style: none; border-left-style: none; border-bottom-style: none"
                                                Width="98%"></asp:TextBox></td>
                                        <td style="border-top: black thin solid; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; height: 14px;">
                                            <asp:TextBox ID="TxtPercentage3" runat="server" Font-Size="8pt" CssClass="validate[funcCall[CekProcentage]] text-input"
                                                Style="padding-right: 2px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
                                                border-top-style: none; padding-top: 0px; border-right-style: none; border-left-style: none;
                                                text-align: right; border-bottom-style: none" Width="75%"></asp:TextBox>&nbsp;%</td>
                                    </tr>
                                </table>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="Label21" runat="server" Font-Size="8pt" Text="Anti social element check required"
                        Width="233px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px">
                                <asp:RadioButtonList ID="rdAntiSocialCheck" runat="server" CellPadding="0" CellSpacing="0"
                                    Font-Size="8pt" RepeatDirection="Horizontal" Width="270px">
                                    <asp:ListItem Selected="True" Value="Not Required">Not Required</asp:ListItem>
                                    <asp:ListItem Value="Required">Required</asp:ListItem>
                                </asp:RadioButtonList>
                                <input id="txtAnti" type="hidden" runat="server" /></td>
            </tr>
            <tr id="tr2">
                <td style="width: 100px">
                    <asp:Label ID="Label22" runat="server" Font-Size="8pt" Text="Reason (if anti social element check is not required)"
                        Width="233px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="vertical-align: top; width: 11px; text-align: left">
                    <asp:Label ID="lblValReasonSosial" runat="server" Style="color: red" Text="*"></asp:Label></td>
                <td style="width: 708px">
                                <asp:TextBox ID="txtReasonAnti" runat="server" CssClass="validate[condRequired[txtAnti]] text-input" 
                                    Font-Names="Arial" Font-Size="8pt" Height="29px" MaxLength="1000" Width="98%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:Label ID="lblValComment" runat="server" Font-Size="8pt" Text="Comments" Width="233px"></asp:Label></td>
                <td style="vertical-align: top; width: 10px; text-align: left">
                    :</td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px">
                                <asp:TextBox ID="TxtComments" runat="server" Font-Names="Arial" Font-Size="8pt" MaxLength="2000"
                                    TextMode="MultiLine" Width="98%" Wrap="False"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:HiddenField ID="hdAction" runat="server" />
                </td>
                <td style="width: 10px">
                </td>
                <td style="width: 11px">
                </td>
                <td style="width: 708px">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                    
        <table style="width: 116px">
                                            <tr>
                                                <td style="height: 26px">
                                                    <asp:Button ID="btnSave" runat="server" CssClass="ui-state-hover" Font-Size="8pt"
                                                        OnClick="btnSave_Click" OnClientClick="javascript:return ValidatePage();" Style="cursor: hand"
                                                        Text="Save" Width="61px" /></td>
                                                <td style="height: 26px">
                                                    <asp:Button ID="btnPrint" runat="server" CssClass="ui-state-hover" Enabled="False"
                                                        Font-Size="8pt" OnClick="btnPrint_Click1" Text="Print" Width="61px" /></td>
                                                <td style="width: 64px; height: 26px">
                                                    </td>
                                                <td style="width: 72px; height: 26px">
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                        
                                    </td>
            </tr>
        </table>
                                
    </div>
                                
    </form>
</body>
</html>