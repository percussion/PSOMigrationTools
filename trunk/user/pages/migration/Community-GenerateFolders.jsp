<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="com.percussion.pso.migration.MigrationToolsServiceLocator"
    import="java.io.IOException,javax.servlet.jsp.JspWriter,java.lang.Exception"
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
<title>Migration Tools - Generate Folder From Community</title>
</head>
<body>
<div id="header">&nbsp;</div>
<%!   
   MigrationToolsServiceLocator locator = new MigrationToolsServiceLocator();
%>

<div id="pagecontent">
<h1>Migration Tools</h1>
<h2>Generate Folders from Communities</h2>
<form method="POST"> 
<p><label for="community">Community:</label><input name="community" size="75" /></br>
<label for="Folder">Folder:</label><input name="folder" size="75" /></br>
<input type="submit" name="execute" value="execute" label="Execute" /></p>
</form>
<%if (request.getMethod().equals("POST")
               && request.getParameter("execute").equals("execute"))
  {
    	String community = request.getParameter("community").trim();
    	String folder = request.getParameter("folder").trim();
 
 		locator.getCommunityToolsService().generateFolderFromCommunity(community,folder); 
  }
  
  
%>      
</div>
</body>
</html>