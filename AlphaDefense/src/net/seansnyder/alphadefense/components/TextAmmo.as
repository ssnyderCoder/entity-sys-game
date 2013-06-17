package net.seansnyder.alphadefense.components 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TextAmmo 
	{
		public var letters : TextField;
		public var isWord : Boolean = false;
		public var numLetters : uint = 0;
		public var isEnabled : Boolean = true;
		
		public function TextAmmo() {
			letters = new TextField();
		}
	}

}