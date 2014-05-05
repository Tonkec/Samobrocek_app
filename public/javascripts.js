  $(document).ready(function(){
  	  $( ".right" ).click(function() {
  		$(".img-bus").remove();
      $(".col-arr").append(" <img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");
      $( ".img-bus" ).animate({ "left": "+=370px" }, "slow" );
  		$(".img-bus").fadeOut();
  		$(".col-arr").append(" <img class='img-bus' src='http://www.clker.com/cliparts/B/x/h/S/j/W/yellow-school-bus-hi.png'>");

});


	$( ".left" ).click(function(){
    $(".img-bus").remove();
		$(".col-arr").append(" <img class='img-bus' src='http://imagehost3.online-image-editor.com/images/5222935m8Q5U33Iy5/5222953GudPeMWa.png'>");
		$(".img-bus").animate({ "left": "-=400px" }, "slow" );
		$(".img-bus").fadeOut();
	$(".col-arr").append("<img class='img-bus' src='http://imagehost3.online-image-editor.com/images/5222935m8Q5U33Iy5/5222953GudPeMWa.png'>");
});
    });