package net.seansnyder.alphadefense 
{
	import ash.core.Engine;
	import ash.tick.FrameTickProvider;
	import flash.display.DisplayObjectContainer;
	import net.seansnyder.alphadefense.input.KeyPoll;
	import net.seansnyder.alphadefense.input.MousePoll;
	import net.seansnyder.alphadefense.states.StateIDs;
	import net.seansnyder.alphadefense.states.StateManager;
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
	 * The Game class sets up the display and the entity system.
	 * @author Sean Snyder (Richard Lord's asteroids code utilized as base code)
	 */
	public class Game
	{
		public static const DEBUG_MODE : Boolean = true;
		
		private var container : DisplayObjectContainer;
		private var tickProvider : FrameTickProvider;
		private var config : GameConfig;
		private var stateManager : StateManager;
		
		public function Game( container : DisplayObjectContainer, width : Number, height : Number )
		{
			this.container = container;
			prepare( width, height );
		}
		
		private function prepare( width : Number, height : Number ) : void
		{
			config = new GameConfig();
			config.width = width;
			config.height = height;
			tickProvider = new FrameTickProvider( container );
			stateManager = new StateManager(this, container, tickProvider, config);
			stateManager.setCurrentState(StateIDs.GAME_STATE_ID, null);
		}
		
		
		public function start() : void
		{
			tickProvider.start();
		}
		
		public function stop() : void
		{
			tickProvider.stop();
		}
	}
}