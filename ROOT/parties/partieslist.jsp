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
		
		<script src="partieslist.js"></script>
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
			<h1>Parties</h1>
			
			<table>
				<thead id="thead">
					<th class="first"><a href="javascript:void" onclick=sortMe(event)>Name</a></th>
					<th><a href="javascript:void;" onclick=sortMe(event)>Votes Received</a></th>
					<th><a href="javascript:void" onclick=sortMe(event)>Seats Fought</a></th>
					<th><a href="javascript:void" onclick=sortMe(event)>Seats Won</a></th>
					<th><a href="javascript:void" onclick=sortMe(event)>Victory Rate</a></th>
					<th><a href="javascript:void" onclick=sortMe(event)>% Vote Won</a></th>
					<th><a href="javascript:void" onclick=sortMe(event)>% Seats Won</a></th>
				</thead>
				<tbody id="tbody">
<%
					Class.forName("org.sqlite.JDBC");
					Connection conn = DriverManager.getConnection("jdbc:sqlite:../webapps/ROOT/WEB-INF/data.db");
					Statement stat = conn.createStatement();
	 
					ResultSet rs1;
					rs1 = stat.executeQuery("SELECT SUM(total_votes) AS votes FROM parties;");
					rs1.next();
					int all_votes = rs1.getInt("votes");
					rs1.close();
					
					ResultSet rs2;
					rs2 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM constituencies;");
					rs2.next();
					int seats = rs1.getInt("rowcount");
					rs2.close();
					
					ResultSet rs;
					rs = stat.executeQuery("SELECT * FROM parties;");
					while (rs.next()) {
						out.println(String.format("\t\t\t\t\t<tr><td class='first' value='%s'>%s</td><td value='%s'>%s</td><td value='%s'>%s</td><td value='%s'>%s</td><td value='%s'>%s</td><td value='%s'>%s</td><td value='%s'>%s</td></tr>", rs.getString("name"), rs.getString("name"), rs.getString("total_votes"), rs.getString("total_votes"), rs.getString("seats_fought"), rs.getString("seats_fought"), rs.getString("seats_won"), rs.getString("seats_won"), (rs.getFloat("seats_won") / rs.getFloat("seats_fought")) * 100, (rs.getFloat("seats_won") / rs.getFloat("seats_fought")) * 100, (rs.getFloat("total_votes")/all_votes)*100, (rs.getFloat("total_votes")/all_votes)*100, (rs.getFloat("seats_won")/seats)*100, (rs.getFloat("seats_won")/seats)*100));
					}
					rs.close();
					conn.close();
 
					%>
				</tbody>
			</table>
			<p style="font-style: italic; font-size: 60%; margin-left: 50px;">Source: BBC</i></p>
				
		</main>
		
		<footer>
			This site was created by <a href="http://samireland.com">Sam Ireland</a>, in July 2015. For questions or other enquiries, please tweet <a href="http://twitter.com/Sam_M_Ireland">@Sam_M_Ireland</a>. This project is in no way affiliated with the UK House of Commons or the British government.
		</footer>
	</body>
</html>
	