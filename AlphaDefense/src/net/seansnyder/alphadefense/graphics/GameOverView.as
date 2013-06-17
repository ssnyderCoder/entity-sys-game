package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class GameOverView extends Shape
	{
		
		public function GameOverView() 
		{
			graphics.beginFill(0x441903);
			graphics.drawRect(0, 0, 200, 300);
			graphics.endFill();
		}
		
	}

}