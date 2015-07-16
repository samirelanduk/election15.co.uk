//JavaScript for the Alternative Election Simulator

window.onload = function() {
	//Add one rule block
	add_control();
	
	updateCommons();
	
} //End window.onload

//Function to add another 'rule' to fill in.
function add_control() {
	var controls = document.getElementById("controls");
	var options = "<option selected disabled hidden value=''></option><option value='Labour'>Labour</option><option value='Conservative'>Conservative</option><option value='Liberal Democrat'>Liberal Democrat</option><option value='UKIP'>UKIP</option><option value='Green Party'>Green</option><option value='Scottish National Party'>SNP</option><option value='Plaid Cymru'>Plaid Cymru</option><Option value='Democratic Unionist Party'>DUP</option><Option value='Social Democratic & Labour Party'>SDLP</option><Option value='Sinn Fein'>Sinn Fein</option><Option value='Ulster Unionist Party'>UUP</option>";
	var change = document.createElement("div");
	change.className = "change";
	change.style.fontSize = "80%";
	change.innerHTML = 'If <input type="text" name="percent" style="width:22px;" autocomplete="off">% of <select name="original">' + options + '</select> voters voted for <select name="new">'+ options + '</select> in <select name="region"><option value="UK">All UK</option><option value="england">England</option><option value="scotland">Scotland</option><option value="wales">Wales</option><option value="Northern Ireland">Northern Ireland</option></select> ...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 70%" onclick=deleteMe(event)><a href="javascript:void;">Remove</a></span>';
	controls.insertBefore(change, document.getElementById("buttons"));
}

//Function to delete the parent element - used to remove rules.
function deleteMe(event) {
	document.getElementById("controls").removeChild(event.target.parentNode.parentNode);
}

//Function to determine the winner in a constituency
function checkWinner(constituency) {
	var results = constituency["results"];
	var top = 0;
	var winner = "";
	for (var j=0;j<results.length;j++) {
		if (results[j]["votes"] > top) {
			top = results[j]["votes"];
			winner = results[j]["party"];
		}
	}
	return winner;
}

//Function to sort a Commons table
function sortNtotal(table) {
	var rows = table.getElementsByTagName('tbody').item(0).getElementsByTagName('tr');
	//Re-order the table
	for (var i=0; i<rows.length-1;i++) {
        for (var j=0;j<rows.length-(i+1);j++) {
            if (parseInt(rows.item(j).getElementsByTagName('td').item(1).innerHTML) < parseInt(rows.item(j+1).getElementsByTagName('td').item(1).innerHTML)){
                table.getElementsByTagName("tbody").item(0).insertBefore(rows.item(j+1),rows.item(j));
            }
        }
    }
	//Put other at the end
	var other = 0;
	for (var i=0; i<rows.length;i++) {
		if (rows.item(i).getElementsByTagName('td').item(0).innerHTML == "Other") {
			other = rows.item(i).innerHTML;
			table.getElementsByTagName('tbody').item(0).removeChild(rows.item(i));
		}
	}
	new_other = document.createElement("tr");
	new_other.innerHTML = other;
	table.getElementsByTagName('tbody').item(0).appendChild(new_other);
	//Put total in
	total_row = document.createElement("tr");
	total_row.style.fontWeight = "bold";
	total = 0;
	rows = table.getElementsByTagName('tbody').item(0).getElementsByTagName('tr');
	for (var i=0; i<rows.length;i++) {
		total = total + parseInt(rows.item(i).getElementsByTagName('td').item(1).innerHTML);
	}
	td1 = document.createElement("td");
	td1.innerHTML = "Totals";
	td1.className = "party_name";
	td2 = document.createElement("td");
	td2.className = "num_cell";
	td2.innerHTML = total;
	total_row.appendChild(td1)
	total_row.appendChild(td2)
	table.getElementsByTagName('tbody').item(0).appendChild(total_row);
	//Put commas in
	for (var i=0; i<rows.length;i++) {
		rows.item(i).getElementsByTagName('td').item(1).innerHTML = numeral(rows.item(i).getElementsByTagName('td').item(1).innerHTML).format("0,0");
	}
}

//Get appropriate party color
function getColor(name) {
	d = {"Conservative": "#00F", "Labour": "#F00", "Liberal Democrat": "#FC0", "UKIP": "#B3009D", "Green Party": "#0F0", "Scottish National Party": "#FF0", "Plaid Cymru": "#6C3", "Democratic Unionist Party": "#C30", "Ulster Unionist Party": "#99F", "Sinn Fein": "#060;", "Social Democratic & Labour Party": "#3C3"};
	if (name in d) {
		return d[name];
	} else {
		return "#C0C0C0";
	}
}

//Get proper width of a bar
function getWidth(val, max) {
	width = Math.ceil((val/max)*400);
	if (width == 0) {
		return 1;
	} else {
		return width;
	}
}

//Function to update the Commons charts
function populateCommonsTable(table, name, results, max) {
	head = document.createElement("tr");
	head_td = document.createElement("td")
	head_td.colSpan='3';
	head_td.innerHTML = name;
	head_td.className = 'table_head'
	head.appendChild(head_td);
	tbody = document.createElement("tbody");
	for (i=0;i<Object.keys(results).length;i++) {
		var row = document.createElement("tr");
		var td1 = document.createElement("td");
		td1.className = "party_name";
		td1.innerHTML = Object.keys(results)[i];
		var td2 = document.createElement("td");
		td2.className = "num_cell";
		td2.innerHTML = results[Object.keys(results)[i]];
		var td3 = document.createElement("td");
		td3.innerHTML = "<div class='bar' style='background-color:" + getColor(Object.keys(results)[i]) + "; height:15px; width:" + getWidth(parseInt(results[Object.keys(results)[i]]),max) + "px;'></div>";
		row.appendChild(td1);
		row.appendChild(td2);
		row.appendChild(td3);
		tbody.appendChild(row)
	}
	table.appendChild(head);
	table.appendChild(tbody);
	sortNtotal(table);
}

//Function to update the Commons
function updateCommons() {
	var results = {"Conservative":0, "Labour":0, "Liberal Democrat":0, "UKIP":0, "Green Party":0, "Scottish National Party":0, "Plaid Cymru": 0, "Democratic Unionist Party": 0, "Social Democratic & Labour Party":0, "Sinn Fein": 0, "Ulster Unionist Party": 0, "Other": 0};
	var votes = {"Conservative":0, "Labour":0, "Liberal Democrat":0, "UKIP":0, "Green Party":0, "Scottish National Party":0, "Plaid Cymru": 0, "Democratic Unionist Party": 0, "Social Democratic & Labour Party":0, "Sinn Fein": 0, "Ulster Unionist Party": 0, "Other": 0};

	var seatsTable = document.getElementById("seats-t");
	var votesTable = document.getElementById("votes-t");
	seatsTable.innerHTML = "";
	votesTable.innerHTML = "";
	
	for (i=0;i<window.alternate.length;i++) {
		winner = checkWinner(window.alternate[i]);
		if (winner in results) {
			results[winner]++;
			for (var r=0;r<window.alternate[i]["results"].length;r++) {
				if (window.alternate[i]["results"][r]["party"] in votes) {
					votes[window.alternate[i]["results"][r]["party"]] = votes[window.alternate[i]["results"][r]["party"]] + window.alternate[i]["results"][r]["votes"];
				} else {
					votes["Other"] = votes["Other"] + window.alternate[i]["results"][r]["votes"];
				}
			}
		} else {
			results["Other"]++;
		}
	}
	//Maximums are unfortunately hardcoded - should change really
	populateCommonsTable(seatsTable, "Seats", results, 650);
	populateCommonsTable(votesTable, "Votes", votes, 30000000);
}

//Function to check if a party stood in a given constituency
function checkInConstituency(party, results) {
	contained = false;
	for (x=0;x<results.length;x++) {
		if (party == results[x]["party"]) {
			contained = true;
			break;
		}
	}
	return contained;
}

//Is there a warning in place already?
function check_warning() {
	if (document.getElementById("commons").firstChild.tagName == "p" || document.getElementById("commons").firstChild.tagName == "P") {
		return true;
	} else {
		return false;
	}
}

//Is a piece of text a number that can be used in calculations?
function isNumeric(input) {
    return (input - 0) == input && (''+input).trim().length > 0;
}

//Validate inputs to make sure the user isn't up to any Tomfoolery
function inputs_fine(data) {
	var parties = [];
	for (var i=0;i<data.length;i++) {
		//Check numerical inputs
		if (isNumeric(data[i][0]) == false) {
			if (check_warning() == false) {
				var warning = document.createElement("p");
				warning.style.fontSize = "50%";
				warning.style.color = "#BB0000";
				warning.innerHTML = "Non-numerical inputs detected";
				var commons = document.getElementById("commons");
				commons.insertBefore(warning, commons.firstChild);
			}
			return false;
		}
		
		//Check party names specified
		if (data[i][1] == "" || data[i][2] == "") {
			if (check_warning() == false) {
				var warning = document.createElement("p");
				warning.style.fontSize = "50%";
				warning.style.color = "#BB0000";
				warning.innerHTML = "One or more parties left blank";
				var commons = document.getElementById("commons");
				commons.insertBefore(warning, commons.firstChild);
			}
			return false;
		}
		if (!(parties.indexOf(data[i][1]) > -1)) {
			parties.push(data[i][1]);
		}
	}

	//Check things don't come to more than 100%
	for (i=0;i<parties.length;i++) {
		var vote_total = 0
		for (var j=0;j<data.length;j++) {
			if (data[j][1] == parties[i]) {
				vote_total = vote_total + data[j][0];
			}
		}
		if (vote_total > 100) {
			if (check_warning() == false) {
				var warning = document.createElement("p");
				warning.style.fontSize = "50%";
				warning.style.color = "#BB0000";
				warning.innerHTML = parties[i] + " vote adds up to more than 100%";
				var commons = document.getElementById("commons");
				commons.insertBefore(warning, commons.firstChild);
			}
			return false;
		}
	}
			
	
	return true;	
}

//Simulate!
function simulate() {
	if (check_warning()) {
		document.getElementById("commons").removeChild(document.getElementById("commons").firstChild);
	}
	window.alternate = [];
	
	//Get the rules specified
	var changes_html = document.getElementById("controls").children;
	var changes = [];
	for (i=1;i<changes_html.length-1;i++) {
		changes.push([parseFloat(changes_html[i].children[0].value), changes_html[i].children[1].value, changes_html[i].children[2].value, changes_html[i].children[3].value]);
	}

	if (inputs_fine(changes)) {
		for (i=0;i<window.votes.length;i++) {
			//Get the original votes
			var results = JSON.parse(JSON.stringify(window.votes[i]["results"]));
			var new_results = JSON.parse(JSON.stringify(results));
			
			//Apply each rule and create new voting data
			for (r=0;r<changes.length;r++) {
				//Can this transfer happen here?
				if (checkInConstituency(changes[r][1], results) && checkInConstituency(changes[r][2], results) && (changes[r][3] == window.votes[i]["regions"][0] || changes[r][3] == window.votes[i]["regions"][1])) {
					//Yes, so work out what needs to be transferred (from ORIGINAL DATA)
					var transfer = 0;
					for (y=0;y<results.length;y++) {
						if (results[y]["party"] == changes[r][1]) {
							transfer = Math.floor((changes[r][0]/100) * parseInt(results[y]["votes"]));
						}
					}
					//Now make that transfer
					for (y=0;y<new_results.length;y++) {
						if (new_results[y]["party"] == changes[r][1]) {
							new_results[y]["votes"] = (new_results[y]["votes"] - transfer);
						} else if (new_results[y]["party"] == changes[r][2]) {
							new_results[y]["votes"] = (new_results[y]["votes"] + transfer);
						}
					}
				}
			}
			var constituency = {"name":window.votes[i]["name"], "id":window.votes[i]["id"], "results": new_results};
			window.alternate.push(constituency);
		}

		updateCommons();
	}
}