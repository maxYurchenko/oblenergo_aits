/**************************************************************/
/* Prepares the cv to be dynamically expandable/collapsible   */
/**************************************************************/
function prepareList() {
    var show = true;
    $('#expList').find('li:has(ul)')
    .click( function(event) {
        if (this == event.target) {
            $('#expandList').val('Згорнути');
            show = false;
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
            if(isSort==1) {
                $('.docsList #expList').html($('#hiddenMenu #expList').html());
                isSort=0; 
                show=false;
                prepareList(); 
                $('#descRadion').attr('checked',false);
                $('#ascRadion').attr('checked',false);
            }
            if(show){
                    $('.collapsed').addClass('expanded');
                    $('.collapsed').children().show('medium');
                    $(this).val('Згорнути');
                show = false;
            }else{
                    $('.collapsed').removeClass('expanded');
                    $('.collapsed').children().hide('medium');
                    $(this).val('Розгорнути');
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