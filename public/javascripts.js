  $(document).ready(function(){
      $(".icon-long-arrow-right").click(function() {
      if ($("h1").length) {
          $("h1").replaceWith("<h1> Samobor - Zagreb </h1>");
      }
      else {
         $(".direction").append("<h1> Samobor - Zagreb </h1>");
       } 
  		$(".img-bus").remove();
      $(".col-arr").append(" <img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
      $( ".img-bus" ).animate({ "left": "+=370px" }, "slow" );
  		$(".img-bus").fadeOut();
  		$(".col-arr").append(" <img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
});

	  $(".icon-long-arrow-left").one("click", function() {
    });
    $( ".icon-long-arrow-left" ).click(function(){
        if ($("h1").length) {
       $("h1").replaceWith("<h1> Zagreb - Samobor </h1>");
      }
      else {
      $(".direction").append("<p> Zagreb - Samobor </h1>");
      }
    $(".img-bus").remove();
		$(".col-arr").append(" <img class='img-bus img-flipped' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
		$(".img-bus").animate({ "left": "-=390px" }, "slow" );
		$(".img-bus").fadeOut();
	  $(".col-arr").append("<img class='img-bus img-flipped' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
});
    });