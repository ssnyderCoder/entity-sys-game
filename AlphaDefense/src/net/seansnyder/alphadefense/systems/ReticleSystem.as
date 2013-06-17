package net.seansnyder.alphadefense.systems 
{
	import ash.core.NodeList;
	import ash.core.System;
	import ash.core.Engine;
	import net.seansnyder.alphadefense.input.MousePoll;
	import net.seansnyder.alphadefense.nodes.ReticlePositionNode;
	import net.seansnyder.alphadefense.nodes.CannonPositionNode;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ReticleSystem extends System
	{
		private const Y_BOUNDARY : Number = 40;
		private var reticles : NodeList;
		private var cannons : NodeList;
		private var mousePoll : MousePoll;
		
		public function ReticleSystem(mousePoll:MousePoll) 
		{
			this.mousePoll = mousePoll;
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			reticles = engine.getNodeList(ReticlePositionNode);
			cannons = engine.getNodeList(CannonPositionNode);
		}
		
		override public function update( time : Number ) : void
		{
			var reticleNode : ReticlePositionNode;
			var cannonNode : CannonPositionNode;
			
			for( cannonNode = cannons.head; cannonNode; cannonNode = cannonNode.next )
			{
				for ( reticleNode = reticles.head; reticleNode; reticleNode = reticleNode.next )
				{
					/* focus mouse centered reticles on the mouse */
					if (reticleNode.reticle.isMouseFocused) {
						//if mouse is above cannon, center the reticle at the mouse's position
						if (mousePoll.getMouseY() < cannonNode.cannonPosition.position.y - Y_BOUNDARY) {
							reticleNode.reticlePosition.position.x = mousePoll.getMouseX();
							reticleNode.reticlePosition.position.y = mousePoll.getMouseY();
							
							//rotate cannon to face reticle if not firing
							if(!cannonNode.cannon.isFiring){
								// find out mouse coordinates to find out the angle
								var cy:Number = mousePoll.getMouseY() - cannonNode.cannonPosition.position.y; 
								var cx:Number = mousePoll.getMouseX() - cannonNode.cannonPosition.position.x;
								// find out the angle
								var radians:Number = Math.atan2(cy,cx);
								// rotate
								cannonNode.cannonPosition.rotation = radians;
							}
						}
					}
				}
			}
		}
		
		override public function removeFromEngine( engine : Engine ) : void
		{
			reticles = null;
			cannons = null;
		}
		
	}

}