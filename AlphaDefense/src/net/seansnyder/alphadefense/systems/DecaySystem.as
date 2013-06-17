package net.seansnyder.alphadefense.systems
{
	import ash.tools.ListIteratingSystem;
	import net.seansnyder.alphadefense.components.Decay;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.nodes.DecayNode;


	public class DecaySystem extends ListIteratingSystem
	{
		private var creator : EntityCreator;
		
		public function DecaySystem( creator : EntityCreator )
		{
			super( DecayNode, updateNode );
			this.creator = creator;
		}

		private function updateNode( node : DecayNode, time : Number ) : void
		{
			var decay : Decay = node.decay;
			decay.timeRemaining -= time;
			if ( decay.timeRemaining <= 0 )
			{
				creator.destroyEntity( node.entity );
			}
		}
	}
}
