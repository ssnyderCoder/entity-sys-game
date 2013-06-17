package net.seansnyder.alphadefense.systems
{
	import ash.tools.ListIteratingSystem;
	import net.seansnyder.alphadefense.nodes.AnimationNode;


	public class AnimationSystem extends ListIteratingSystem
	{
		public function AnimationSystem()
		{
			super( AnimationNode, updateNode );
		}

		private function updateNode( node : AnimationNode, time : Number ) : void
		{
			node.animation.animation.animate( time );
		}
	}
}
