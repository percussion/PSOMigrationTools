package com.percussion.pso.migration.community;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.w3c.tidy.Report;

import com.percussion.cms.objectstore.PSFolder;
import com.percussion.pso.migration.AbstractTask;
import com.percussion.search.objectstore.PSWSSearchField;
import com.percussion.search.objectstore.PSWSSearchParams;
import com.percussion.search.objectstore.PSWSSearchRequest;
import com.percussion.services.catalog.IPSCatalogSummary;
import com.percussion.services.content.IPSContentService;
import com.percussion.services.content.PSContentServiceLocator;
import com.percussion.services.content.data.PSSearchSummary;
import com.percussion.utils.guid.IPSGuid;
import com.percussion.webservices.content.IPSContentWs;
import com.percussion.webservices.security.IPSSecurityDesignWs;
import com.percussion.webservices.security.PSSecurityWsLocator;


/***
 * Generates a set of Folders from a community.  
 * 
 * 
 * @author natechadwick
 *
 */
public class GenerateFoldersFromCommunity extends AbstractTask {

 private IPSContentWs contentService;
 private IPSSecurityDesignWs securityService;
 private String targetCommunity;
 private String targetFolder;
 
 
 /**
 * @param contentService the contentService to set
 */
public void setContentService(IPSContentWs contentService) {
	this.contentService = contentService;
}
/**
 * @return the contentService
 */
public IPSContentWs getContentService() {
	return contentService;
}
/**
 * @param securityService the securityService to set
 */
public void setSecurityService(IPSSecurityDesignWs securityService) {
	this.securityService = securityService;
}
/**
 * @return the securityService
 */
public IPSSecurityDesignWs getSecurityService() {
	return securityService;
}

/**
 * @param targetCommunity the targetCommunity to set
 */
public void setTargetCommunity(String targetCommunity) {
	this.targetCommunity = targetCommunity;
}
/**
 * @return the targetCommunity
 */
public String getTargetCommunity() {
	return targetCommunity;
}
/**
 * @param targetFolder the targetFolder to set
 */
public void setTargetFolder(String targetFolder) {
	this.targetFolder = targetFolder;
}
/**
 * @return the targetFolder
 */
public String getTargetFolder() {
	return targetFolder;
}

/***
 * Validates that we have all of the parameters need to run the task.
 * @throws Exception 
 */
private void checkRequiredParams() throws Exception{

	if((targetCommunity==null) || targetCommunity.trim().equals(""))
		throw new Exception("targetCommunity parameter missing");
	
	if((targetFolder==null)||targetFolder.trim().equals(""))
		throw new Exception("targetFolder Parameter missing");

	if(securityService==null) 
		throw new Exception("Security Service not set");

	if(contentService==null)
		throw new Exception("Content Service not set");
}

@Override
public void run() throws Exception{

	
	IPSCatalogSummary community;
	
	checkRequiredParams();
	
	List<IPSCatalogSummary> communities = securityService.findCommunities(getTargetCommunity());

	if(communities.size()==0 || communities.size()>1)
		throw new Exception("Found 0 or more than one community. Can have only one target.");
	
	community = communities.get(0);
	
	PSFolder folder;
	
	try{
		List<PSFolder> temp = contentService.loadFolders( new String[]{targetFolder});
	}catch(Exception e){
	
	    List<PSFolder> folders = contentService.addFolderTree(targetFolder);
		
		if(folders.size()==0)
			throw new Exception("Failed to create folder" + targetFolder);
	
		//The last folder created is our target.
		folder = folders.get(folders.size()-1);
		
		contentService.saveFolders(Collections.singletonList(folder));

		this.setMessage("Created " + folder.getFolderPath() + " folder.");

	}
		
	
	//Now find all of the items in this community and move them to this folder. 
	PSWSSearchParams searchParams = new PSWSSearchParams();
	PSWSSearchField searchField = new PSWSSearchField("sys_communityid",
									PSWSSearchField.OP_ATTR_EQUAL,
									("" + community.getGUID().getUUID()),
									PSWSSearchField.CONN_ATTR_AND);
	
	
	searchParams.setSearchForFolders(false);
	
	searchParams.setSearchFields(Collections.singletonList(searchField));
	
	PSWSSearchRequest search = new PSWSSearchRequest(searchParams);

	
	List <PSSearchSummary>searchResults = contentService.findItems(search, false);
	
	//getGUID()
	
//	List<IPSGuid> items = new ArrayList<IPSGuid>();

	for(PSSearchSummary result : searchResults){
	//	items.add(result.getGUID());
		try{
			contentService.addFolderChildren(targetFolder,Collections.singletonList(result.getGUID()) );
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		}
	
	
}
 
}
