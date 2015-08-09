/**************************************************************/
/* Prepares the cv to be dynamically expandable/collapsible   */
/**************************************************************/
function prepareList() {
    var show = true;
    $('#expList').find('li:has(ul)')
    .click( function(event) {
        if (this == event.target) {
            if($(this).children().html()!="\n")
                $(this).toggleClass('expanded');
            $(this).children('ul').toggle('medium');
        }
        return false;
    })
    .addClass('collapsed')
    .children('ul').hide();

    //Create the button funtionality
        $('#expandList')
        .click( function() {
    if(show){
            $('.collapsed').addClass('expanded');
            $('.collapsed').children().show('medium');
        show = false;
    }else{
            $('.collapsed').removeClass('expanded');
            $('.collapsed').children().hide('medium');
        show = true;
    }
        })
    
};


/**************************************************************/
/* Functions to execute on loading the document               */
/**************************************************************/
$(document).ready( function() {
    prepareList()
});