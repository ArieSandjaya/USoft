function CurrencyFormatted(amount)
{
	var i = Math.round(parseFloat(amount) * 100) / 100;
	if(isNaN(i)) { i = 0.00; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	i = parseInt((i + .0005) * 1000);
	i = i / 1000;
	s = new String(i);
	if(s.indexOf('.') < 0) { s += '.00'; }
	if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
	s = minus + s;
	return s;
} // function CurrencyFormatted()
function CurrencyFormatted4(amount)
{
	var i = (parseFloat(amount) * 100) / 100;
	if(isNaN(i)) { i = 0.00; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	i = parseInt((i + .0005) * 1000);
	i = i / 1000;
	s = new String(i);
	if(s.indexOf('.') < 0) { s += '.0000'; }
	if(s.indexOf('.') == (s.length - 2)) { s += '000'; }
	s = minus + s;
	return s;
} // function CurrencyFormatted()

function CommaFormatted(amount)
{
	var delimiter = ",";
	var a = amount.split('.',2)
	var d = a[1];
	var i = parseInt(a[0]);
	if(isNaN(i)) { return ''; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	var n = new String(i);
	var a = [];
	while(n.length > 3)
	{
		var nn = n.substr(n.length-3);
		a.unshift(nn);
		n = n.substr(0,n.length-3);
	}
	if(n.length > 0) { a.unshift(n); }
	n = a.join(delimiter);
	if(d.length < 1) { amount = n; }
	else { amount = n + '.' + d; }
	amount = minus + amount;
	return amount;
} 
function RemoveFormat(id,amount)
{
    var amt;
    amt = parseFloat(amount.replace(/,/gi,""));
    document.getElementById(id).value = amt;
}

function formatNumber(input){
    var val = input.value;
    
    if(val.charAt(val.length-1) != ".") {
        val = parseFloat(val.replace(/,/g , ""));
    }
    
    if(isNaN(val)) { val = ''; }
    else {
        var nStr = val + '';
        nStr = nStr.replace( /\,/g, "");
        var x = nStr.split( '.' );
        var x1 = x[0];
        var x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while ( rgx.test(x1) ) {
            x1 = x1.replace( rgx, '$1' + ',' + '$2' );
        }
        input.value = x1 + x2;
    }
}