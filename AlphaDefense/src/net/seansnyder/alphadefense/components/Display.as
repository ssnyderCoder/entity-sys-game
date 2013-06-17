package net.seansnyder.alphadefense.components
{
	import flash.display.DisplayObject;
	
	public class Display
	{
		public var displayObject : DisplayObject;
		public var renderLayer : int;
		public var offsetX : Number;
		public var offsetY : Number;
		
		public function Display( displayObject : DisplayObject , renderLayer : int = 2, offsetX : Number = 0, offsetY : Number = 0 )
		{
			this.displayObject = displayObject;
			this.renderLayer = renderLayer;
			this.offsetX = offsetX;
			this.offsetY = offsetY;
		}
	}
}
