package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TextView extends Sprite
	{
		
		private var label:TextField;
		
		public function TextView(lbl:TextField) 
		{
			label = lbl;
			configureLabel();
		}
		
		private function configureLabel():void {
			
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.color = 0xEE6622;
			format.size = 15;
			format.underline = true; 
			
			
			label.defaultTextFormat = format;
			label.text = label.text == null ? "" : label.text;
			label.autoSize = TextFieldAutoSize.LEFT;
			label.background = true;
			label.border = true;
			label.mouseEnabled = false;
			//label.setTextFormat(format);
			addChild(label);
		}	
		
		public function setText(s:String): void {
			label.text = s;
		}
		
	}

}