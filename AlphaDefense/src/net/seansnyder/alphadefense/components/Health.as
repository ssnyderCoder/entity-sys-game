package net.seansnyder.alphadefense.components 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class Health 
	{
		public var health : Number;
		public var killAtZeroHP : Boolean;
		
		public function Health(health : Number = 10, entityDiesWhenZero : Boolean = true )
		{
			this.health = health;
			this.killAtZeroHP = entityDiesWhenZero;
		}
		
	}

}