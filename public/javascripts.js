  $(document).ready(function(){
    $(".icon-long-arrow-right").click(function() {
      
      if ($("h3").length) {
        $("h3").replaceWith("<h3> Samobor - Zagreb </h3>");
      }
      else {
        $(".direction").append("<h3> Samobor - Zagreb </h3>");
      }

  		$(".img-bus").remove();
      $(".col-bus").append("<img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
      $( ".img-bus" ).animate({ "margin-left": "+=60%" }, "slow" );
  		$(".img-bus").fadeOut();
  		$(".col-bus").append(" <img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
});

    $( ".icon-long-arrow-left" ).click(function(){
      
      if ($("h3").length) {
        $("h3").replaceWith("<h3> Zagreb - Samobor </h3>");
      }
      else {
        $(".direction").append("<h3> Zagreb - Samobor </h3>");
      }

      $(".img-bus").remove();
		  $(".col-bus").append(" <img class='img-bus img-flipped' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
		  $(".img-bus").animate({ "margin-left": "-=60%" }, "slow" );
		  $(".img-bus").fadeOut();
	    $(".col-bus").append("<img class='img-bus img-flipped' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
});
    });