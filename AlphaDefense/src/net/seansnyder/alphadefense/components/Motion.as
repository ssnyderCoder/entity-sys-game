package net.seansnyder.alphadefense.components
{
	import flash.geom.Point;
	
	public class Motion
	{
		public var velocity : Point = new Point();
		public var angularVelocity : Number = 0;
		public var damping : Number = 0;
		public var canBounceOffSide : Boolean = false;
		
		public function Motion( velocityX : Number, velocityY : Number, angularVelocity : Number,
								damping : Number, bouncesOffSide : Boolean = false)
		{
			velocity = new Point( velocityX, velocityY );
			this.angularVelocity = angularVelocity;
			this.damping = damping;
			canBounceOffSide = bouncesOffSide;
		}
	}
}
