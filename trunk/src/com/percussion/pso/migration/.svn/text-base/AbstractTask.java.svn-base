package com.percussion.pso.migration;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.percussion.pso.migration.community.CommunityTools;

/***
 * Serves as an abstract class that all long running tasks will be based on.
 * 
 * @author natechadwick
 *
 */
public abstract class AbstractTask {

	protected static Log log = LogFactory.getLog(IMigrationTool.class); 
	
	private String message;
	private int taskSize;
	private int progress;
	
	private ICommand progressCommand;
	private ICommand successCommand;
	private ICommand failureCommand;
	
	
	
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param taskSize the taskSize to set
	 */
	public void setTaskSize(int taskSize) {
		this.taskSize = taskSize;
	}
	/**
	 * @return the taskSize
	 */
	public int getTaskSize() {
		return taskSize;
	}
	/**
	 * @param progress the progress to set
	 */
	public void setProgress(int progress) {
		this.progress = progress;
	}
	/**
	 * @return the progress
	 */
	public int getProgress() {
		return progress;
	}
	/**
	 * @param progressCommand the progressCommand to set
	 */
	public void setProgressCommand(ICommand progressCommand) {
		this.progressCommand = progressCommand;
	}
	/**
	 * @return the progressCommand
	 */
	public ICommand getProgressCommand() {
		return progressCommand;
	}
	/**
	 * @param successCommand the successCommand to set
	 */
	public void setSuccessCommand(ICommand successCommand) {
		this.successCommand = successCommand;
	}
	/**
	 * @return the successCommand
	 */
	public ICommand getSuccessCommand() {
		return successCommand;
	}
	/**
	 * @param failureCommand the failureCommand to set
	 */
	public void setFailureCommand(ICommand failureCommand) {
		this.failureCommand = failureCommand;
	}
	/**
	 * @return the failureCommand
	 */
	public ICommand getFailureCommand() {
		return failureCommand;
	}
	
	public void fail(){
		log.debug("Abstract Fail");
	}
	
	public void succeed(){
		log.debug("Abstract Success");
	}
	
	/***
	 * 
	 * @throws Exception
	 */
	public void run() throws Exception{
		log.debug("Abstract Run");
	}

	 	
}
