
window.onload = function() {
	var tbody = document.getElementById("votes");
	var row;
	var party;
	var votes;
	var percentage;
	var change;
	
	var total_votes = 0
	for (var i=0;i<window.votes.length;i++) {
		total_votes += window.votes[i]["votes"];
	}
	
	for (var i=0;i<window.votes.length;i++) {
		row = document.createElement("tr");
		party = document.createElement("td");
		party.className = "first"
		party.innerHTML = window.votes[i]["party"];
		votes = document.createElement("td");
		votes.innerHTML = numeral(window.votes[i]["votes"]).format("0,0");
		percentage = document.createElement("td");
		percentage.innerHTML = Math.round(((window.votes[i]["votes"]/total_votes) * 1000))/10 + "%";
		change = document.createElement("td");
		change.innerHTML = window.votes[i]["change"] + "%";
		
		row.appendChild(party);
		row.appendChild(votes);
		row.appendChild(percentage);
		row.appendChild(change);
		tbody.appendChild(row);
	}
	
	var totals = document.createElement("tr");
	totals.style.fontWeight = "bold";
	party = document.createElement("td");
	party.className = "first"
	party.innerHTML = "Total:";
	votes = document.createElement("td");
	votes.innerHTML = total_votes;
	percentage = document.createElement("td");
	percentage.innerHTML = "";
	change = document.createElement("td");
	change.innerHTML = "";
	
	totals.appendChild(party);
	totals.appendChild(votes);
	totals.appendChild(percentage);
	totals.appendChild(change);
	tbody.appendChild(totals);
	
	document.getElementById("total_votes").innerHTML = numeral(total_votes).format("0,0");
	document.getElementById("electorate").innerHTML = numeral(Math.round(total_votes / (parseFloat(document.getElementById("turnout").innerHTML.slice(0,-1))/100))).format("0,0");
};