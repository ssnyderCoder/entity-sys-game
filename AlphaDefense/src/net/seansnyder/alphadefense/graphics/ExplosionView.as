package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ExplosionView extends Sprite implements Animatable
	{
		
		private var circle : Shape;
		private var size : Number;
		
		public function ExplosionView(explosionSize:Number = 1)
		{
			size = explosionSize;
			circle = new Shape();
			circle.graphics.beginFill( 0xFF0000 );
			circle.graphics.drawCircle( 0, 0, 3 );
			circle.graphics.endFill();
			addChild(circle);
			
		}
		
		
		public function animate( time : Number ) : void
		{
			circle.scaleX += size * time;
			circle.scaleY += size * time;
		}
	}
}
