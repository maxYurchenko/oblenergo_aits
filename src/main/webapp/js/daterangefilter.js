setTimeout(function(){
    $.fn.dataTableExt.afnFiltering.push(
        function( oSettings, aData, iDataIndex ) {
            var fromDateField = $('#min');
            var toDateField = $('#max');
            var temp;
            temp = $(fromDateField).val().split('.');
            var dateMin = new Date(temp[1]+"/"+temp[0]+"/"+temp[2]);
            temp = $(toDateField).val().split('.');
            var dateMax = new Date(temp[1]+"/"+temp[0]+"/"+temp[2]);
            temp = aData[3].split('.');
            var date = new Date(temp[1]+"/"+temp[0]+"/"+temp[2]);
            if ( dateMin == "" && date <= dateMax){
                return true;
            }
            else if ( dateMin =="" && date <= dateMax ){
                return true;
            }
            else if ( dateMin <= date && "" == dateMax ){
                return true;
            }
            else if ( dateMin <= date && date <= dateMax ){
                return true;
            }
            return false;
        }
    );
}, 100);