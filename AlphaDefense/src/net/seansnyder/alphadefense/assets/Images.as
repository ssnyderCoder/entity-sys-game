package net.seansnyder.alphadefense.assets 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class Images 
	{
		//buttons
		[Embed(source = "/../resources/images/ButtonHighLight.png")] public static const BUTTON_HIGHLIGHT:Class;
		[Embed(source = "/../resources/images/ExitGameButton.png")] public static const BUTTON_EXIT_GAME:Class;
		[Embed(source = "/../resources/images/MainMenuButton.png")] public static const BUTTON_MAIN_MENU:Class;
		[Embed(source = "/../resources/images/StartGameButton.png")] public static const BUTTON_START_GAME:Class;
		[Embed(source = "/../resources/images/ReplayButton.png")] public static const BUTTON_REPLAY:Class;
		[Embed(source = "/../resources/images/MenuBackground.png")] public static const MENU_BACKGROUND:Class;
		
		//entities
		[Embed(source = "/../resources/images/Asteroid.png")] public static const ASTEROID:Class;
		[Embed(source = "/../resources/images/GreenReticle.png")] public static const RETICLE_GREEN:Class;
		[Embed(source = "/../resources/images/RedReticle.png")] public static const RETICLE_RED:Class;
		
		//background
		[Embed(source = "/../resources/images/Star.png")] public static const STAR:Class;
		[Embed(source = "/../resources/images/Moon.png")] public static const MOON:Class;

		//TODO: Add more images
		//Tank (32x32)
		//Reticle (16x16)
		//TankCannon (16x4)
		//Explosion (4x4 * 8)
		//Letter (USE FONT)
		//Bullet (16x16)
		//Surface (Make up using 32x32 tiles)
		//Moon (64x64)
		//Background (128x256)
	}

}