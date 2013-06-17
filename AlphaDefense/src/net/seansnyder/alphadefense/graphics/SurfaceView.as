package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class SurfaceView extends Shape
	{
		
		public function SurfaceView(width:Number, height:Number, color:uint = 0x34DD42) 
		{
			graphics.beginFill(color);
			graphics.drawRect(0, 0, width, height);
		}
		
	}

}