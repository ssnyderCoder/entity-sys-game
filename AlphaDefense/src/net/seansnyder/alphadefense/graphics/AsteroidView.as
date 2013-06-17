package net.seansnyder.alphadefense.graphics
{
	import flash.display.Shape;

	public class AsteroidView extends Shape
	{
		public function AsteroidView( radius : Number , color : uint = 0xFFFFFF)
		{
			var angle : Number = 0;
			graphics.beginFill( color );
			graphics.moveTo( radius, 0 );
			while( angle < Math.PI * 2 )
			{
				var length : Number = ( 0.75 + Math.random() * 0.25 ) * radius;
				var posX : Number = Math.cos( angle ) * length;
				var posY : Number = Math.sin( angle ) * length;
				graphics.lineTo( posX, posY );
				angle += Math.random() * 0.5;
			}
			graphics.lineTo( radius, 0 );
			graphics.endFill();
		}
	}
}
