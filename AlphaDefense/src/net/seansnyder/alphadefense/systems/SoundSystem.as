package net.seansnyder.alphadefense.systems 
{
	import ash.tools.ListIteratingSystem;
	import net.seansnyder.alphadefense.assets.Sounds;
	import net.seansnyder.alphadefense.components.Sound;
	import net.seansnyder.alphadefense.nodes.SoundNode;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class SoundSystem extends ListIteratingSystem 
	{
		
		public function SoundSystem()
		{
			super( SoundNode, updateNode );
		}

		private function updateNode( node : SoundNode, time : Number ) : void
		{
			Sounds.playSound(node.sound.soundID);
			node.entity.remove(Sound);
		}
		
	}

}