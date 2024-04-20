document.querySelector("#aptBtn").addEventListener("click", function() {
	let sido = document.querySelector("#sido").value;
	let gugun = document.querySelector("#gugun").value;
	let dong = document.querySelector("#dong").value;
	let year = document.querySelector("#year").value;
	let month = document.querySelector("#month").value;
	
	location.href = "house?act=search&sido="+sido+"&gugun="+gugun+"&dong="+dong+"&year="+year+"&month="+month;
});