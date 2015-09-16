function Layout() {
	this.scrollbar = document.getElementById("scroll-child");
	this.overflowValue = "3em";
	this.hiddenScrollBars = "yes";

	this.backgrounds = [
	  "url('img/background.jpg') no-repeat center center fixed",
	  "-webkit-linear-gradient(90deg, #f857a6 10%, #ff5858 90%)",
	  "-webkit-linear-gradient(90deg, #00d2ff 10%, #3a7bd5 90%)",
	  "-webkit-linear-gradient(90deg, #673AB7 10%, #512DA8 90%)",
	  "-webkit-linear-gradient(90deg, #fc00ff 10%, #00dbde 90%)",
	  "-webkit-linear-gradient(90deg, #dc2430 10%, #7b4397 90%)"
	];

  	this.backgroundSelected = Data.restoreBackground();
    if (this.backgroundSelected == null || isNaN(this.backgroundSelected)) this.backgroundSelected = 0;

  	this.nextBackground = function() {
	  var newbg = this.backgrounds[ this.backgroundSelected >= this.backgrounds.length-1 ? this.backgroundSelected=0 : ++(this.backgroundSelected) ]
	  this.changeBackground(newbg)
	  Data.saveBackground();
	}

	this.changeBackground = function(bg) {
	  $('body').css({
	    "background": bg,
	    "background-size": "cover"
	  });
	}
	this.changeBackground(this.backgrounds[this.backgroundSelected]) // this has to go after the function declaration to run when the constructor is invoked

	this.toggleScrollBars = function() {
		if (this.hiddenScrollBars==="yes") {
			this.showScrollBars()
		} else {
			this.hideScrollBars()
		}
		this.scrollUp(); this.scrollDown(); // forces the scroll bar to disappear/appear
	}

	this.scrollUp = function() {
	  var scroll = document.getElementById('scroll-child')
	  scroll.scrollTop = 0;
	}

	this.scrollDown = function() {
	  var scroll = document.getElementById('scroll-child')
	  scroll.scrollTop = scroll.scrollHeight;
	}

	this.hideScrollBars = function() {
		this.scrollbar.style.paddingRight = this.overflowValue
		this.hiddenScrollBars = "yes"
	}

	this.showScrollBars = function() {
		this.scrollbar.style.paddingRight = "0em"
		this.hiddenScrollBars = "no"
	}

	this.hideAll = function() {
		var divs = document.getElementsByClassName('hideall')
		for (var d=0; d<divs.length; d++) {
			divs[d].style.transition = 'opacity 0.3s';
			divs[d].style.opacity = 0
		}
	}

	this.showAll = function() {
		var divs = document.getElementsByClassName('hideall')
		for (var d=0; d<divs.length; d++) {
			divs[d].style.transition = 'opacity 0.3s';
			divs[d].style.opacity = 1
		}
	}

	this.showSettings = function() {
		this.hideDownloadOptions()
		document.getElementById('settings').style.transition = "opacity 0.3s";
		document.getElementById('settings').style.opacity = 0.9
	}
	this.hideSettings = function() {
		document.getElementById('settings').style.transition = "opacity 0.3s";
		document.getElementById('settings').style.opacity = 0
	}

	this.hideDownloadOptions = function() {
		document.getElementById('downloadtxt').style.position = 'absolute'
		document.getElementById('downloadcsv').style.position = 'absolute'
		document.getElementById('downloadtxt').style.opacity = 0
		document.getElementById('downloadcsv').style.opacity = 0
	}

	this.showDownloadOptions = function() {
		document.getElementById('downloadtxt').style.position = 'relative'
		document.getElementById('downloadcsv').style.position = 'relative'
		document.getElementById('downloadtxt').style.opacity = 1
		document.getElementById('downloadcsv').style.opacity = 1
	}

	this.toggleSettings = function() {
		if (document.getElementById('settings').style.opacity != 0) {
			this.hideSettings();
		} else {
			this.showSettings();
		}
	}
}