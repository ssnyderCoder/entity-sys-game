package net.seansnyder.alphadefense.nodes 
{
	import ash.core.Node;
	import net.seansnyder.alphadefense.components.Health;
	import net.seansnyder.alphadefense.components.Position;
	import net.seansnyder.alphadefense.components.Surface;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class SurfaceCollisionNode extends Node 
	{
		public var surface:Surface;
		public var position:Position;
		public var health:Health;
		
	}

}