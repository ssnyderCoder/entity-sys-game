package net.seansnyder.alphadefense.systems 
{
	import flash.geom.Point;
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import net.seansnyder.alphadefense.assets.Sounds;
	import net.seansnyder.alphadefense.components.PointsGained;
	import net.seansnyder.alphadefense.components.Sound;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.nodes.AsteroidCollisionNode;
	import net.seansnyder.alphadefense.nodes.LetterBulletCollisionNode;
	import net.seansnyder.alphadefense.nodes.SurfaceCollisionNode;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class CollisionSystem extends System 
	{
		private const DEFAULT_EXPLOSION_SIZE:Number = 5;
		private var creator : EntityCreator;
		
		private var asteroids : NodeList;
		private var bullets : NodeList;
		
		/**
		 * Expected to only contain 1 surface
		 */
		private var surfaces : NodeList;
		
		public function CollisionSystem( creator : EntityCreator )
		{
			this.creator = creator;
		}

		override public function addToEngine( engine : Engine ) : void
		{
			asteroids = engine.getNodeList( AsteroidCollisionNode );
			bullets = engine.getNodeList( LetterBulletCollisionNode );
			surfaces = engine.getNodeList( SurfaceCollisionNode );
		}
		
		override public function update( time : Number ) : void
		{

			var bullet : LetterBulletCollisionNode;
			var asteroid : AsteroidCollisionNode;
			var surface : SurfaceCollisionNode = surfaces.head;
			
			for ( asteroid = asteroids.head; asteroid; asteroid = asteroid.next )
			{
				var asteroidAlive:Boolean = true;
				var points:int = 0;
				for ( bullet = bullets.head; bullet && asteroidAlive; bullet = bullet.next )
				{
					//if collided with asteroid, destroy bullet, add points, create explosion, damage asteroid
					var distX:Number = (asteroid.position.position.x + asteroid.collision.radius) -
						(bullet.position.position.x + bullet.collision.radius);
					var distY:Number = (asteroid.position.position.y + asteroid.collision.radius) -
						(bullet.position.position.y + bullet.collision.radius);
					var distSq:Number = (distX * distX) + (distY * distY);
					var range:Number = asteroid.collision.radius + bullet.collision.radius;
					var rangeSq:Number = range * range;
					if ( distSq <= rangeSq )
					{
						var xEplode:Number = bullet.position.position.x + bullet.collision.radius;
						var yExplode:Number = bullet.position.position.y + bullet.collision.radius;
						var sizeExplode:Number = bullet.damage.power + (DEFAULT_EXPLOSION_SIZE);
						points += bullet.damage.power;
						asteroid.health.health -= bullet.damage.power;
						creator.createExplosion(xEplode, yExplode, sizeExplode).add(new Sound(Sounds.ASTEROID_HIT_ID));
						creator.destroyEntity( bullet.entity );
						
						//if asteroid health <= 0, create additional explosion and add more points
						if (asteroid.health.health <= 0) {		
							creator.createExplosion(asteroid.position.position.x, asteroid.position.position.y,
								(asteroid.collision.radius / 10) * DEFAULT_EXPLOSION_SIZE).add(new Sound(Sounds.ASTEROID_DESTROYED_ID));
							asteroidAlive = false;
							points += (asteroid.asteroid.valueInPoints);
						}
					}
				}
				//if collided with surface, destroy asteroid, create explosion, and damage surface
				if (asteroidAlive && 
				(asteroid.position.position.y + ( 2 * asteroid.collision.radius)) >= surface.position.position.y) {
					var xEplodeAst:Number = asteroid.position.position.x + asteroid.collision.radius;
					var yExplodeAst:Number = asteroid.position.position.y + (2 * asteroid.collision.radius);
					var sizeExplodeAst:Number = (asteroid.collision.radius / 10) * DEFAULT_EXPLOSION_SIZE;
					surface.health.health -= asteroid.damage.power;
					creator.createExplosion(xEplodeAst, yExplodeAst, sizeExplodeAst).add(new Sound(Sounds.SURFACE_HIT_ID));
					creator.destroyEntity( asteroid.entity);
				}
				
				//add points as component
				asteroid.entity.add(new PointsGained(points));
			}

		}
		
		override public function removeFromEngine( engine : Engine ) : void
		{
			surfaces = null;
			asteroids = null;
			bullets = null;
		}
		
	}

}