package com.percussion.pso.migration;

/***
 * Specifies an interface for dispatching command notifications to the UI.
 * 
 * @author natechadwick
 *
 */
public interface ICommand {

	/**
	 * Executes the specific command. 
	 */
	void execute();
}
