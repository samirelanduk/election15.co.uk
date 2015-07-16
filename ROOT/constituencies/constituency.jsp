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
		<link rel="stylesheet" type="text/css" href="/list.css">
		<link href='http://fonts.googleapis.com/css?family=Cinzel' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Trocchi' rel='stylesheet' type='text/css'>
		
		<script>
			<%
			Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:../webapps/ROOT/WEB-INF/data.db");
			
			PreparedStatement prep = conn.prepareStatement("SELECT * FROM constituencies WHERE name=?");
			prep.setString(1, request.getParameter("name"));
			ResultSet rs = prep.executeQuery();
			rs.next();
			out.print("window.votes = " + rs.getString("results_json") + ";");
			%>
		</script>
		<script src="constituency.js"></script>
		<script src="../numeral.min.js"></script>
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
			ga('create', 'UA-51790964-2', 'auto');
			ga('send', 'pageview');
		</script>
			
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
			<h1><% out.print(rs.getString("name")); %></h1>
			<table>
				<tr>
					<td class="first">Nation:</td>
					<td class="first"><% out.print(rs.getString("nation"));%></td>
				</tr>
				<tr>
					<td class="first">Winner:</td>
					<td class="first"><% out.print(rs.getString("winner_2015"));%></td>
				</tr>
				<tr>
					<td class="first">Previously held by:</td>
					<td class="first"><% out.print(rs.getString("winner_2010"));%></td>
				</tr>
				<tr>
					<td class="first">Turnout:</td>
					<td class="first" id="turnout"><% out.print(rs.getString("turnout"));%>%</td>
				</tr>
				<tr>
					<td class="first">Electorate:</td>
					<td class="first" id="electorate"></td>
				</tr>
				<tr>
					<td class="first">Votes cast:</td>
					<td class="first" id="total_votes"></td>
				</tr>
			</table>
			
			<h2>Votes</h2>
			<table>
				<thead>
					<th class="first">Party</th>
					<th>Votes</th>
					<th>Percentage</th>
					<th>Change</th>
				</thead>
				<tbody id="votes">
				</tbody>
			</table>
			<p style="font-style: italic; font-size: 60%; margin-left: 50px;">Source: BBC</i></p>
					
			
				
		</main>
		
		<footer>
			This site was created by <a href="http://samireland.com">Sam Ireland</a>, in July 2015. For questions or other enquiries, please tweet <a href="http://twitter.com/Sam_M_Ireland">@Sam_M_Ireland</a>. This project is in no way affiliated with the UK House of Commons or the British government.
		</footer>
	</body>
</html>
	