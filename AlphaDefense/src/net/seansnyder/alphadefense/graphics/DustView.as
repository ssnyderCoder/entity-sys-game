package net.seansnyder.alphadefense.graphics 
{
	import flash.display.BitmapDataChannel;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class DustView extends Shape
	{
		
		public function DustView(color : uint = 0xFFFFFF) 
		{
			graphics.beginFill( color);
			var drawX : Number = 0;
			var drawY : Number = 0;
			var maxParticles : int = Math.round(Math.random() * 16) + 8;
			for (var i:int = 0; i < maxParticles; i++) {
				drawX += (Math.random() * 12) - 6;
				drawY += (Math.random() * 12) - 6;
				graphics.drawCircle( drawX, drawY, 1 );
			}
			graphics.endFill();
			var bitmapdata:BitmapData = new BitmapData(33, 33);
			bitmapdata.
		}
		
	}

}