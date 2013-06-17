package net.seansnyder.alphadefense.components 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TankCannon 
	{
		public var isFiring : Boolean = false;
		public var basePower : Number;
		public var offsetFromParent : Point;
		
		public function TankCannon(power : Number = 1, offsetX : Number = 0, offsetY : Number = 0) {
			offsetFromParent = new Point( offsetX, offsetY );
			basePower = power;
		}
	}

}