package net.seansnyder.alphadefense.components 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class LetterBullet 
	{
		/**
		 * The alpha character contained in this bullet
		 */
		public var letter:String;
		
		public function LetterBullet(theLetter:String = "a") 
		{
			letter = theLetter.charAt(0);
		}
		
	}

}