package net.seansnyder.alphadefense.states 
{
	import ash.core.Engine;
	import ash.tick.FrameTickProvider;
	import flash.display.DisplayObjectContainer;
	import net.seansnyder.alphadefense.input.KeyPoll;
	import net.seansnyder.alphadefense.input.MousePoll;
	/**
	 * This class is able to:
		 * store its own set of entities.
		 * be enabled or disabled with systems/entities removed or added
		 * be send/receve data to/from other states when states are switched
	 * @author Sean Snyder
	 */
	public class State 
	{
		protected var engine:Engine;
		
		protected var manager : StateManager;
		protected var finished : Boolean = false;
		
		protected var keyPoll : KeyPoll;
		protected var mousePoll : MousePoll;
		protected var container : DisplayObjectContainer;
		
		public function State(manager : StateManager,
							  keyPoll : KeyPoll,
							  mousePoll : MousePoll,
							  container : DisplayObjectContainer) 
		{
			engine = new Engine();
			this.manager = manager;
			this.keyPoll = keyPoll;
			this.mousePoll = mousePoll;
			this.container = container;
		}
		

		
		/**
		 * 
		 * @return true if the state is finished, false otherwise.
		 */
		public function isFinished():Boolean{
			return finished;
		}
		
		/**
		 * Sets the state to finished.
		 */
		public function setFinished():void{
			finished = true;
		}
			
				/**
		 * This method is called by the StateManager when this state
		 * is finished.  This method is meant to change the
		 * current state of the StateManager and/or modify other
		 * states in the StateManager. 
		 * @param stateMan The StateManager calling this method
		 */
		public function setNextState(stateMan:StateManager):void{
			
		}
		
		/**
		 * This method checks the statedata information passed in and initializes this state based on that data.
		 * It is assumed that the data passed in is compatible with this state. 
		 * @param data
		 */
		public function applyStateData(data:StateData):void{
			
		}
		
		/**
		 * This method is used to add the engine's update method to the frame tick provider, as well
		 * as any other necessary setup.
		 * @param	tickProvider the FrameTickProvider that the update function is added to.
		 */
		public function activateState(tickProvider:FrameTickProvider) : void {
			tickProvider.add(engine.update);
		}
	
		/**
		 * This method is used to remove the engine's update method from the frame tick provider, and
		 * does any other necessary cleanup.
		 * @param	tickProvider the FrameTickProvider that the update function is removed from.
		 */
		public function deactivateState(tickProvider:FrameTickProvider) : void {
			tickProvider.remove(engine.update);
		}
		
		/**
		 * Called by the StateManager during every tick
		 */
		public function updateState(time:Number) : void {
			
		}
	}

}