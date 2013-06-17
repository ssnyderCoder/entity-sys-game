package net.seansnyder.alphadefense.assets 
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public final class Sounds 
	{
		//[Embed(source = "../resources/sounds/Asteroid_Destroyed.mp3")] private static const soundAsteroidDestroyed:Class;
		
		public static const ASTEROID_DESTROYED_ID:int = 0;
		public static const ASTEROID_HIT_ID:int = 1;
		public static const DEFEAT_ID:int = 2;
		public static const LASER_SHOT_ID:int = 3;
		public static const SURFACE_HIT_ID:int = 4;
		public static const VICTORY_ID:int = 5;
		private static var soundArray:Array = new Array(
			new Sound(new URLRequest("../resources/sounds/Asteroid_Destroyed.mp3")),
			new Sound(new URLRequest("../resources/sounds/Asteroid_Hit.mp3")),
			new Sound(new URLRequest("../resources/sounds/Defeat.mp3")),
			new Sound(new URLRequest("../resources/sounds/Laser_Shoot.mp3")),
			new Sound(new URLRequest("../resources/sounds/Surface_Hit.mp3")),
			new Sound(new URLRequest("../resources/sounds/Victory.mp3")));
		private static var volumeTransform:SoundTransform = new SoundTransform(0.1);
			
		public static function playSound(soundID:int):Boolean {
			//if sound ID not within valid range, return false
			if (soundArray.length <= soundID || soundID < 0) {
				return false;
			}
			else {
				var sound:Sound = soundArray[soundID];
				sound.play(0, 0, volumeTransform);
				return true;
			}
		}
		
		
	}

}