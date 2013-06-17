package net.seansnyder.alphadefense.components
{
	import flash.geom.Point;
	
	public class Position
	{
		public var position : Point;
		public var rotation : Number = 0;
		public var height : Number = 0;
		public var width : Number = 0;
		
		public function Position( x : Number, y : Number, width : Number = -1, height: Number = -1, rotation : Number = 0 )
		{
			position = new Point( x, y );
			this.rotation = rotation;
			this.width = width;
			this.height = height;
		}
	}
}
