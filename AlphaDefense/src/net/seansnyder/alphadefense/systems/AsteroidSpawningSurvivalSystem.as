package net.seansnyder.alphadefense.systems 
{
	import ash.core.System;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.enums.AsteroidType;
	import net.seansnyder.alphadefense.enums.EnumAsteroidType;
	import net.seansnyder.alphadefense.Game;
	import net.seansnyder.alphadefense.nodes.AsteroidNode;
	import net.seansnyder.alphadefense.nodes.GameNode;
	import ash.core.NodeList;
	import ash.core.Engine;
	
	/**
	 * New asteroids are spawned based on how much time has passed and how many asteroids are currently
	 * in play.  While no asteroids are in play, new asteroids spawn sooner.  As time goes on,
	 * asteroids spawn more frequently and bigger asteroids spawn more often.  The game difficulty
	 * also influences how often asteroids spawn.
	 * 
	 * @author Sean Snyder
	 */
	public class AsteroidSpawningSurvivalSystem extends System
	{
		private var creator : EntityCreator;
		
		private var asteroids : NodeList;
		
		/**
		 * Assumed to be only one game node
		 */
		private var games : NodeList;
		
		private var delay : Number = 0;
		private var defaultDelay : Number = 5;
		private var asteroidWeights : Array = new Array(23, 10, 2);
		private var totalWeight : Number = 35;
		private var asteroidTypes : Array = new Array(EnumAsteroidType.SMALL_ASTEROID, EnumAsteroidType.MEDIUM_ASTEROID,
														EnumAsteroidType.LARGE_ASTEROID);
														
		public function AsteroidSpawningSurvivalSystem(creator : EntityCreator) 
		{
			this.creator = creator;
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			asteroids = engine.getNodeList( AsteroidNode );
			games = engine.getNodeList( GameNode );
		}
		

		override public function update( time : Number ) : void
		{
			if (Game.DEBUG_MODE) {
				time *= 20;
			}
			
			if (delay > 0) {
				delay -= time;
				
				if (asteroids.empty) {
					delay -= time * 2;
				}
			}
			
			//spawn some asteroids and increase spawning rates and spawning speed
			else {
				//spawn between 1 - 5 asteroids
				var numSpawn:int = Math.floor(Math.random() * 5) + 1;
				for (var i:int = 0; i < numSpawn; i++) {
					creator.createAsteroid(getAsteroidType());
				}
				delay = defaultDelay * numSpawn;
				
				//adjust spawning rate and speed slightly
				var game:GameNode = games.head;
				defaultDelay *= (1.0 - game.game.difficulty.spawnRateIncrease);
				var index:int = Math.random() < 0.6 ? 1 : 2;
				asteroidWeights[index] += 1;
				totalWeight += 1;
			}
		}
		
		override public function removeFromEngine( engine : Engine ) : void
		{
			asteroids = null;
			games = null;
		}

		/**
		 * Returns a (weighted) random type of asteroid
		 */
		private function getAsteroidType():AsteroidType {
			var weight:Number = Math.floor(Math.random() * totalWeight);
			for (var j:int = 0; j < asteroidTypes.length ; j++) {
				var astWeight:Number = asteroidWeights[j];
				weight -= astWeight;
				if (weight < 0) {
					var type:AsteroidType = asteroidTypes[j];
					return type;
				}
			}
			return asteroidTypes[0];
		}
	}

}