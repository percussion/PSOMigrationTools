package com.percussion.pso.migration;

import com.percussion.pso.migration.community.CommunityTools;
import com.percussion.services.PSBaseServiceLocator;

/***
 * Provides a locator for the Migration tools. 
 * 
 * @author natechadwick
 */
public class MigrationToolsServiceLocator extends PSBaseServiceLocator {

	
	private static final String COMMUNITY_TOOL_BEAN="migrationCommunityTools";
	
	public CommunityTools getCommunityToolsService(){
		return (CommunityTools) PSBaseServiceLocator.getBean(COMMUNITY_TOOL_BEAN); 
	}
	
}
