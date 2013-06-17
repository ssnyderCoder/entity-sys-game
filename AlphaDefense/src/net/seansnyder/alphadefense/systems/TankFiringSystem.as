package net.seansnyder.alphadefense.systems 
{
	import ash.core.NodeList;
	import ash.core.System;
	import ash.core.Engine;
	import net.seansnyder.alphadefense.assets.Sounds;
	import net.seansnyder.alphadefense.components.Display;
	import net.seansnyder.alphadefense.components.GameStatus;
	import net.seansnyder.alphadefense.components.Reticle;
	import net.seansnyder.alphadefense.components.Sound;
	import net.seansnyder.alphadefense.components.TankCannon;
	import net.seansnyder.alphadefense.EntityCreator;
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
	public class TankFiringSystem extends System
	{
		
		private const PRIMARY_MOUSE_BUTTON : Boolean = true;
		private const COLOR_WHITE : uint = 0xFFFFFF;
		private const MAX_WORD_LENGTH : uint = 15;
		
		private var reticles : NodeList;
		private var cannons : NodeList;
		private var textAmmos : NodeList;
		private var entityCreator : EntityCreator;
		private var delay : Number; //in seconds
			
		
		public function TankFiringSystem(creator:EntityCreator) 
		{
			entityCreator = creator;
			delay = 0;
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			cannons = engine.getNodeList(CannonPositionNode);
			reticles = engine.getNodeList(ReticlePositionNode);
			textAmmos = engine.getNodeList(TextAmmoNode);
		}
		
		/**
		 * NOTE: This function has one early exit point
		 */
		override public function update( time : Number ) : void
		{
			var reticleNode : ReticlePositionNode;
			var cannonNode : CannonPositionNode;
			var textAmmoNode : TextAmmoNode = textAmmos.head; //only 1 expected
			
			if (delay > 0) {
				delay -= time;
				
				if (delay > 0) {
					return;
				}
			}
			
			//for each cannon
			for( cannonNode = cannons.head; cannonNode; cannonNode = cannonNode.next )
			{
				//if cannon not firing, CONTINUE
				var cannon : TankCannon = cannonNode.cannon;
				if (!cannon.isFiring) {
					continue;
				}
				
				//spawn bullet(s) based on whether txtAmmo spells out a word
				if (textAmmoNode.textAmmo.isWord) {
					//spawn next letter bullet with accuracy and power based on word length
					var displace:Number = (MAX_WORD_LENGTH - textAmmoNode.textAmmo.numLetters) * 0.005;
					var power:Number = cannon.basePower * textAmmoNode.textAmmo.numLetters;
					var letter:String = textAmmoNode.textAmmo.letters.text.charAt(0);
					var color:uint = 0x229944; //dark green
					entityCreator.createLetterBullet(letter, cannon, cannonNode.cannonPosition, displace, power, color)
						.add(new Sound(Sounds.LASER_SHOT_ID));
					
					delay = 0.25;
					
					//remove used letter from textAmmo
					if(textAmmoNode.textAmmo.letters.text.length > 1){
						textAmmoNode.textAmmo.letters.text = textAmmoNode.textAmmo.letters.text.substr(1);
					}
					else {
						textAmmoNode.textAmmo.letters.text = "";
					}
					
				}
				else {
					//spawn all letter bullets with default power and lesser accuracy based on word length
					var numLetters : uint = textAmmoNode.textAmmo.numLetters;
					var maxDisplace : Number = 0.6;
					for (var i:Number = 0; i < numLetters; i++){
						var displace2:Number = (numLetters / MAX_WORD_LENGTH) * maxDisplace ;
						var power2:Number = cannon.basePower;
						var letter2:String = textAmmoNode.textAmmo.letters.text.charAt(i);
						entityCreator.createLetterBullet(letter2, cannon, cannonNode.cannonPosition, displace2, power2)
							.add(new Sound(Sounds.LASER_SHOT_ID));
					}
					textAmmoNode.textAmmo.letters.text = "";
				}
				
				//if txtAmmo empty, end process and set delay to 0.75 seconds
				if (textAmmoNode.textAmmo.letters.text == "") {
					cannon.isFiring = false;
					textAmmoNode.textAmmo.isEnabled = true;
					textAmmoNode.textAmmo.letters.backgroundColor = COLOR_WHITE;
					textAmmoNode.textAmmo.numLetters = 0;
					
					//find first red inactive reticle and turn to green active reticle
					var redReticleNode : ReticlePositionNode = null;
					for ( reticleNode = reticles.head; reticleNode; reticleNode = reticleNode.next )
					{
						if (!reticleNode.reticle.isMouseFocused) {
							redReticleNode = reticleNode;
							break;
						}
					}
					
					if(redReticleNode != null){
						redReticleNode.reticle.isMouseFocused = true;
						redReticleNode.entity.add(new Display(new ReticleView(true))); //replaces previous display
					}
					
					delay = 0.75;
				}
				
				
			}
		}
		
		override public function removeFromEngine( engine : Engine ) : void
		{
			reticles = null;
			cannons = null;
			textAmmos = null;
		}
		
	}

}