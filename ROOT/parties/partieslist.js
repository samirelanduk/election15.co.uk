window.onload = function() {
	//Format all the numbers
	var tbody = document.getElementById("tbody");
	for (var row=0;row<tbody.children.length;row++) {
		tbody.children[row].children[1].innerHTML = numeral(tbody.children[row].children[1].innerHTML).format("0,0");
		if (!(tbody.children[row].children[4].innerHTML == "100.0")) {
			tbody.children[row].children[4].innerHTML = parseFloat(tbody.children[row].children[4].innerHTML).toPrecision(2) + "%";
		} else {
			tbody.children[row].children[4].innerHTML = "100%";
		}
		tbody.children[row].children[5].innerHTML = parseFloat(tbody.children[row].children[5].innerHTML).toPrecision(2) + "%";
		tbody.children[row].children[6].innerHTML = parseFloat(tbody.children[row].children[6].innerHTML).toPrecision(2) + "%";
	}
};

function sortMe(event) {
	//Which column has been clicked?
	var colNum;
	var thead = document.getElementById("thead").children[0];
	for (var i=0;i<thead.children.length;i++) {
		if (thead.children[i].children[0].innerHTML == event.target.innerHTML) {
			colNum = i;
		}
	}
	
	//Sort that column
	var tbody = document.getElementById("tbody")
	var rows = tbody.getElementsByTagName('tr');
	if (colNum == 0) {
		for (var i=0; i<rows.length-1;i++) {
			for (var j=0;j<rows.length-(i+1);j++) {
				if (rows.item(j).getElementsByTagName('td').item(colNum).attributes.value.value > rows.item(j+1).getElementsByTagName('td').item(colNum).attributes.value.value) {
					tbody.insertBefore(rows.item(j+1),rows.item(j));
				}
			}
		}
	} else {
		for (var i=0; i<rows.length-1;i++) {
			for (var j=0;j<rows.length-(i+1);j++) {
				if (parseFloat(rows.item(j).getElementsByTagName('td').item(colNum).attributes.value.value) < parseFloat(rows.item(j+1).getElementsByTagName('td').item(colNum).attributes.value.value)){
					tbody.insertBefore(rows.item(j+1),rows.item(j));
				}
			}
		}
	}
}