$( function(){
	$("form").keypress( function(e){
		if( e.which == 13 ){
			if( e.target.id == "user_zip3" || e.target.id == "user_zip4" )
				$("input.generate").click();
			else
				$("input#user_submit").click();
		}
	});
});