<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="com.percussion.webservices.security.IPSSecurityDesignWs,com.percussion.webservices.security.PSSecurityWsLocator"
    import="java.io.IOException,javax.servlet.jsp.JspWriter,java.lang.Exception,com.percussion.services.catalog.IPSCatalogSummary"
    import="java.util.Map, java.util.Set, java.util.Collections, java.util.Map.Entry, java.util.Iterator, java.util.HashMap, java.util.Arrays, java.util.ArrayList, java.util.List, org.apache.commons.lang.StringUtils, javax.servlet.jsp.JspWriter"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body{
	width:100%;
	height:100%;
	margin-bottom:0px;
	margin-top:0px;
	margin-left:auto;
	margin-right:auto;
	background-color:#ffffff;
	border:0px;
	font-family: verdana,geneva,arial,helvetica,sans-serif;
}
p{ 
	color:#221E1F;
	text-decoration:none;
	font-size:small;
	font-weight:normal;
}
h1{ 
	color:#F89827;
	font-size:24px;
} 
h2{ 
	color:#007FB1;
	font-size:20px;
} 
h3{ 
	color:#F89827;
	font-size:16px;
}
h4{ 
	color:#221E1F;
	text-decoration:none;
	font-size:14px;
	font-weight:bold;
	vertical-align:bottom;
}
div#header{ 
	background-image: 
	url('/Rhythmyx/sys_resources/images/banner_bkgd.jpg');
	background-repeat: no-repeat;
	margin:0px 0px 66px 0px;
	padding:0px;
	display:block;
	position:fixed;
	top:0px;
	left:0px;
	width:600px;
	height:66px;
}
div#pagecontent{
	background-color:#ffffff;
	position:relative;
	left:auto; 
	top:auto;
	vertical-align:top;
	margin-left:auto;
	margin-right:auto;
	margin-top:80px;
	margin-bottom:10px;
	text-align:left;
	width:95%;
	height:auto;
}
table#results{ 
	border-style:solid;
	border-width:1px 1px 1px 1px;
	border-color:#999999 #999999 #999999 #999999;
	background-color:#cccccc;
	vertical-align:top;
	width:100%;
}
table#results th{ 
	color:#221E1F;
	text-decoration:none;
	font-size:14px;
	font-weight:bold;
	margin:2px;
	padding:4px;
	background-color:#eeeeee;
	border-style:solid;
	border-width:1px 0px 1px 0px;
	border-color:#F89827 #ffffff #F89827 #ffffff;
	text-decoration:none;
	text-align:center;
}
.code{
	color:#221E1F;
	font-size:small;
	font-family: courier new, serif
}
</style>
<title>Community Information</title>
</head>
<body>
<div id="header">&nbsp;</div>
<%!   
   IPSSecurityDesignWs  svcSecurity = PSSecurityWsLocator.getSecurityDesignWebservice();
%>

<div id="pagecontent">
<h1>Community Services</h1>
<h2>Security Design API - Community Search Example</h2>
<form method="POST"> 
<p><label for="validCommunity">Community Search:</label><input name="validCommunity" size="75" /><br><input type="submit" name="execute" value="execute" label="Execute" /></p>
</form>
<%if (request.getMethod().equals("POST")
               && request.getParameter("execute").equals("execute"))
  {
    try
    {
    
    String target = request.getParameter("validCommunity").trim(); %>
    
    Searching for <%=target%> ...
    <% 
    List results = svcSecurity.findCommunities(target);
   
   	if(results==null || results.size()==0){ %>
   	
    <h4>Community Not Found!</h4>
    
 <% }else{ 
 
 	if(results.size()==1){  %>
 		<h4>Found Community <%=target%>!</h4>
 	<% }else{ 
 	%> <p>Returned <%=results.size() %> Communities</p>
 	<ul>
 	<%
 		//IPSCatalogSummary summary[] = (IPSCatalogSummary[])results.toArray();
 		for(int i=0;i<results.size();i++){%>
 			<li><h4>Found <%=((IPSCatalogSummary)results.get(i)).getName() %></h4></li>
 		
	
 		<%	}
 	 }
 	}
 	 
  } 
    catch (Exception ex)
    {
        response.getWriter().print(ex.getMessage());
    }
  }
  
  
%>      
</ul>
</p>
</div>
</body>
</html>