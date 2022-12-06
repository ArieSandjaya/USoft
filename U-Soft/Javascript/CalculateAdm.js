function CalculateTotals(TextId) { 
            var idNet;
            var idGross;
            var idRefund;
            var id;
            var idPref = "tc_tp1_gdView_ctl";

            //id = TextId.substring(10,12);
            id = TextId.substring(17,19);
            idNet = document.getElementById(idPref + id + "_txtNet").value;
            idGross = document.getElementById(idPref + id + "_txtGross").value;
            idRefund = idPref + id + "_txtRefund";
            document.getElementById(idRefund).innerText = idNet * idGross;
        }
function calcRefund(value)
        {
            var stdPremi;
            var upPremi;
            var AmountStd;
            var Amountup;
            var percentage = document.getElementById("txtRefundPercen").value;
            var btn = $('#btnCalculate');
            var MaxRefund;
            var BrandRate;
            var brand = document.getElementById("txtBrand").value;
            var insRate = document.getElementById("txtInsRate").value;
            stdPremi = document.getElementById("txtStdPremi").value;
            upPremi = document.getElementById("txtPremiCust").value;
            AmountStd = stdPremi.replace(/,/gi,"");
            Amountup = upPremi.replace(/,/gi,"");
            debugger;
            document.getElementById("txtRefundNet").value = CommaFormatted(CurrencyFormatted(((AmountStd * 25) / 100)));
            document.getElementById("txtNett").value = CommaFormatted(CurrencyFormatted((AmountStd * value) / 100));
            document.getElementById("txtRefund").value = CommaFormatted(CurrencyFormatted(Math.floor((Amountup * value) / 100)));
            MaxRefund =  document.getElementById("lblMaxRefund");
            if (document.getElementById("txtAssetCond").value == "NEW")
            {
                if(brand == 'HONDA' || brand == 'NISSAN' || brand == 'TOYOTA'|| brand == 'MAZDA' || brand == 'DAIHATSU' || brand == 'FORD'|| brand == 'SUZUKI')
                {
                    BrandRate = 50;
                    if(document.getElementById("lblMaxRefund").value <= BrandRate)
                    {
                        BrandRate = document.getElementById("lblMaxRefund").value;
                    }
                    document.getElementById("ddlRecalc").style.visibility = "";
                }
                else
                {
                    if(document.getElementById("txtRefundDealer").value > 0)
                        {BrandRate = document.getElementById("txtRefundDealer").value;}
                    else
                        {BrandRate = 40;}
                    document.getElementById("ddlRecalc").style.visibility="hidden";
                }
            }
            else
            {
                    if(document.getElementById("txtRefundDealer").value > 0)
                        {BrandRate = document.getElementById("txtRefundDealer").value;}
                    else
                        {BrandRate = 40;}
                    document.getElementById("ddlRecalc").style.visibility="hidden";
            }
            if (percentage <= BrandRate)
            {
                if (parseFloat(MaxRefund.innerText) >= percentage)
                {
                    btn.click();
                    if (percentage <= 25)
                    {
                        
                    }
                }
                else
                {
                    window.alert("Please Correct your refund procentage");
                }
            }
            else
            {
                window.alert("Refund Precentage Cannot more bigger than '"+ BrandRate +"'");
                document.getElementById("txtRefundPercen").value = "";
                document.getElementById("txtRefundNet").value = "";
                document.getElementById("txtRefund").value = "";
                var grid = document.getElementById("tc_tp1_gViewTotal");
                    if (grid != null)
                    {
                        grid.style.visibility = "hidden";
                    }
                var lbl = document.getElementById("lbl40"); 
                    if (lbl != null)
                    {
                        lbl.style.visibility = "hidden";
                    }
                var grid25 = document.getElementById("gViewTotal25");
                    if (grid25 != null)
                    {
                        grid25.style.visibility = "hidden";
                    }
                var lbl25 = document.getElementById("lbl25"); 
                    if (lbl25 !=null)
                    {
                        lbl25.style.visibility = "hidden";
                    }
                var gridSisa = document.getElementById("gViewTotalSisa");
                    if (gridSisa != null)
                    {
                        gridSisa.style.visibility = "hidden";
                    }
                var lblSisa = document.getElementById("lblSisa"); 
                    if (lblSisa != null)
                    {
                        lblSisa.style.visibility = "hidden";
                    }
            }
        }
        function calc(id,value)
        {
            var id25;var grid;var rowCount;
            var value25;
            var idSisa;var ttlAfter;var Total;
            var idPref;var idPrefSisa;var id25Sisa;
            var percentage;var totalGross;
            var grid25;var idSisa;var totalBeforeGross;
            totalBefor = document.getElementById("tc_tp1_gViewTotal");
            percentage = document.getElementById("txtRefundPercen").value;
                calcPercen(id,value);
                if (percentage > 25)
                    {
                        //idPref = id.substring(0,17);
                        idPref = id.substring(0,24);
                        id25 = id.replace("gViewTotal","gViewTotal25");
                        value25 = document.getElementById(idPref + "lblGrossMurni").innerText;
                        calcSisa15(idPref);
                    }
                grid = document.getElementById("tc_tp1_gViewTotal");
                rowCount = grid.rows.length;
                
                if (rowCount > 3)
                    {
                        totalGross = 0;
                        Total = 0;
                        //ttlAfter = document.getElementById(id.substring(0,14)+ ("0" + rowCount)+"_lblGrossTotal");
                        ttlAfter = document.getElementById(id.substring(0,21)+ ("0" + rowCount)+"_lblGrossTotal");
                        if(ttlAfter.value != percentage)
                        {
                            for(i=2;i<= grid.rows.length - 1;i++)
                            {
                                //totalBefore = document.getElementById(id.substring(0,14)+ ("0" + i)+"_lblGrossMurni");
                                totalBefore = document.getElementById(id.substring(0,21)+ ("0" + i)+"_lblGrossMurni");
                                //totalBeforeGross = document.getElementById(id.substring(0,14)+ ("0" + i)+"_lblGross");
                                totalBeforeGross = document.getElementById(id.substring(0,21)+ ("0" + i)+"_lblGross");
                                if (totalBefore.innerText == ""){totalBefore.innerText = 0;}
                                if(i != grid.rows.length - 1)
                                {
                                    Total += parseFloat(totalBefore.innerText);
                                    if(isNaN(totalBeforeGross.value)== true){totalBeforeGross.value = 0;}
                                    totalGross += parseFloat(totalBeforeGross.value);
                                }
                            }
                            Total = percentage - Total;
                            totalGross = Math.round((percentage-Math.round(totalGross*100)/100)*100)/100;
                            //document.getElementById(id.substring(0,14)+ ("0" + (grid.rows.length - 1))+"_lblGross").value = totalGross;
                            document.getElementById(id.substring(0,21)+ ("0" + (grid.rows.length - 1))+"_lblGross").value = totalGross;
                            //document.getElementById(id.substring(0,14)+ ("0" + (grid.rows.length - 1))+"_txtGross").value = Total;
                            document.getElementById(id.substring(0,21)+ ("0" + (grid.rows.length - 1))+"_txtGross").value = Total;
                            //idSisa = id.substring(0,14)+ ("0" + (rowCount-1))+"_txtGross"
                            idSisa = id.substring(0,21)+ ("0" + (rowCount-1))+"_txtGross"

                            calcPercen(idSisa,Total);
                            if (percentage > 25)
                                {
                                    //idPrefSisa = idSisa.substring(0,17);
                                    idPrefSisa = idSisa.substring(0,24);
                                    id25Sisa = idSisa.replace("gViewTotal","gViewTotal25");
                                    value25 = document.getElementById(idPrefSisa + "lblGrossMurni").innerText;
                                    calcSisa15(idPrefSisa);
                                }
                        }
                    }
        }
        function calcSisaPercent(value)
        {
            var table;
            var rowCount;
            table = document.getElementById("tc_tp1_gViewTotal");
            rowCount = table.rows.count;
        }
function calcPercen(id,value)
        {
            var netValue;var grossValue;var idPref;var idText;
            var valNet;var valGross;var valTotal;
            var TotalGross;
            var refPercent;
            var percent;
            var value;
            var valAmount;
            var valGrossAmt;
            var valTax;
            var grid;
            var idPredNum;
            var idPrefName;
            var gridNum;0
            var TotalAmount;
            var TotalTaxAmount;
            var gridTotalAmount;
            var gridTotalTaxAmount;
            var valNum;
            var gridNetTotal;
            var valTotalMurni;
            var valMurni;
            gridNum = 2;
            TotalGross = 0;
            TotalAmount = 0;
            TotalTaxAmount = 0;
            valTotalMurni = 0;
            valMurni = 0;
            //idPref = id.substring(0,17);
            idPref = id.substring(0,24)
            //idPrefName = id.substring(0,14);
            idPrefName = id.substring(0,21);
            idText = id.replace(idPref,"");
            valNet = document.getElementById("txtNett").value;
            valGross = document.getElementById("txtRefund").value;
            refPercent = document.getElementById("txtRefundPercen").value;
            percent = document.getElementById(id).value;
            var stdPremi;
            var upPremi;
            if (idText == "txtNet" && percent != "")
            {
                document.getElementById(idPref + "txtGross").value="";
                stdPremi = document.getElementById("txtStdPremi").value;
                upPremi = document.getElementById("txtPremiCust").value;
                valTotal = (stdPremi.replace(/,/gi,"") / upPremi.replace(/,/gi,""))* (percent);
                valTotalMurni = valTotal;
                document.getElementById(idPref + "lblGross").value = CommaFormatted(CurrencyFormatted(Math.round(valTotal*100000000)/100000000));
                document.getElementById(idPref + "lblGrossMurni").innerText = valTotalMurni;
            }
            else if(idText == "txtGross" && percent != "")
            {
                document.getElementById(idPref + "txtNet").value="";
                valTotal = document.getElementById(idPref + "txtGross").value;
                valTotalMurni = valTotal;
                document.getElementById(idPref + "lblGross").value = CommaFormatted(CurrencyFormatted(valTotal));
                document.getElementById(idPref + "lblGrossMurni").innerText = valTotalMurni;
            }
            if (document.getElementById(idPref + "txtGross").value=="" && document.getElementById(idPref + "txtNet").value=="")
            {
                    document.getElementById(idPref + "lblGross").value = 0;
                    document.getElementById(idPref + "lblGrossMurni").innerText = 0;
            }

            
            var percenTotal = document.getElementById("txtRefundPercen").value;
            if (percent != "" || document.getElementById(idPref + "lblGross").value == 0)
            {
                if (percenTotal > 25)
                {
                    valGrossAmt = document.getElementById("txtPremiCust").value;
                }
                else
                {
                    valGrossAmt = document.getElementById("txtStdPremi").value;
                }
                valAmount = (valTotalMurni * (valGrossAmt.replace(/,/gi,""))/100);
                document.getElementById(idPref + "lblAmountTotal").value = CommaFormatted(CurrencyFormatted(valAmount));
                valTax = document.getElementById(idPref + "lblTaxPercentTotal").innerText;
                document.getElementById(idPref + "lblTaxAmountTotal").value = CommaFormatted(CurrencyFormatted(valTax * valAmount));
                document.getElementById(idPref + "lblNetAmountTotal").value = CommaFormatted(CurrencyFormatted(valAmount - (CommaFormatted(CurrencyFormatted(valTax * valAmount)).replace(/,/gi,""))));
            }
            //grid = document.getElementById("gViewTotal");
            grid = document.getElementById("tc_tp1_gViewTotal");
            valAmount = 0;
            valTax = 0;
            valNum = 0;
            valMurni=0;
            valTotalMurni=0;
            for(i=2;i<= grid.rows.length;i++)
            {
                idPredNum = ("0" + i);
                if (i < grid.rows.length)
                {
                    gridNum = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblGross").value;
                    gridTotalAmount = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblAmountTotal").value;
                    gridTotalTaxAmount = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblTaxAmountTotal").value;
                    gridMurni = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblGrossMurni").innerText;
                    valMurni = parseFloat(gridMurni.replace(/,/gi,""));
                    valNum = parseFloat(gridNum.replace(/,/gi,""));
                    valAmount = parseFloat(gridTotalAmount.replace(/,/gi,""));
                    valTax = parseFloat(gridTotalTaxAmount.replace(/,/gi,""));
                    
                    if (isNaN(valNum)== true){valNum = 0;}
                    if (isNaN(valAmount) == true){valAmount = 0;}
                    if (isNaN(valTax) == true){valTax = 0;}
                    if (isNaN(valMurni) == true){valMurni = 0;}
                    
                    TotalGross += Math.round(valNum * 100) / 100;
                    TotalAmount += Math.round(valAmount * 100) / 100;
                    TotalTaxAmount += Math.round(valTax * 100) / 100;
                    valTotalMurni += valMurni
                }
                else
                {
                    gridNum = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblGrossTotal");
                    gridTtlAmount = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblTotalAmount");
                    gridTtlTaxAmount = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblTaxAmount");
                    gridNetTotal = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblTotalNetAmount");
                    gridMurni = document.getElementById(idPrefName + idPredNum.substring(idPredNum.length - 2,idPredNum.length)+"_lblGross");
                    TotalGross = Math.round((parseFloat(TotalGross) * 100)) / 100;
                    TotalAmount = Math.round((parseFloat(TotalAmount) * 100)) / 100;
                    TotalTaxAmount = Math.round((parseFloat(TotalTaxAmount) * 100)) / 100;
                    
                    gridNum.value = Math.round(valTotalMurni*100)/100;
                    gridTtlAmount.value = CommaFormatted(CurrencyFormatted(Math.floor(TotalAmount)));
                    gridTtlTaxAmount.innerText = CommaFormatted(CurrencyFormatted(Math.round(TotalTaxAmount*100)/100));
                    gridNetTotal.innerText = CommaFormatted(CurrencyFormatted(Math.round((TotalAmount - TotalTaxAmount)*100)/100));


                }
            }     
        }
function ddlChange(val)
{
    if(val != 0)
    {
        var policyFee;var OtherFee;var AdminFee;var AdminFeeProcent;var OTR;var stdPremi; var PremiCredit;var PolFeeCredit;var tjh;
        
        premiCredit = document.getElementById("txtPremiCredit").value;
        policyFee = document.getElementById("txtPolicyFeeCash").value;
        OtherFee = document.getElementById("txtOtherFeeCash").value;
        PolFeeCredit = document.getElementById("txtPolicyFeeCredit").value;
        tjh = document.getElementById("txttjh").value;
        AdminFee = parseFloat(policyFee.replace(/,/gi,"")) + parseFloat(OtherFee.replace(/,/gi,""))+ parseFloat(premiCredit.replace(/,/gi,""))+ parseFloat(PolFeeCredit.replace(/,/gi,""))- parseFloat(tjh.replace(/,/gi,""));
        OTR = document.getElementById("txtOTR").value;
        AdminFeeProcent = AdminFee / parseFloat(OTR.replace(/,/gi,""));
        document.getElementById("txtAdminFee").value = CommaFormatted(CurrencyFormatted(AdminFee));
        document.getElementById("txtAdmFeePercen").value = CommaFormatted(CurrencyFormatted4(AdminFeeProcent*100)) + " %";
        stdPremi = document.getElementById("txtStdPremi").value;
        document.getElementById("txtPremiCust").value = CommaFormatted(CurrencyFormatted(parseFloat(stdPremi.replace(/,/gi,"")) + AdminFee));
        if(parseFloat(document.getElementById("lblMaxRefund").innerText) > parseFloat(document.getElementById("ddlRecalc").value))
        {
            document.getElementById("lblMaxRefund").innerText = document.getElementById("ddlRecalc").value;
        }
        else
        {
            window.alert("Calculate Refund Procentage Cannot Bigger Than Max Refund Procentage");
        }
    }
}