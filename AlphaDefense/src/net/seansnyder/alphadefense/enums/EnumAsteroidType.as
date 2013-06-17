package net.seansnyder.alphadefense.enums 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public final class EnumAsteroidType 
	{
		//radius, hp, damage, speed, point value
		public static const SMALL_ASTEROID : AsteroidType = new AsteroidType(16, 1, 1, 75, 10);
		public static const MEDIUM_ASTEROID : AsteroidType = new AsteroidType(32, 10, 5, 30, 25);
		public static const LARGE_ASTEROID : AsteroidType = new AsteroidType(64, 100, 20, 10, 100);
		
	}

}