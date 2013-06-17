package net.seansnyder.alphadefense.enums 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class Difficulty 
	{
		private var _spawnRateIncrease:Number;
		
		public function Difficulty(spawnRateIncrease:Number = 0.01) 
		{
			_spawnRateIncrease = spawnRateIncrease;
		}
		
		public function get spawnRateIncrease():Number 
		{
			return _spawnRateIncrease;
		}
		
	}

}