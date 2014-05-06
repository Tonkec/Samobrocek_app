  $(document).ready(function(){
      $(".right").click(function() {
      if ($("h1").length) {
          $("h1").replaceWith("<h1> Samobor - Zagreb </h1>");
      }
      else {
         $(".panel-heading").append("<h1> Samobor - Zagreb </h1>");
       } 
  		$(".img-bus").remove();
      $(".col-arr").append(" <img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
      $( ".img-bus" ).animate({ "left": "+=370px" }, "slow" );
  		$(".img-bus").fadeOut();
  		$(".col-arr").append(" <img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
});

	  $(".left").one("click", function() {
    });
    $( ".left" ).click(function(){
        if ($("h1").length) {
       $("h1").replaceWith("<h1> Zagreb - Samobor </h1>");
      }
      else {
      $(".panel-heading").append("<p> Zagreb - Samobor </h1>");
      }
    $(".img-bus").remove();
		$(".col-arr").append(" <img class='img-bus img-flipped' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
		$(".img-bus").animate({ "left": "-=400px" }, "slow" );
		$(".img-bus").fadeOut();
	  $(".col-arr").append("<img class='img-bus img-flipped' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
});
    });