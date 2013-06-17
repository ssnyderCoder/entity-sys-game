package net.seansnyder.alphadefense.states 
{
	import ash.tick.FrameTickProvider;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import net.seansnyder.alphadefense.Game;
	import net.seansnyder.alphadefense.GameConfig;
	import net.seansnyder.alphadefense.input.KeyPoll;
	import net.seansnyder.alphadefense.input.MousePoll;
	import net.seansnyder.alphadefense.WordList;
	/**
	 * Is used to switch active states and transfer information from one state to another.
	 * @author Sean Snyder
	 */
	public class StateManager 
	{
		private var states : Dictionary;
		private var currentStateIndex : int = 0;
		private var keyPoll : KeyPoll;
		private var mousePoll : MousePoll;
		private var container : DisplayObjectContainer;
		private var tickProvider : FrameTickProvider;
		private var game: Game;
		private var config : GameConfig;
		private var wordlist : WordList;
		
		public function StateManager(game:Game,
									 container:DisplayObjectContainer,
									 tickProvider:FrameTickProvider,
									 config:GameConfig) 
		{
			//initialize all variables
			this.game = game;
			this.container = container;
			this.tickProvider = tickProvider;
			this.config = config;
			states = new Dictionary();
			keyPoll = new KeyPoll(container.stage);
			mousePoll = new MousePoll(container.stage);
			wordlist = new WordList();
			wordlist.loadTextFile("../resources/dictionary/wordList.txt");
			
			initAllStates();
			tickProvider.add(checkCurrentState);
		}
		
		private function initAllStates():void 
		{
			states[StateIDs.GAME_STATE_ID] = new GameState(this, keyPoll, mousePoll, container, config, wordlist);
		}
		
		private function checkCurrentState(time:Number):void{
			var state:State = states[currentStateIndex];
			state.updateState(time);
			if(state.isFinished()) {
				state.setNextState(this);
			}
		}
		
		public function setCurrentState(stateID:int, data:StateData) : Boolean {
			if(stateID == StateIDs.EXIT_ID){
				game.stop();
				return true;
			}
			else if (states[stateID]) {
				var previousState:State = states[currentStateIndex];
				previousState.deactivateState(tickProvider);
				
				var newState:State = states[stateID];
				currentStateIndex = stateID;
				if (data != null) {
					newState.applyStateData(data);
				}
				newState.activateState(tickProvider);
				return true;
			}
			else {
				return false;
			}
		}
	}

}