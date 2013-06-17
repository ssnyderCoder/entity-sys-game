package net.seansnyder.alphadefense.systems 
{
	import ash.core.System;
	import ash.core.NodeList;
	import ash.core.Engine;
	import net.seansnyder.alphadefense.components.PointsGained;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.nodes.GameNode;
	import net.seansnyder.alphadefense.nodes.PointsNode;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class PointsSystem extends System 
	{
		private var points : NodeList;
		private var gameStatuses : NodeList; //assumed to contain one value
		
		public function PointsSystem() 
		{
		}
		

		override public function addToEngine( engine : Engine ) : void
		{
			points = engine.getNodeList(PointsNode);
			gameStatuses = engine.getNodeList(GameNode);
		}
		
		override public function update( time : Number ) : void
		{
			var pointsNode : PointsNode;
			var gameNode : GameNode = gameStatuses.head;
			
			for( pointsNode = points.head; pointsNode; pointsNode = pointsNode.next )
			{
				gameNode.game.points += pointsNode.points.pointValue;
				pointsNode.entity.remove(PointsGained);
			}
		}
		
		override public function removeFromEngine( engine : Engine ) : void
		{
			points = null;
			gameStatuses = null;
		}
		
	}

}