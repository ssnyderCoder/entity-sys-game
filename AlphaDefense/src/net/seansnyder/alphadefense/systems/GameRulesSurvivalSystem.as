package net.seansnyder.alphadefense.systems 
{
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import ash.core.Engine;
	import net.seansnyder.alphadefense.components.Label;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.GameConfig;
	import net.seansnyder.alphadefense.nodes.GameNode;
	import net.seansnyder.alphadefense.nodes.SurfaceHpNode;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class GameRulesSurvivalSystem extends System
	{
		private var config : GameConfig;
		private var creator : EntityCreator;
		private var gameNodes : NodeList;
		private var surfaces : NodeList;
		private var secondsPassed : int = 0;
		
		private var timerLabel : Label;
		private var surfaceHpLabel : Label;
		private var pointsLabel : Label;
		
		private var playerHasLost : Boolean = false;
		private var finalPoints : Number = 0;

		public function GameRulesSurvivalSystem( creator : EntityCreator, config : GameConfig )
		{
			this.creator = creator;
			this.config = config;
		}
		
		//initializes survival labels
		public function initLabels():void 
		{
			timerLabel = new Label();
			timerLabel.text.text = "Time: 0:00";
			surfaceHpLabel = new Label();
			surfaceHpLabel.text.text = "Health: 100";
			pointsLabel = new Label();
			pointsLabel.text.text = "Points: 0";
			creator.createSurvivalGameLabels(timerLabel, surfaceHpLabel, pointsLabel);
		}

		override public function addToEngine( engine : Engine ) : void
		{
			gameNodes = engine.getNodeList( GameNode );
			surfaces = engine.getNodeList( SurfaceHpNode );
		}
		
		override public function update( time : Number ) : void
		{
			var gameNode : GameNode = gameNodes.head;
			var surfaceNode : SurfaceHpNode = surfaces.head;
			
			//if surface destroyed, player loses
			if (surfaceNode.health.health <= 0) {
				playerHasLost = true;
				finalPoints = gameNode.game.points;
			}
			
			//update time
			gameNode.game.time += time;
			
			//updates Timer, Points, Surface HP display
			var totalSeconds:int = Math.floor(gameNode.game.time);
			var minutes:int = totalSeconds / 60;
			var seconds:int = totalSeconds % 60;
			var addMin0:Boolean = minutes < 10;
			var addSec0:Boolean = seconds < 10;
			timerLabel.text.text =
				"Time: " + (addMin0 ? "0" : "") + minutes +
				":" + (addSec0 ? "0" : "") + seconds ;
			
			pointsLabel.text.text = "Points: " + gameNode.game.points;
			surfaceHpLabel.text.text = "Health: " + surfaceNode.health.health;
		}

		override public function removeFromEngine( engine : Engine ) : void
		{
			gameNodes = null;
			surfaces = null;
		}
		
		public function hasPlayerLost():Boolean {
			return playerHasLost;
		}
		
		/**
		 * If the game has not ended, it returns 0; otherwise it returns the player's final score
		 * @return player's points
		 */
		public function getPlayerFinalPoints():Number {
			return finalPoints;
		}
	}

}