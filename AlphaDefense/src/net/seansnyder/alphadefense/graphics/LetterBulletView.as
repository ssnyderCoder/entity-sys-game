package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.display.BlendMode;
	import flash.text.GridFitType;
	import flash.text.engine.TextBlock;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class LetterBulletView extends Sprite
	{
		
		public function LetterBulletView(txt:String, size:Number, color:uint) 
		{
			configureBulletShape(size, color);
			configureLetterLabel(txt, size);
		}
		
		private function configureBulletShape(size:Number, color:uint):void 
		{
			var circle:Shape = new Shape();
			circle.graphics.beginFill( color );
			circle.graphics.drawCircle( size * 4 / 7, size, size);
			circle.graphics.endFill();
			addChild(circle);
		}
		
		private function configureLetterLabel(txt:String, size:Number):void 
		{
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.color = 0xEEEEEE;
			format.size = size * 4 / 3;
			
			var label:TextField = new TextField();
			label.defaultTextFormat = format;
			label.text = txt;
			label.autoSize = TextFieldAutoSize.NONE;
			label.maxChars = 1;
			label.background = false;
			label.border = false;
			label.mouseEnabled = false;
			addChild(label);
		}
		
	}

}