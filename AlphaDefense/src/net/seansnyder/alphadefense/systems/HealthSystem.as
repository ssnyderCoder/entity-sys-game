package net.seansnyder.alphadefense.systems 
{
	import ash.tools.ListIteratingSystem;
	import net.seansnyder.alphadefense.components.Surface;
	import net.seansnyder.alphadefense.nodes.HealthNode;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.components.Health;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class HealthSystem extends ListIteratingSystem
	{
		
		private var creator : EntityCreator;
		
		public function HealthSystem( creator : EntityCreator )
		{
			super( HealthNode, updateNode );
			this.creator = creator;
		}

		private function updateNode( node : HealthNode, time : Number ) : void
		{
			var health : Health = node.health;
			
			if ( health.health <= 0 )
			{
				if (health.killAtZeroHP)
				{
					creator.destroyEntity( node.entity );
				}
				else
				{
					health.health = 0;
				}
			}
		}
	
		
	}

}