package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ButtonView extends Sprite
	{
		private static const COLOR_GRAY:uint = 0x999999;
		
		public function ButtonView(txt:String) 
		{
			//draw button
			var rectangle:Shape = new Shape();
			rectangle.graphics.beginFill( COLOR_GRAY );
			var rectWdith:int = txt.length > 10 ? txt.length * 10 : 100;
			rectangle.graphics.drawRect(0, 0, rectWdith, 50);
			rectangle.graphics.endFill();
			addChild(rectangle);
			
			//add text to button
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.color = 0xEEEEEE;
			format.size = 13;
			format.align = TextFormatAlign.CENTER;
			var label:TextField = new TextField();
			label.defaultTextFormat = format;
			label.text = txt;
			label.autoSize = TextFieldAutoSize.NONE;
			label.mouseEnabled = false;
			label.width = rectWdith;
			label.y += 12.5;
			addChild(label);
		}
		
	}

}