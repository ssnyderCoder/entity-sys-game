package net.seansnyder.alphadefense.systems 
{
	import ash.core.NodeList;
	import ash.tools.ListIteratingSystem;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import flash.display.DisplayObject;
	import net.seansnyder.alphadefense.components.GameStatus;
	import net.seansnyder.alphadefense.Game;
	import net.seansnyder.alphadefense.nodes.TextAmmoNode;
	import net.seansnyder.alphadefense.components.TextAmmo;
	import net.seansnyder.alphadefense.WordList;
	import net.seansnyder.alphadefense.nodes.GameNode;
	import ash.core.System;
	import ash.core.Engine;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TextAmmoSystem extends System
	{
		private const COLOR_RED : uint = 0xEE2255;
		private const COLOR_GREEN : uint = 0x22EE55;
		private const MAX_WORD_LENGTH : int = 15;
		
		private var pressedLetters : Array = new Array();
		private var backspacePushed : Boolean = false;
		private var dispObj : DisplayObject;
		private var wordList : WordList;
		private var textAmmos : NodeList;
		private var games : NodeList;
		
		public function TextAmmoSystem( displayObj:DisplayObject , validWordsList:WordList) 
		{
			dispObj = displayObj;
			dispObj.addEventListener( KeyboardEvent.KEY_DOWN, updatePressedLetters, false, 0, true );
			wordList = validWordsList;
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			textAmmos = engine.getNodeList(TextAmmoNode);
			games = engine.getNodeList(GameNode);
		}
		
		override public function update( time : Number ) : void
		{
			var gameNode : GameNode;
			var textAmmoNode : TextAmmoNode;
			
			for( gameNode = games.head; gameNode; gameNode = gameNode.next )
			{
				var game:GameStatus = gameNode.game;
				for ( textAmmoNode = textAmmos.head; textAmmoNode; textAmmoNode = textAmmoNode.next )
				{
					//get TextAmmo from node
					var txtAmmo : TextAmmo = textAmmoNode.textAmmo;
					var process : Boolean = backspacePushed || pressedLetters.length > 0;
					
					//continue only if enabled and new letters have been added
					if(process && txtAmmo.isEnabled){
						//for each char in pressedLetters
						while(pressedLetters.length > 0){ 
							//add this letter to the TextAmmo component's character list
							var char : String = pressedLetters.pop();
							char = char.toLowerCase();
							txtAmmo.letters.appendText(char);
							txtAmmo.numLetters++;
						}
						
						if (backspacePushed) {
							var text : String = txtAmmo.letters.text;
							if (text.length > 0) {
								txtAmmo.letters.text = text.substring(0, text.length - 1);
								txtAmmo.numLetters--;
							}
							backspacePushed = false;
						}
						
						//if word has more than 15 letters trim
						if (txtAmmo.letters.text.length > MAX_WORD_LENGTH) {
							txtAmmo.letters.text = txtAmmo.letters.text.substr(0, MAX_WORD_LENGTH);
							txtAmmo.numLetters = MAX_WORD_LENGTH;
						}
						
						//if current set of letters spells out word and has not yet been used,
						//set as valid word
						if (wordList.isValidWord(txtAmmo.letters.text) && !game.wordsUsed[txtAmmo.letters.text]) {
							txtAmmo.isWord = true;
							txtAmmo.letters.textColor = COLOR_GREEN;
							trace(txtAmmo.letters.text + " is a valid dictionary word");
						}
						else {
							txtAmmo.isWord = false;
							txtAmmo.letters.textColor = COLOR_RED;
						}
					}
				}
			}
			
			//reset letter input
			while(pressedLetters.length > 0){
				pressedLetters.pop();
			}
		}
		
		
		private function updatePressedLetters(ev : KeyboardEvent) : void {
			//get the keycode from the Keyboard event
			var keyCode :uint = ev.keyCode;
			//trace("button " + keyCode + " detected");
			
			//If alphabetical character, add the respective char. to the array of recently pressed letters
			if (keyCode >= 65 && keyCode <= 90) {
				pressedLetters.push(String.fromCharCode(keyCode));
			}
			
			else if (keyCode == Keyboard.BACKSPACE) {
				backspacePushed = true;
			}
			
		}
		
		override public function removeFromEngine( engine : Engine ) : void
		{
			textAmmos = null;
			games = null;
			dispObj.removeEventListener( KeyboardEvent.KEY_DOWN, updatePressedLetters, false );
		}
	}

}