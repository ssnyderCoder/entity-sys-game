package net.seansnyder.alphadefense.components 
{
	import flash.utils.Dictionary;
	import net.seansnyder.alphadefense.enums.Difficulty;
	import net.seansnyder.alphadefense.enums.EnumDifficulty;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class GameStatus 
	{
		public var points : int = 0;
		public var time : Number = 0;
		public var wordsUsed : Dictionary = new Dictionary();
		public var difficulty : Difficulty = EnumDifficulty.EASY_DIFFICULTY;
	}

}