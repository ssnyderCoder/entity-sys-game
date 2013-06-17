package net.seansnyder.alphadefense.systems 
{
	import ash.core.NodeList;
	import ash.core.System;
	import ash.core.Engine;
	import net.seansnyder.alphadefense.components.Display;
	import net.seansnyder.alphadefense.components.GameStatus;
	import net.seansnyder.alphadefense.components.Reticle;
	import net.seansnyder.alphadefense.components.TankCannon;
	import net.seansnyder.alphadefense.graphics.ReticleView;
	import net.seansnyder.alphadefense.input.MousePoll;
	import net.seansnyder.alphadefense.nodes.ReticlePositionNode;
	import net.seansnyder.alphadefense.nodes.CannonPositionNode;
	import net.seansnyder.alphadefense.nodes.GameNode;
	import net.seansnyder.alphadefense.nodes.TextAmmoNode;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TankControlSystem extends System 
	{
		private const PRIMARY_MOUSE_BUTTON : Boolean = true;
		private const COLOR_GREY : uint = 0x999999;
		private var games : NodeList;
		private var reticles : NodeList;
		private var cannons : NodeList;
		private var textAmmos : NodeList;
		private var mousePoll : MousePoll;
		
		public function TankControlSystem(mousePoll:MousePoll) 
		{
			this.mousePoll = mousePoll;
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			games = engine.getNodeList(GameNode);
			cannons = engine.getNodeList(CannonPositionNode);
			reticles = engine.getNodeList(ReticlePositionNode);
			textAmmos = engine.getNodeList(TextAmmoNode);
		}
		
		/**
		 * NOTE: This function has one early exit point
		 */
		override public function update( time : Number ) : void
		{
			var gameNode : GameNode = games.head; //only 1 expected
			var reticleNode : ReticlePositionNode;
			var cannonNode : CannonPositionNode;
			var textAmmoNode : TextAmmoNode = textAmmos.head; //only 1 expected
			
			//continue only if left clicked && textual ammo exists
			if (mousePoll.isUp() || textAmmoNode.textAmmo.letters.text.length == 0){
				return;
			}
		
			for( cannonNode = cannons.head; cannonNode; cannonNode = cannonNode.next )
			{
				//continue only if not firing
				var cannon : TankCannon = cannonNode.cannon;
				if (cannon.isFiring) {
					continue;
				}
				
				//find first mouse focused green reticle
				var greenReticleNode : ReticlePositionNode = null;
				for ( reticleNode = reticles.head; reticleNode; reticleNode = reticleNode.next )
				{
					if (reticleNode.reticle.isMouseFocused) {
						greenReticleNode = reticleNode;
						break;
					}
				}
				if (greenReticleNode == null) {
					break;
				}
				
				//change reticle to red inactive reticle
				greenReticleNode.reticle.isMouseFocused = false;
				greenReticleNode.entity.add(new Display(new ReticleView(false))); //replaces previous display
				
				//initiate firing mode
				cannon.isFiring = true;
				textAmmoNode.textAmmo.isEnabled = false;
				textAmmoNode.textAmmo.letters.backgroundColor = COLOR_GREY;
				if (textAmmoNode.textAmmo.isWord) {
					gameNode.game.wordsUsed[textAmmoNode.textAmmo.letters.text] = true;
				}
				
			}
		}
		
		override public function removeFromEngine( engine : Engine ) : void
		{
			games = null;
			reticles = null;
			cannons = null;
			textAmmos = null;
		}
		
	}

}