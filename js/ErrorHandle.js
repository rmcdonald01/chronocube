

function ErrorHandle() {
	this.print = function(msg) {
		$('#console').text(msg)
		$('#console').show()
		setTimeout(function() { 
		   	$('#console').fadeOut(); 
		}, 5000); // 10 seconds
	}
}