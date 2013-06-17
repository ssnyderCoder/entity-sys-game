package net.seansnyder.alphadefense.components 
{
	/**
	 * Note: This component is only attached to existing entities, rather than created as its own entity
	 * @author Sean Snyder
	 */
	public class PointsGained 
	{
		public var pointValue:int;
		public function PointsGained(value:int = 10) 
		{
			pointValue = value;
		}
		
	}

}