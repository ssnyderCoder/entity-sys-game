package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.seansnyder.alphadefense.Game;
	
	[SWF(width='600', height='450', frameRate='60', backgroundColor='#000000')]
	
	/**
	 * Required Main Class that initializes the game.
	 * @author Sean Snyder (Richard Lord's asteroids code utilized as base code)
	 */
	public class Main extends Sprite 
	{
		private var game : Game;
		
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ENTER_FRAME, init);
			game = new Game( this, stage.stageWidth, stage.stageHeight );
			game.start();
		}
		
	}
	
}