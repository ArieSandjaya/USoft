function calcSisa15(id)
{
    var idPref;
    var NetTotal;var Tax;var Amount;var TotalNet;var TotalTax;var TotalAmount;var taxProcent;var TotalTaxProcent;
    var grid;var TempNet;var TempTax;var TempAmount;var TempTaxProcen;var NettProcent;
    var gridSisa;var idPrefSisa;var gridTotal;
    var idPrefTotal;var otr;var strSisa;

    //idPref = parseFloat(id.substring(14,16)) - 1 ;
    //idPrefTotal = "gViewTotal" + id.substring(10,17);
    //idPrefSisa = "gViewTotalSisa" + id.substring(10,17);
    idPref = parseFloat(id.substring(21,23)) - 1 ;
    idPrefTotal = "tc_tp1_gViewTotal" + id.substring(17,24);
    idPrefSisa = "tc_tp1_gViewTotalSisa" + id.substring(17,24);
    grid = document.getElementById("tc_tp1_gViewTotal25");
    gridTotal = document.getElementById("tc_tp1_gViewTotal");
    NettProcent = parseFloat(document.getElementById("txtRefundPercen").value);
    NetTotal = (document.getElementById(idPrefTotal + "lblNetAmountTotal").value).replace(/,/gi,"") - (grid.rows[idPref].cells[13].innerText).replace(/,/gi,"");
    Tax = (document.getElementById(idPrefTotal + "lblTaxAmountTotal").value).replace(/,/gi,"") - (grid.rows[idPref].cells[12].innerText).replace(/,/gi,"");
    Amount = (document.getElementById(idPrefTotal + "lblAmountTotal").value).replace(/,/gi,"") - (grid.rows[idPref].cells[11].innerText).replace(/,/gi,"");
    gridSisa = document.getElementById("tc_tp1_gViewTotalSisa");
    document.getElementById(idPrefSisa + "lblGrossgViewTotal25");
    if (gridSisa != null)
    {
    
    if(Amount > 0)
    {
        gridSisa.rows[idPref].cells[12].innerText = CommaFormatted(CurrencyFormatted(Tax));
        gridSisa.rows[idPref].cells[11].innerText = CommaFormatted(CurrencyFormatted(Amount));
        gridSisa.rows[idPref].cells[13].innerText = CommaFormatted(CurrencyFormatted(NetTotal));
    }
    else
    {
        gridSisa.rows[idPref].cells[12].innerText = CommaFormatted(CurrencyFormatted(0));
        gridSisa.rows[idPref].cells[11].innerText = CommaFormatted(CurrencyFormatted(0));
        gridSisa.rows[idPref].cells[13].innerText = CommaFormatted(CurrencyFormatted(0));
    }

    TotalNet = 0;
    TotalTax = 0;
    TotalAmount = 0;
    TotalTaxProcent = 0;
    TempNet = 0;
    TempTax = 0;
    TempAmount = 0;
    TotalTaxProcent = 0;
    for(i=1;i<= gridSisa.rows.length-2;i++)
    {
        TempNet = parseFloat((gridSisa.rows[i].cells[13].innerText).replace(/,/gi,""));
        TempTax = parseFloat((gridSisa.rows[i].cells[12].innerText).replace(/,/gi,""));
        TempAmount = parseFloat((gridSisa.rows[i].cells[11].innerText).replace(/,/gi,""));
        TempTaxProcen = parseFloat((gridSisa.rows[i].cells[2].innerText).replace(/,/gi,""));
        if (isNaN(TempNet)== true){TempNet = 0;}
        if (isNaN(TempTax)== true){TempTax = 0;}
        if (isNaN(TempAmount)== true){TempAmount = 0;}
        if (isNaN(TempTaxProcen)== true){TempTaxProcen = 0;}
        TotalNet += TempNet;
        TotalTax += TempTax;
        TotalAmount += TempAmount;
        TotalTaxProcent += TempTaxProcen;
    }
    gridSisa.rows[gridSisa.rows.length - 1].cells[13].innerText = CommaFormatted(CurrencyFormatted(TotalNet));
    gridSisa.rows[gridSisa.rows.length - 1].cells[12].innerText = CommaFormatted(CurrencyFormatted(TotalTax));
    gridSisa.rows[gridSisa.rows.length - 1].cells[11].innerText = CommaFormatted(CurrencyFormatted(TotalAmount));
    gridSisa.rows[gridSisa.rows.length - 1].cells[2].innerText = CommaFormatted(CurrencyFormatted(TotalTaxProcent));
    document.getElementById("tc_tp1_lblTotalAB").innerText =  CommaFormatted(CurrencyFormatted(Math.floor(parseFloat((grid.rows[grid.rows.length - 1].cells[11].innerText).replace(/,/gi,"")) + TotalAmount)));
    document.getElementById("tc_tp1_lblTotalTaxAB").innerText =  CommaFormatted(CurrencyFormatted(parseFloat((grid.rows[grid.rows.length - 1].cells[12].innerText).replace(/,/gi,"")) + TotalTax));
    document.getElementById("tc_tp1_lblTotalNetAB").innerText =  CommaFormatted(CurrencyFormatted(parseFloat((grid.rows[grid.rows.length - 1].cells[13].innerText).replace(/,/gi,"")) + TotalNet));

    for(i=1;i<= gridSisa.rows.length-1;i++)
    {
        strSisa = "tc_tp1_gViewTotalSisa_ctl0" + parseInt(i+1) + "_lblGrossMurniTotal25";
        gridSisa.rows[i].cells[2].innerText = CommaFormatted(CurrencyFormatted((parseFloat((gridSisa.rows[i].cells[11].innerText).replace(/,/gi,"")) / TotalAmount) * (NettProcent - 25)));
        if(i < gridSisa.rows.length-1)
        {
        document.getElementById(strSisa).value = (parseFloat((gridSisa.rows[i].cells[11].innerText).replace(/,/gi,"")) / TotalAmount) * (NettProcent - 25);
        }
    }
    }
}