<%@ page contentType="text/html" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<!doctype html>

<html>
	<head>
		<title>Election '15 - A look at the 2015 UK election</title>
		
		<meta charset="utf-8">
		<meta name="author" content="Sam Ireland">

		<link rel="stylesheet" type="text/css" href="/main.css">
		<link rel="stylesheet" type="text/css" href="simulations.css">
		<link href='http://fonts.googleapis.com/css?family=Cinzel' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Trocchi' rel='stylesheet' type='text/css'>
		
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
			ga('create', 'UA-51790964-2', 'auto');
			ga('send', 'pageview');
		</script>
		<script>
		<%
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:../webapps/ROOT/WEB-INF/data.db");
            Statement stat = conn.createStatement();
 
			ResultSet rs = stat.executeQuery("SELECT name, results_json, nation FROM constituencies;");
			String json = "window.votes = [";
			while (rs.next()) {
				json += ("{'name':'" + rs.getString("name") + "', 'regions':['UK','" + rs.getString("nation") + "'], 'results':" + rs.getString("results_json") + "},");
			}
			json = json.substring(0, json.length()-1) + "];";
			out.print(json);
            conn.close();
        %>
		window.alternate = JSON.parse(JSON.stringify(window.votes));
		</script>
		<script src="../numeral.min.js"></script>
		<script src="simulations.js"></script>
		
	</head>
	
	<body>
		<header>
			<img src="/crown.gif" width="200px" height="200px">
			The UK 2015 Election
		</header>
		
		<nav>
			<span><a href="/">Home</a></span>
			<span><a href="/simulations/">Simulations</a></span>
			<span><a href="/constituencies/">Constituencies</a></span>
			<span><a href="/parties/">Parties</a></span>
			<span><a href="/about/">About</a></span>
		</nav>
		
		<main>
			<h1>The Election Simulator</h1>
			<p>This tool allows you to re-run the 2015 UK general election, exploring what the outcome would be if people's voting patterns had been different.</p>
			<p>Define one or more changes to the original run below, and click 'simulate' to produce the result.</p>
			
			<div id="controls">
				<h2>Controls</h2>
				
				<div id="buttons">
					<input type="submit" value="Another rule" onclick="add_control()">&nbsp;<input type="submit" value="Simulate" onclick="simulate()">
				</div>
			</div>
			
			<div id="commons">
				<h2>The Result</h2>
				<div id="seats">
					<table id="seats-t">
					</table>
				</div>
				<br><br>
				<div id="votes">
					<table id="votes-t">
					</table>
				</div>
			</div>
			
			<!--<div id="map_container">
				<h2>Constituency Map</h2>
				<canvas width="960" height="1076" id="map">
			</div>-->
		</main>
		
		<footer>
			This site was created by <a href="http://samireland.com">Sam Ireland</a>, in July 2015. For questions or other enquiries, please tweet <a href="http://twitter.com/Sam_M_Ireland">@Sam_M_Ireland</a>. This project is in no way affiliated with the UK House of Commons or the British government.
		</footer>
	</body>
</html>
	