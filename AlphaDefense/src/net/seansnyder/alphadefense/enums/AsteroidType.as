package net.seansnyder.alphadefense.enums 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class AsteroidType 
	{
		private var _radius:Number;
		private var _hp:Number;
		private var _damage:Number;
		private var _pointValue:int;
		private var _speed:Number;
		public function AsteroidType(radius:Number = 10, hp:Number = 1, damage:Number = 1, speed:Number = 40, pointValue:int = 10  ) 
		{
			_radius = radius;
			_hp = hp;
			_damage = damage;
			_pointValue = pointValue;
			_speed = speed;
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function get hp():Number 
		{
			return _hp;
		}
		
		public function get damage():Number 
		{
			return _damage;
		}
		
		public function get pointValue():int 
		{
			return _pointValue;
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
	}

}