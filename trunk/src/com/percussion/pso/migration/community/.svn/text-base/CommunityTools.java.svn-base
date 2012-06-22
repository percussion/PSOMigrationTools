package com.percussion.pso.migration.community;

import com.percussion.pso.migration.IMigrationTool;
import com.percussion.services.content.IPSContentService;
import com.percussion.services.content.PSContentServiceLocator;
import com.percussion.webservices.content.IPSContentWs;
import com.percussion.webservices.content.PSContentWsLocator;
import com.percussion.webservices.security.IPSSecurityDesignWs;
import com.percussion.webservices.security.PSSecurityWsLocator;

/***
 * Provides a service class for community related tools.
 
 * @author natechadwick
 *
 */
public class CommunityTools implements IMigrationTool {
	

	private IPSSecurityDesignWs securityService;
	private IPSContentWs contentService;
	
	public void initServices() {
		setSecurityService(PSSecurityWsLocator.getSecurityDesignWebservice());
		setContentService(PSContentWsLocator.getContentWebservice());
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

	public void generateFolderFromCommunity(String targetCommunity, String targetFolder) throws Exception{
		GenerateFoldersFromCommunity task = new GenerateFoldersFromCommunity();
		
		task.setContentService(contentService);
		task.setSecurityService(securityService);
		task.setTargetCommunity(targetCommunity);
		task.setTargetFolder(targetFolder);
		
		task.run();
	}
}
