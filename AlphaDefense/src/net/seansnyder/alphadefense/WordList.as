package net.seansnyder.alphadefense 
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class WordList 
	{
		
		private var wordDictionary : Dictionary = new Dictionary();
		
		public function WordList() 
		{
			
		}
		public function loadTextFile(fileName : String ): void {
			var myTextLoader:URLLoader = new URLLoader();
			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			myTextLoader.load(new URLRequest(fileName));
		}
		
		private function onLoaded(e:Event):void {
			var arrayOfLines:Array = e.target.data.split(/\n/);
			for each(var word:String in arrayOfLines) {
				wordDictionary[word.toLowerCase()] = true;
			}
		}
		
		public function isValidWord( word : String): Boolean {
			if (wordDictionary[word]) return true;
			else return false;
		}
	}

}