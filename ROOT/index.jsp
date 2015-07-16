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
		<link href='http://fonts.googleapis.com/css?family=Cinzel' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Trocchi' rel='stylesheet' type='text/css'>
		
		<script src="numeral.min.js"></script>
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
			ga('create', 'UA-51790964-2', 'auto');
			ga('send', 'pageview');
		</script>
		<script>
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
			<div id="intro">
				<h1>Welcome</h1>
				<p>An analysis of the outcome of the most recent UK general election.</p>
				
					<ul><div id="bullets">
					<%
						Class.forName("org.sqlite.JDBC");
						Connection conn = DriverManager.getConnection("jdbc:sqlite:../webapps/ROOT/WEB-INF/data.db");
						Statement stat = conn.createStatement();
		 
						ResultSet rs1 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM constituencies;");
						rs1.next();
						out.println("<li>" + rs1.getInt("rowcount") + " constituencies.</li>");
						rs1.close();
						
						ResultSet rs2 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM parties;");
						rs2.next();
						out.println("<li>" + rs2.getInt("rowcount") + " parties.</li>");
						rs2.close();
						
						ResultSet rs3 = stat.executeQuery("SELECT sum(total_votes) AS total FROM parties;");
						rs3.next();				
						out.println("<li><script>document.write(numeral(" + rs3.getInt("total") + ").format('0,0'));</script> votes.</li>");
						rs3.close();
		 
						conn.close();
					%>
					<li>1 winner.</li>
					</ul>
				</div>
			</div>
			<div id="news">
				<h2>Recent News</h2>
				<div id="date">16 July 2015</div>
				<p>The site launched today, with all basic features up and running. Only the maps remain to be added.</p>
			</div>
		</main>
		
		<footer>
			This site was created by <a href="http://samireland.com">Sam Ireland</a>, in July 2015. For questions or other enquiries, please tweet <a href="http://twitter.com/Sam_M_Ireland">@Sam_M_Ireland</a>. This project is in no way affiliated with the UK House of Commons or the British government.
		</footer>
	</body>
</html>
	