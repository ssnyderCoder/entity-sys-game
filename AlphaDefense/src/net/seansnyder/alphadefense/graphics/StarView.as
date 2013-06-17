package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import net.seansnyder.alphadefense.assets.Images;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class StarView extends Sprite implements Animatable
	{
		private static const SCALE_LIMIT:Number = 6;
		
		private var totalTime:Number;
		public function StarView() 
		{
			this.addChild(new Images.STAR() as Bitmap);
			
			totalTime = Math.random() * SCALE_LIMIT;
		}
		
		
		public function animate(time:Number):void 
		{
			totalTime += time;
			if (totalTime >= SCALE_LIMIT) {
				totalTime = 0;
			}
			var scaleFactor:Number = Math.abs(totalTime - (SCALE_LIMIT / 2));
			this.scaleX = 0.85 + scaleFactor / (2 * SCALE_LIMIT);
			this.scaleY = 0.85 + scaleFactor / (2 * SCALE_LIMIT);
		}
		
	}

}