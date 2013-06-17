package net.seansnyder.alphadefense.graphics
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class SpaceshipDeathView extends Sprite implements Animatable
	{
		private var shape1 : Shape;
		private var shape2 : Shape;
		private var vel1 : Point;
		private var vel2 : Point;
		private var rot1 : Number;
		private var rot2 : Number;
		private var debrisShape : Array;
		private var debrisVel : Array;
		
		public function SpaceshipDeathView()
		{
			shape1 = new Shape();
			shape1.graphics.beginFill( 0xFFFFFF );
			shape1.graphics.moveTo( 10, 0 );
			shape1.graphics.lineTo( -7, 7 );
			shape1.graphics.lineTo( -4, 0 );
			shape1.graphics.lineTo( 10, 0 );
			shape1.graphics.endFill();
			addChild( shape1 );
			
			shape2 = new Shape();
			shape2.graphics.beginFill( 0xFFFFFF );
			shape2.graphics.moveTo( 10, 0 );
			shape2.graphics.lineTo( -7, -7 );
			shape2.graphics.lineTo( -4, 0 );
			shape2.graphics.lineTo( 10, 0 );
			shape2.graphics.endFill();
			addChild( shape2 );
			
			var numDebris : uint = getRandomNumDebris();
			debrisShape = new Array();
			for (var i:int = 0; i < numDebris; i++) {
				var shape:Shape = new Shape();
				shape.graphics.beginFill( 0xFFFFFF );
				shape.graphics.moveTo( 10, 0 );
				shape.graphics.drawCircle(0, 0, 2);
				shape.graphics.endFill();
				addChild(shape);
				debrisShape.push(shape);
			}
			
			vel1 = new Point( Math.random() * 10 - 5, Math.random() * 10 + 10 );
			vel2 = new Point( Math.random() * 10 - 5, - ( Math.random() * 10 + 10 ) );
			debrisVel = new Array();
			for (var u:int = 0; u < numDebris; u++) {
				var vel:Point = new Point((Math.random() * 6 - 3) * (Math.random() + 2) * 5, (Math.random() * 6 - 3)  * (Math.random() + 2) * 5);
				debrisVel.push(vel);
			}
			
			rot1 = Math.random() * 300 - 150;
			rot2 = Math.random() * 300 - 150;
		}
		
		private function getRandomNumDebris():uint
		{
			var n:Number = Math.random() * 10;
			if (n < 3) return 3; 
			else if (n < 5) return 5; 
			else if (n < 7) return 7; 
			else if (n < 8) return 9; 
			else if (n < 9) return 11; 
			else return 13; 
		}
		
		public function animate( time : Number ) : void
		{
			shape1.x += vel1.x * time;
			shape1.y += vel1.y * time;
			shape1.rotation += rot1 * time;
			shape2.x += vel2.x * time;
			shape2.y += vel2.y * time;
			shape2.rotation += rot2 * time;
			for (var i:int = 0; i < debrisShape.length; i++) {
				var shape:Shape = debrisShape[i];
				var vel:Point = debrisVel[i];
				shape.x += vel.x * time;
				shape.y += vel.y * time;
				vel.x *= 0.995;
				vel.y *= 0.995;
			}
		}
	}
}
