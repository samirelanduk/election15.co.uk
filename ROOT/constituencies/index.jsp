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
		<link rel="stylesheet" type="text/css" href="/root.css">
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
			<h1>The Constituencies</h1>
			
			<div class="blocks">
				<a href="constituencylist.jsp?nation=England">
				<div class="block" style="background-image:url(england.png);">
					<div>England (<%
					Class.forName("org.sqlite.JDBC");
					Connection conn = DriverManager.getConnection("jdbc:sqlite:../webapps/ROOT/WEB-INF/data.db");
					Statement stat = conn.createStatement();
	 
					ResultSet rs1 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM constituencies WHERE nation='England';");
					rs1.next();
					out.print(rs1.getInt("rowcount"));
					rs1.close();
	 
				%>)</div>
				</div>
				</a>
				<a href="constituencylist.jsp?nation=Scotland">
				<div class="block" style="background-image:url(scotland.png);">
					<div>Scotland (<%
					ResultSet rs2 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM constituencies WHERE nation='Scotland';");
					rs2.next();
					out.print(rs2.getInt("rowcount"));
					rs2.close();
	 
				%>)</div>
				</div>
				</a>
			</div>
			<div class="blocks">
				<a href="constituencylist.jsp?nation=Wales">
				<div class="block" style="background-image:url(wales.png);">
					<div>Wales (<%
					ResultSet rs3 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM constituencies WHERE nation='Wales';");
					rs3.next();
					out.print(rs3.getInt("rowcount"));
					rs3.close();
	 
				%>)</div>
				</div>
				</a>
				<a href="constituencylist.jsp?nation=Northern+Ireland">
				<div class="block" style="background-image:url(northernireland.png);">
					<div>Northern Ireland (<%
					ResultSet rs4 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM constituencies WHERE nation='Northern Ireland';");
					rs4.next();
					out.print(rs4.getInt("rowcount"));
					rs4.close();
				%>)</div>
				</div>
				</a>
			</div>
			<div class="blocks">
				<a href="constituencylist.jsp?nation=All">
				<div class="block" style="background-image:url(uk.png);">
					<div>All constituencies (<%
					ResultSet rs5 = stat.executeQuery("SELECT COUNT(*) AS rowcount FROM constituencies;");
					rs5.next();
					out.print(rs5.getInt("rowcount"));
					rs5.close();
	 
					conn.close();
				%>)</div>
				</div>
				</a>
				<div class="block" style="background-image:url(/maps.png); border: 1px dashed;">
					<div>Turnout Map (Coming soon)</div>
				</div>
			</div>
		</main>
		
		<footer>
			This site was created by <a href="http://samireland.com">Sam Ireland</a>, in July 2015. For questions or other enquiries, please tweet <a href="http://twitter.com/Sam_M_Ireland">@Sam_M_Ireland</a>. This project is in no way affiliated with the UK House of Commons or the British government.
		</footer>
	</body>
</html>
	