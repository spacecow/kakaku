$( function(){
	if( $("select#user_question").val() == "qalt" )
		$("li#user_alt_question_input").show();
	else
		$("li#user_alt_question_input").hide();
	$("select#user_question").live( "change", function(){
		if( $("select#user_question").val() == "qalt" )
			$("li#user_alt_question_input").show();
		else
			$("li#user_alt_question_input").hide();
	});
});