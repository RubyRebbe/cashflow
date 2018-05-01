// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready( function() {
  $('select[name="item[recurrence]"').change(function(){
    if ($(this).val() == "ordinary") {
        // alert("select ordinary item");
				$("div#ordinary").css( "display", "inline");
				$("div#recurrent").css( "display", "none");
				$("div#week_day").css( "display", "none");
    } else if ( $(this).val() == "by month day" ) {
        // alert( "recurrent item by month day" ); 
				$("div#ordinary").css( "display", "none");
				$("div#recurrent").css( "display", "inline");
				$("div#week_day").css( "display", "none");
    } else if ( $(this).val() == "by week day" ) {
    		//  alert( "recurrent item by week day" ); 
				$("div#ordinary").css( "display", "none");
				$("div#recurrent").css( "display", "inline");
				$("div#week_day").css( "display", "inline");
    }
  }); 

  $("p.month").click( function() {
    var m = $(this).text().trim();
    $( "table.month#" + m ).toggle();
  });

  $("td.month").click( function() {
    var m = $(this).attr( "id" );
    alert( "month: " + m );
    $( "div.month#" + m ).toggle();
  });
});

// jquery css method
// div style display : none vs. inline or block

