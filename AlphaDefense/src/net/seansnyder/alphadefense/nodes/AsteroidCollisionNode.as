package net.seansnyder.alphadefense.nodes 
{
	import ash.core.Node;
	import net.seansnyder.alphadefense.components.Asteroid;
	import net.seansnyder.alphadefense.components.Collision;
	import net.seansnyder.alphadefense.components.ExplosiveDamage;
	import net.seansnyder.alphadefense.components.Health;
	import net.seansnyder.alphadefense.components.Position;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class AsteroidCollisionNode extends Node
	{
		
		public var asteroid:Asteroid;
		public var position:Position;
		public var collision:Collision;
		public var damage:ExplosiveDamage;
		public var health:Health;
		
	}

}