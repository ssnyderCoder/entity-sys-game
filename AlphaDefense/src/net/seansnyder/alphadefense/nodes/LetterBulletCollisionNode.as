package net.seansnyder.alphadefense.nodes 
{
	import ash.core.Node;
	import net.seansnyder.alphadefense.components.Collision;
	import net.seansnyder.alphadefense.components.ExplosiveDamage;
	import net.seansnyder.alphadefense.components.LetterBullet;
	import net.seansnyder.alphadefense.components.Position;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class LetterBulletCollisionNode extends Node 
	{
		public var bullet:LetterBullet;
		public var position:Position;
		public var collision:Collision;
		public var damage:ExplosiveDamage;
		
	}

}