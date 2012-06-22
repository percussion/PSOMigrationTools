<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="javax.jcr.query.Query"
    import="javax.jcr.query.QueryResult"  
    import="javax.jcr.query.RowIterator" 
    import="javax.jcr.query.Row" 
    import="javax.jcr.Value" 
    import="java.util.Date"
    import="com.percussion.services.contentmgr.IPSContentMgr, com.percussion.services.contentmgr.IPSNodeDefinition, com.percussion.services.contentmgr.PSContentMgrLocator, com.percussion.webservices.content.PSContentWsLocator, com.percussion.webservices.content.IPSContentWs, com.percussion.utils.guid.IPSGuid, com.percussion.server.webservices.PSServerFolderProcessor, com.percussion.server.PSRequest, com.percussion.utils.request.PSRequestInfo"
    import="com.percussion.design.objectstore.PSLocator, com.percussion.cms.objectstore.PSComponentSummary, com.percussion.webservices.security.IPSSecurityWs, com.percussion.webservices.security.PSSecurityWsLocator"
    import="com.percussion.services.guidmgr.data.PSLegacyGuid, com.percussion.services.guidmgr.data.PSGuid, com.percussion.services.catalog.PSTypeEnum, com.percussion.services.legacy.IPSCmsObjectMgr, com.percussion.services.legacy.PSCmsObjectMgrLocator"
    import="com.percussion.cms.PSCmsException, com.percussion.webservices.PSErrorResultsException, com.percussion.services.security.data.PSCommunity"
    import="com.percussion.cms.objectstore.PSObjectAclEntry, com.percussion.cms.objectstore.IPSDbComponent, com.percussion.cms.objectstore.PSObjectAcl, com.percussion.cms.objectstore.PSFolder"
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
<title>Count Items</title>
</head>
<body>
<div id="header">&nbsp;</div>
<%! 
   // initialize variables used in the JSP page. 
   int ADMIN_ACCESS = PSObjectAclEntry.ACCESS_ADMIN | PSObjectAclEntry.ACCESS_WRITE | PSObjectAclEntry.ACCESS_READ; 
   int WRITE_ACCESS = PSObjectAclEntry.ACCESS_WRITE | PSObjectAclEntry.ACCESS_READ; 
   int READ_ACCESS  = PSObjectAclEntry.ACCESS_READ;
   int TYPE_ROLE    = PSObjectAclEntry.ACL_ENTRY_TYPE_ROLE;
   int TYPE_VIRTUAL = PSObjectAclEntry.ACL_ENTRY_TYPE_VIRTUAL; 
   String EVERYONE  = PSObjectAclEntry.ACL_ENTRY_EVERYONE;
 
   IPSContentMgr mgr = PSContentMgrLocator.getContentMgr(); 
   IPSContentWs contentWs = PSContentWsLocator.getContentWebservice(); 
   PSServerFolderProcessor folderProcessor = getFolderProcessor(); 
   IPSCmsObjectMgr objMgr = PSCmsObjectMgrLocator.getObjectManager();
   IPSSecurityWs securityWs = PSSecurityWsLocator.getSecurityWebservice();
   Map pmap = new HashMap(); 
%>
<%!
   private String getContentTypeName(long contentTypeId) throws Exception
   {
   		List ids = Collections.singletonList(new PSGuid(PSTypeEnum.NODEDEF, contentTypeId));
   		List nodes = mgr.loadNodeDefinitions(ids);
   		return ((IPSNodeDefinition)nodes.get(0)).getInternalName();
   }
    
	/**
	 * @param virtualPerm virtual permission
	 * @param rolePerms role permissions in (String, String) paris.
	 */
	private void countItems(PSLocator[] folderIds, Map countMap, JspWriter out) throws Exception
	{
		//outputFolderPermission(folderIds, virtualPerm, rolePerms, out);
	    //int communityId = getCommunityId(communityIdString);
	    
		//out.println("\n\nUpdates items: ");
	    
		for (int i=0; i < folderIds.length; i++)
		{
		   PSLocator id = folderIds[i];
		   countItemByFolder(id, countMap); 
		}
	}

	private void setItemLastModifiedDate(PSLocator folderId, int communityId, JspWriter out) throws Exception
	{
		PSComponentSummary[] children = folderProcessor.getChildSummaries(folderId);
		List updates = new ArrayList();
		for (int i=0; i<children.length; i++)
		{
			PSComponentSummary item = children[i];
			if (!item.isFolder())
			{
				item.setContentLastModifiedDate(new Date());
				updates.add(item);
				
				out.println("<small>Updated Last Modified Date for item: " + item.getContentId() + "</small><br />");
			}
		}
		if (updates.size() > 0)
		   objMgr.saveComponentSummaries(updates);
	}

	private void countItemByFolder(PSLocator folderId, Map countMap) throws Exception
	{
		PSComponentSummary[] children = folderProcessor.getChildSummaries(folderId);
		for (int i=0; i<children.length; i++)
		{
			PSComponentSummary item = children[i];
			if (!item.isFolder())
			{
				Long typeId = new Long(item.getContentTypeId());
				Integer count = (Integer)countMap.get(typeId);
				if (count == null)
					count = new Integer(1);
				else
					count = new Integer(count.intValue() + 1);	
				countMap.put(typeId, count);
			}
		}
	}
	
%>
<div id="pagecontent">
<h1>Count Items</h1>
<h2>Use this page to count sub folders and content items under a given folder</h2>
<h4>example: //Sites/EnterpriseInvestments/InvestmentAdvice://Sites/CorporateInvestments/</h4>
<form method="POST"> 
<%
    String[] allNames = expandParam(request.getParameterValues("qname"), 6);
         String[] allValues = expandParam(request.getParameterValues("qvalue"), 6);

		 String lastCommunityId = request.getParameter("CommunityId");
         if (StringUtils.isBlank(lastCommunityId))
         {
            lastCommunityId = "-1";
         }
         
		 String lastVirtualPerm = request.getParameter("VirtualPerm");
         if (StringUtils.isBlank(lastVirtualPerm))
         {
            lastVirtualPerm = "";
         }
		 
         String lastquery = request.getParameter("folderpath");
         if (StringUtils.isBlank(lastquery))
         {
            lastquery = "//Sites/EnterpriseInvestments/InvestmentAdvice";
         }
         
%>
<p><textarea name="folderpath" cols="80" rows="3" ><%=lastquery%></textarea><br><label for="touchItems">Touch items Last Modified Date</label><input type="checkbox" name="touchItems" value="checked" /><input type="submit" name="execute" value="execute" label="Execute" /></p>
</form>
<%if (request.getMethod().equals("POST")
               && request.getParameter("execute").equals("execute"))
  {
    try
    {
		String[] folderPaths = request.getParameter("folderpath").trim().split(":");

		String folderPath = "";// = request.getParameter("folderpath").trim();
	   
		if(folderPaths[0].equals(""))
			folderPaths[0] = request.getParameter("folderpath").trim();
		
		for( int fi = 0;fi<folderPaths.length;fi++){
			IPSGuid folderId = contentWs.getIdByPath(folderPaths[fi]);
		
			if (folderId == null)
				throw new RuntimeException("Cannot find folder path: \"" + folderPaths[fi] + "\"");
		
			out.println("<hr />");
			out.println("<h4>Folder Path: " + folderPaths[fi].trim() + "</h4>");
			out.println("<h4>Folder CONTENTID: (" + folderId.getUUID() + ")</h4>");
			
			PSLocator[] folderIds = getDescedentFolderIds(folderId);
			
			if(request.getParameter("touchItems")!=null)
				if(request.getParameter("touchItems").equals("checked"))
					for(int fj = 0;fj< folderIds.length;fj++){
						setItemLastModifiedDate(folderIds[fj],Integer.parseInt(lastCommunityId),out);		
					}
			Map itemTypeMap = new HashMap();
			
			countItems(folderIds, itemTypeMap, out);
			
			out.println("<h4>Total # of SubFolders: " + folderIds.length + "</h4>");
			out.println("<hr />");
			out.println("<table id=\"results\">");
			out.println("<tr>");
			out.println("<th>ContentType (ID)</th>");
			out.println("<th># of Items / ID</th>");
			out.println("</tr>");
			
			int totalItems = 0;
			
			Set entrySet = itemTypeMap.entrySet();
	        Iterator it = entrySet.iterator();
	        int i = 0;
			while (it.hasNext())
	        {
	        	i++;
				String bgcolor;
				if((i % 2) == 0 ){
					bgcolor = "#eeeeee";
				}
				else {
					bgcolor = "#ffffff";
				}
				Map.Entry entry = (Map.Entry) it.next();
	        	Long contentTypeId = (Long)entry.getKey();
	        	String contentTypeName = getContentTypeName(contentTypeId.longValue());
	        	Integer total = (Integer)entry.getValue();
	        	totalItems += total.intValue();
	        	//out.println("bgcolor = " + bgcolor);
				out.println("<tr bgcolor=\"" + bgcolor + "\"><td style=\"text-align:right\">" + contentTypeName + " (" + contentTypeId + ")</td><td style=\"text-align:right\">" + total + "</td></tr>");
	        }
	        
			out.println("<tr><th colspan=\"2\" style=\"text-align:right\">TOTAL # of Items: " + totalItems + "</th></tr>");
			out.println("</table>");
		}
     } 
     catch (Exception ex)
     {
        handleException(ex, out);
     }
  }
%>
      
<%! 
	private int getPermission(String access)
	{
		access = access.toLowerCase();
		if ("admin".equalsIgnoreCase(access))
			return ADMIN_ACCESS;
		else if ("write".equalsIgnoreCase(access))
			return WRITE_ACCESS;
		else if ("read".equalsIgnoreCase(access))
			return READ_ACCESS;
		
		throw new RuntimeException("Unknown permission: '" + access + "'");
	}

    private void outputFolderPermission(PSLocator[] folderIds, String virtualPerm, 
	  Map rolePerms, JspWriter out) throws java.io.IOException
	{
		if (StringUtils.isNotBlank(virtualPerm))
			out.println("\nVirtual Permission: " + virtualPerm);

		out.println("\nRole Permissions: ");
        Set entrySet = rolePerms.entrySet();
        Iterator it = entrySet.iterator();
        while (it.hasNext())
        {
        	Map.Entry entry = (Map.Entry) it.next();
        	out.println("   " + (String)entry.getKey() + ", " + (String)entry.getValue());
        } 
        
		out.println("\nFolder IDs: ");
		for (int i=0; i < folderIds.length; i++)
		{
		   PSLocator id = folderIds[i];
		   out.println("   Folder ID: " + id.getId());
		}
	}

   public PSServerFolderProcessor getFolderProcessor()
   {
      PSRequest req = (PSRequest) PSRequestInfo
            .getRequestInfo(PSRequestInfo.KEY_PSREQUEST);
      return new PSServerFolderProcessor(req, null);
   }

   public PSLocator[] getDescedentFolderIds(IPSGuid parentId) throws PSCmsException
   {
		PSLocator loc = ((PSLegacyGuid)parentId).getLocator();
       	PSLocator[] ids = folderProcessor.getDescendentFolderLocatorsWithoutFilter(loc);
       	List result = new ArrayList();
       	result.add(loc);
       	result.addAll(Arrays.asList(ids));
       	PSLocator[] resultArray = new PSLocator[result.size()];
       	return (PSLocator[]) result.toArray(resultArray);
   }
    
   private String[] expandParam(String[] inParam, int size)
   {
      int ilen = 0;
      if (inParam != null)
      {
         ilen = inParam.length;
      }
      if (ilen >= size)
      {
         return inParam;
      }
      String[] outParam = new String[size];
      java.util.Arrays.fill(outParam, "");
      if (ilen > 0)
      {
         System.arraycopy(inParam, 0, outParam, 0, ilen);
      }
      return outParam;
   }
   
   private void handleException(Exception ex, javax.servlet.jsp.JspWriter out)
      throws java.io.IOException
   {
      out.println("<pre> Unexpected Exception \n");
      out.println(ex.toString());
      StackTraceElement[] stacktrace = ex.getStackTrace();
      for (int m = 0; m < stacktrace.length; m++)
      {
         out.println(stacktrace[m].toString());
      }
      out.println("</pre>");                  
   }
   
   private Map buildParamMap(String[] allNames, String[] allValues,
         javax.servlet.jsp.JspWriter out)
         throws java.io.IOException
   {
      Map pmap = new HashMap();
      for (int i = 0; i < allNames.length; i++)
      {
         String pNameLoop = allNames[i];
         String pValLoop = allValues[i];
         if (pNameLoop.trim().length() > 0 && pValLoop.trim().length() > 0)
         {
            out.println(pNameLoop + " " + pValLoop);
            pmap.put(pNameLoop, pValLoop);
         }
      }
      return pmap;
   }
   private void printTableHeader(String[] columns,
         javax.servlet.jsp.JspWriter out)
         throws java.io.IOException
   {
      out.println("<thead><tr>");
      for (int j = 0; j < columns.length; j++)
      {
         out.println("<th>" + columns[j] + "</th>");
      }
      out.println("</tr></thead>");
   }
   private void printTableRows(QueryResult qresults,
         javax.servlet.jsp.JspWriter out)
         throws java.io.IOException, javax.jcr.RepositoryException
   {
      RowIterator rows = qresults.getRows();
      while (rows.hasNext())
      {
         out.println("<tr>");
         Row nrow = rows.nextRow();
         Value[] nvalues = nrow.getValues();
         for (int k = 0; k < nvalues.length; k++)
         {
            String kval = "&nbsp;";
            if (nvalues[k] != null)
            {
               kval = nvalues[k].getString();
            }
            out.println("<td>" + kval + "</td>");
         }
         out.println("</tr>");
      }
   }
   %>
</p>
</div>
</body>
</html>