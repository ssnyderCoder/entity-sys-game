package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class BombView extends Shape
	{
		
		public function BombView() 
		{
			graphics.beginFill( 0x5F4F4F );
			graphics.drawCircle( 0, 0, 6 );
			graphics.endFill();
			graphics.beginFill( 0x33DE66 );
			graphics.drawRect(4, 4, 4, 4);
			graphics.endFill();
		}
		
	}

}