package net.seansnyder.alphadefense.states 
{
	import ash.tick.FrameTickProvider;
	import flash.display.DisplayObjectContainer;
	import net.seansnyder.alphadefense.GameConfig;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.systems.ButtonSystem;
	import net.seansnyder.alphadefense.WordList;
	import net.seansnyder.alphadefense.input.KeyPoll;
	import net.seansnyder.alphadefense.input.MousePoll;
	import net.seansnyder.alphadefense.systems.AnimationSystem;
	import net.seansnyder.alphadefense.systems.AsteroidSpawningSurvivalSystem;
	import net.seansnyder.alphadefense.systems.CollisionSystem;
	import net.seansnyder.alphadefense.systems.DecaySystem;
	import net.seansnyder.alphadefense.systems.GameRulesSurvivalSystem;
	import net.seansnyder.alphadefense.systems.HealthSystem;
	import net.seansnyder.alphadefense.systems.MovementSystem;
	import net.seansnyder.alphadefense.systems.PointsSystem;
	import net.seansnyder.alphadefense.systems.RenderSystem;
	import net.seansnyder.alphadefense.systems.ReticleSystem;
	import net.seansnyder.alphadefense.systems.SoundSystem;
	import net.seansnyder.alphadefense.systems.SystemPriorities;
	import net.seansnyder.alphadefense.systems.TankControlSystem;
	import net.seansnyder.alphadefense.systems.TankFiringSystem;
	import net.seansnyder.alphadefense.systems.TextAmmoSystem;
	/**
	 * TO DO:
		 * Create Game Over Sub-State where game over window is displayed and input is disabled.
		 * After game ends, player can click click one of two buttons: Play Again or Menu
		 * 		Play Again resets the game
		 * 		Menu takes player to Menu State
	 * @author Sean Snyder
	 */
	public class GameState extends State 
	{
		
		private var config : GameConfig;
		private var creator : EntityCreator;
		private var wordlist : WordList;
		
		private var gameRulesSys : GameRulesSurvivalSystem;
		private var textAmmoSys : TextAmmoSystem;
		private var tankControlSys : TankControlSystem;
		private var reticleSys : ReticleSystem;
		private var buttonSys : ButtonSystem;
		
		private var inGameOverMode : Boolean = false;
		private var restartGame : Boolean = false;
		
		public function GameState(manager:StateManager,
								  keyPoll : KeyPoll,
								  mousePoll : MousePoll,
								  container : DisplayObjectContainer,
								  config : GameConfig,
								  wordlist : WordList) 
		{
			super(manager, keyPoll, mousePoll, container);
			this.config = config;
			this.wordlist = wordlist;
			this.creator = new EntityCreator( engine , config);
			prepare();
		}
		
		/**
		 * Sets up the systems for the CES engine.
		 */
		private function prepare():void 
		{
			buttonSys = new ButtonSystem(buttonPushed, mousePoll, creator);
			gameRulesSys = new GameRulesSurvivalSystem( creator, config );
			textAmmoSys = new TextAmmoSystem( container.stage, wordlist );
			reticleSys = new ReticleSystem( mousePoll );
			tankControlSys = new TankControlSystem( mousePoll );
			
			engine.addSystem( gameRulesSys, SystemPriorities.preUpdate );
			engine.addSystem( new AsteroidSpawningSurvivalSystem(creator), SystemPriorities.update );
			engine.addSystem( new DecaySystem( creator ), SystemPriorities.update );
			engine.addSystem( new HealthSystem( creator ), SystemPriorities.update );
			engine.addSystem( textAmmoSys, SystemPriorities.update );
			engine.addSystem( reticleSys, SystemPriorities.update );
			engine.addSystem( tankControlSys, SystemPriorities.update );
			engine.addSystem( new TankFiringSystem(creator), SystemPriorities.update );
			engine.addSystem( new MovementSystem( creator, config ), SystemPriorities.move );
			engine.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			engine.addSystem( new PointsSystem(), SystemPriorities.calculatePoints );
			engine.addSystem( new AnimationSystem(), SystemPriorities.animate );
			engine.addSystem( new SoundSystem(), SystemPriorities.sounds );
			engine.addSystem( new RenderSystem( container.stage ), SystemPriorities.render );
			
			creator.createGame();
			gameRulesSys.initLabels();
		}
		
		override public function updateState(time:Number):void 
		{
			super.updateState(time);
			//when player loses, switch to "game over" mode
			if (gameRulesSys.hasPlayerLost() && !inGameOverMode) {
				
				//show game over screen
				creator.createGameOverScreen(50, 50, gameRulesSys.getPlayerFinalPoints());
				
				//disable game controls
				engine.removeSystem(textAmmoSys);
				engine.removeSystem(reticleSys);
				engine.removeSystem(tankControlSys);
				
				//enable button input
				engine.addSystem(buttonSys, SystemPriorities.update);
				inGameOverMode = true;
			}
			else if (restartGame) {
				engine.removeAllEntities();
				engine.removeAllSystems();
				prepare();
				restartGame = false;
				inGameOverMode = false;
			}
		}
		
		private function buttonPushed(buttonID:int):void {
			trace("Button " + buttonID + " Pushed");
			switch(buttonID) {
				case ButtonIDs.REPLAY_ID:
					restartGame = true;
					break;
			}
		}
	}

}