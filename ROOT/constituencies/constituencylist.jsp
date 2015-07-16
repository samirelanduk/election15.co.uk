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
			<h1>Constituencies</h1>
			
			<table>
				<thead>
					<th class="first">Name</th>
					<th>2015 Winner</th>
					<th>2010 Winner</th>
					<th>Nation</th>
					<th>Turnout</th>
				</thead>
				<tbody>
<%
					String nation;
					if ("England".equals(request.getParameter("nation")) || "Scotland".equals(request.getParameter("nation")) || "Wales".equals(request.getParameter("nation")) || "Northern Ireland".equals(request.getParameter("nation"))) {
						nation = request.getParameter("nation");
					} else {
						nation = "all";
					}
					Class.forName("org.sqlite.JDBC");
					Connection conn = DriverManager.getConnection("jdbc:sqlite:../webapps/ROOT/WEB-INF/data.db");
					Statement stat = conn.createStatement();
	 
					ResultSet rs;
					if (nation == "all") {
						rs = stat.executeQuery("SELECT name, turnout, winner_2015, winner_2010, nation FROM constituencies;");
					} else {
						rs = stat.executeQuery("SELECT name, turnout, winner_2015, winner_2010, nation FROM constituencies WHERE nation='" + nation + "';");
					}
					
					while (rs.next()) {
						out.println(String.format("\t\t\t\t\t<tr><td class='first'><a href='constituency.jsp?name=%s'>%s</a></td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", rs.getString("name"), rs.getString("name"), rs.getString("winner_2015"), rs.getString("winner_2010"), rs.getString("nation"), rs.getString("turnout") + "%"));
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
	