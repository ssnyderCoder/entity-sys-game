package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class MoonView extends Shape 
	{
		
		public function MoonView(size:Number) 
		{
			graphics.beginFill( 0xffffff );
			graphics.drawCircle( 0, 0, size );
			graphics.endFill();
		}
		
	}

}