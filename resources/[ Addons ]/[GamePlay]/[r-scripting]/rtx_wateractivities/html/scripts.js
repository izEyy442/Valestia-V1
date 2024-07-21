var wateractivityresourcename = "rtx_wateractivities";

function closeMain() {
	$("body").css("display", "none");
}

function openMain() {
	$("body").css("display", "block");
}

$(".closescooterbuy").click(function(){
	$.post('https://'+wateractivityresourcename+'/closescooter', JSON.stringify({}));
});

window.addEventListener('message', function (event) {

	var item = event.data;
	if (item.message == "infonotifyshow") {
		document.getElementsByClassName("infonotifytext")[0].innerHTML = item.infonotifytext;
		openMain();
		$("#infonotifyshow").show();	
	}
	
	if (item.message == "attractionshow") {
		openMain();	
		$("#attractionshow").show();
	}		

	if (item.message == "hideattraction") {
		$("#attractionshow").hide();	
	}		

	if (item.message == "hide") {
		$("#infonotifyshow").hide();	
	}	
	
	if (item.message == "scooterbuyshow") {
		openMain();
		var inputhandler = document.getElementById("scootertimesliderdata");
		inputhandler.setAttribute("max", item.scootermaxminutesdata);	
		inputhandler.setAttribute("min", item.scooterminminutesdata);	
		$("#scootertimesliderdata").val(item.scooterminminutesdata); 
		document.getElementById("scootertimeminutedata").innerHTML = item.scooterminminutesdata;
		document.getElementById("scooterpricedata").innerHTML = item.scooterpricedata;
		$("#scootercarmainshow").hide();
		$("#scooterbuyshow").show();		
	}	
	
	if (item.message == "scooterbuyupdateprice") {
		document.getElementById("scooterpricedata").innerHTML = item.scooterpricedata;	
	}	

	if (item.message == "scootershow") {
		openMain();
		document.getElementById("scootercarleavetextkey").innerHTML = item.scooterleavekeydata;
		$("#scooterbuyshow").hide();
		$("#scootercarmainshow").show();		
	}	
	
	if (item.message == "scooterupdatetime") {
		document.getElementById("scootercartimetextdata").innerHTML = item.scootertimedata;	
	}		
	
	if (item.message == "hidescooterpay") {
		$("#scooterbuyshow").hide();	
	}	
	
	if (item.message == "hidescooter") {
		$("#scootercarmainshow").hide();	
	}		
	
	if (item.message == "sandprogressbarshow") {
		document.getElementsByClassName("sandprogressbartext")[0].innerHTML = item.sandprogressbartext;
		$('.sandprogressbarmaincontainerdata').css("width", "0%")	
		$("#sandprogressbarshow").show();	
		openMain();
	}		
		
	if (item.message == "updatesandprogressbar") {
		$('.sandprogressbarmaincontainerdata').css("width", item.progressbardata+"%")
	}	

	if (item.message == "attractionhostshow") {
		openMain();	
		$("#attractionendshow").show();
	}	

	if (item.message == "attractionreactshow") {
		openMain();	
		document.getElementById("attractionreacttextkey").innerHTML = item.reactkeydata;
		$("#attractionreactshow").show();
	}			

	if (item.message == "hideprogress") {
		$("#sandprogressbarshow").hide();	
	}
		
	if (item.message == "hide") {
		$("#infonotifyshow").hide();	
	}
	
	if (item.message == "hidehost") {
		$("#attractionendshow").hide();	
	}	
	
	if (item.message == "hidereact") {
		$("#attractionreactshow").hide();	
	}		
	
	if (item.message == "updateinterfacedata") {
		wateractivityresourcename = item.wateractivityresourcenamedata;
		let root = document.documentElement;
		root.style.setProperty('--color', item.interfacecolordata);	
	}
});

function scootertimesliderupdate(e) {
	document.getElementById("scootertimeminutedata").innerHTML = e.value;
	$.post('https://'+wateractivityresourcename+'/calculatepricescooter', JSON.stringify({
		scooterselectedminutes: e.value
	}));		
}

$(".scooterbuybutton").click(function () {
	$.post('https://'+wateractivityresourcename+'/payforscooter', JSON.stringify({}));
});
