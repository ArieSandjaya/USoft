

function ValidatePage(){
    if($('#form1').validationEngine('validate')){
        if(confirm('Submit Data ?')) {
            //window.parent.parent.loadWait();
            
            return true;
        }
    }
    return false;
}
        
function ToggleCheckByClass(state,chkClass) {
    if (state) { $('.'+chkClass+' input').attr('checked', 'checked'); }
    else       { $('.'+chkClass+' input').removeAttr('checked'); }
}