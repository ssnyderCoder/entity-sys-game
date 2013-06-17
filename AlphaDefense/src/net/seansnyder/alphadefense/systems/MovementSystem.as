package net.seansnyder.alphadefense.systems
{
	import ash.tools.ListIteratingSystem;
	import net.seansnyder.alphadefense.GameConfig;
	import net.seansnyder.alphadefense.components.Motion;
	import net.seansnyder.alphadefense.components.Position;
	import net.seansnyder.alphadefense.nodes.MovementNode;
	import net.seansnyder.alphadefense.EntityCreator;


	public class MovementSystem extends ListIteratingSystem
	{
		private var config : GameConfig;
		private var creator : EntityCreator;
		
		public function MovementSystem( creator : EntityCreator, config : GameConfig )
		{
			this.creator = creator;
			this.config = config;
			
			super( MovementNode, updateNode );
		}

		private function updateNode( node : MovementNode, time : Number ) : void
		{
			var position : Position = node.position;
			var motion : Motion = node.motion;

			position = node.position;
			motion = node.motion;
			
			//move entity based on velocity and time
			position.position.x += motion.velocity.x * time;
			position.position.y += motion.velocity.y * time;
			position.rotation += motion.angularVelocity * time;
			
			var damper : Boolean = true;
			//if entity passes edge of screen, remove it
			if (position.position.x + position.width < 0 || position.position.x > config.width ||
				position.position.y + position.height < 0 || position.position.y > config.height )
			{
				creator.destroyEntity(node.entity);
				damper = false;
			}
			
			//if entity can bounce of left or right side of screen reverse its X Velocity without dampening
			else if ( motion.canBounceOffSide && 
					( position.position.x < 0 || position.position.x + position.width > config.width ) )
			{
				if ((position.position.x < 0 && motion.velocity.x < 0)
					|| (position.position.x + position.width > config.width && motion.velocity.x > 0)) {
					motion.velocity.x *= -1.01;
				}
				damper = false;
			}
			
			//apply damper (if valid) to slow down velocity
			if ( damper && motion.damping > 0 )
			{
				var xDamp : Number = Math.abs( Math.cos( position.rotation ) * motion.damping * time );
				var yDamp : Number = Math.abs( Math.sin( position.rotation ) * motion.damping * time );
				if ( motion.velocity.x > xDamp )
				{
					motion.velocity.x -= xDamp;
				}
				else if ( motion.velocity.x < -xDamp )
				{
					motion.velocity.x += xDamp;
				}
				else
				{
					motion.velocity.x = 0;
				}
				if ( motion.velocity.y > yDamp )
				{
					motion.velocity.y -= yDamp;
				}
				else if ( motion.velocity.y < -yDamp )
				{
					motion.velocity.y += yDamp;
				}
				else
				{
					motion.velocity.y = 0;
				}
			}
		}
	}
}
