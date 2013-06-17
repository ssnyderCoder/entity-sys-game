package net.seansnyder.alphadefense
{
	import ash.core.Engine;
	import ash.core.Entity;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import net.seansnyder.alphadefense.assets.Images;
	import net.seansnyder.alphadefense.components.Animation;
	import net.seansnyder.alphadefense.components.Asteroid;
	import net.seansnyder.alphadefense.components.Button;
	import net.seansnyder.alphadefense.components.Collision;
	import net.seansnyder.alphadefense.components.Decay;
	import net.seansnyder.alphadefense.components.Display;
	import net.seansnyder.alphadefense.components.ExplosiveDamage;
	import net.seansnyder.alphadefense.components.GameStatus;
	import net.seansnyder.alphadefense.components.Health;
	import net.seansnyder.alphadefense.components.Label;
	import net.seansnyder.alphadefense.components.LetterBullet;
	import net.seansnyder.alphadefense.components.Motion;
	import net.seansnyder.alphadefense.components.Position;
	import net.seansnyder.alphadefense.components.Reticle;
	import net.seansnyder.alphadefense.components.Surface;
	import net.seansnyder.alphadefense.components.TankCannon;
	import net.seansnyder.alphadefense.components.TextAmmo;
	import net.seansnyder.alphadefense.enums.AsteroidType;
	import net.seansnyder.alphadefense.graphics.AsteroidView;
	import net.seansnyder.alphadefense.graphics.ButtonView;
	import net.seansnyder.alphadefense.graphics.ExplosionView;
	import net.seansnyder.alphadefense.graphics.GameOverView;
	import net.seansnyder.alphadefense.graphics.LetterBulletView;
	import net.seansnyder.alphadefense.graphics.MoonView;
	import net.seansnyder.alphadefense.graphics.ReticleView;
	import net.seansnyder.alphadefense.graphics.StarView;
	import net.seansnyder.alphadefense.graphics.SurfaceView;
	import net.seansnyder.alphadefense.graphics.TankCannonView;
	import net.seansnyder.alphadefense.graphics.TextView;
	import net.seansnyder.alphadefense.states.ButtonIDs;

	//import flash.ui.Keyboard;
	
	public class EntityCreator
	{
		private var engine : Engine;
		private var gameConfig : GameConfig;
		
		public function EntityCreator( engine : Engine , config :GameConfig)
		{
			this.engine = engine;
			this.gameConfig = config;
		}
		
		public function destroyEntity( entity : Entity ) : void
		{
			engine.removeEntity( entity );
		}
		
		public function createGame() : Entity
		{
			//create game
			var game : Entity = new Entity().add(new GameStatus());
			engine.addEntity(game);
			
			//create surface
			createSurface();
			
			//create background
			for (var i:int = 0; i < 12; i++) {
				createStar(12 + Math.random() * (gameConfig.width - 24), 12 + Math.random() * (gameConfig.height - 66));
			}
			createMoon();
			
			//create text box that holds letter ammo
			createAmmoDisplay();
			
			
			//create cannon
			createCannon();
			
			//create mouse reticle
			createMouseReticle();
			
			return game;
		}
		
		private function createMouseReticle():Entity
		{
			var reticle : Entity = new Entity()
					.add(new Reticle())
					.add(new Position(25, 25))
					.add(new Display(new ReticleView(), 3));
			engine.addEntity(reticle);
			return reticle;
		}
		
		private function createCannon():Entity
		{
			var tankCannon : Entity = new Entity()
					.add(new TankCannon(1, 8, 0))
					.add(new Position(gameConfig.width / 2, gameConfig.height - 50))
					.add(new Display(new TankCannonView()));
			engine.addEntity(tankCannon);
			return tankCannon;
		}
		
		private function createAmmoDisplay():Entity
		{
			var txtAmmo : TextAmmo = new TextAmmo();
			var txtView : TextView = new TextView(txtAmmo.letters);
			var text : Entity = new Entity()
					.add(txtAmmo)
					.add(new Display(txtView))
					.add(new Position(gameConfig.width / 2, gameConfig.height - 30));
			engine.addEntity(text);
			return text;
		}
		
		
		public function createLetterBullet(letter:String, cannon:TankCannon, parentPosition:Position,
			displacement : Number = 0, power : Number = 1 , color : uint = 0xFF2244) : Entity {
				
			var cos : Number = Math.cos( parentPosition.rotation );
			var sin : Number = Math.sin( parentPosition.rotation );
			var rotationDisplace : Number = (Math.random() * 2 * displacement) - displacement;
			var cosDisplaced : Number = Math.cos( parentPosition.rotation + rotationDisplace);
			var sinDisplaced : Number = Math.sin( parentPosition.rotation + rotationDisplace);
			if (sinDisplaced > 0) sinDisplaced = 0;
			//trace("Bullet " + letter + " : cos=" + cosDisplaced + " sin=" + sinDisplaced);
			var bulletRadius : Number = 9;
			var bullet : Entity = new Entity()
				.add( new LetterBullet(letter) )
				.add( new ExplosiveDamage(power) )
				.add( new Position(
					cos * cannon.offsetFromParent.x - sin * cannon.offsetFromParent.y + parentPosition.position.x,
					sin * cannon.offsetFromParent.x + cos * cannon.offsetFromParent.y + parentPosition.position.y,
					bulletRadius*2, bulletRadius*2) )
				.add( new Collision(bulletRadius) )
				.add( new Motion( cosDisplaced * 150, sinDisplaced * 150, 0, 0 ) )
				.add( new Display( new LetterBulletView(letter, bulletRadius, color) ) );
			engine.addEntity( bullet );
			return bullet;
		}
		
		public function createExplosion(xp:Number, yp:Number, size:Number = 25) : Entity{
			var explosionView:ExplosionView = new ExplosionView(size);
			var explode : Entity = new Entity()
				.add(new Animation(explosionView))
				.add(new Display(explosionView))
				.add(new Position(xp, yp))
				.add(new Decay(1 * (size / 25)));
			engine.addEntity(explode);
			return explode;
		}
		
		private function createSurface() : Entity {
			var surface : Entity = new Entity()
				.add(new Position(0, gameConfig.height - 40))
				.add(new Display(new SurfaceView(gameConfig.width, 40), 1))
				.add(new Health(100, false)) //does not die when hp is zero
				.add(new Surface());
			engine.addEntity(surface);
			return surface;
		}
		
		public function createAsteroid(asteroidType:AsteroidType) : Entity {
			var radius:Number = asteroidType.radius;
			var asteroidHp:Number = asteroidType.hp;
			var damage:Number = asteroidType.damage;
			var pointValue:int = asteroidType.pointValue;
			var speed:Number = asteroidType.speed;
			var xMotion:Number = (Math.random() < 0.5 ? speed : -speed) * (0.5 + Math.random());
			var yMotion:Number = speed * (0.75 + (Math.random() / 2.0));
			var asteroidImg : Bitmap = new Images.ASTEROID as Bitmap;
			asteroidImg.scaleX = radius / 16; //based upon EnumAsteroid
			asteroidImg.scaleY = radius / 16; 
			asteroidImg.x -= radius;
			asteroidImg.y -= radius;
			var astSprite:Sprite = new Sprite();
			astSprite.addChild(asteroidImg);
			//scale according to size
			var asteroid:Entity = new Entity()
				.add( new Position((radius * 2) + (Math.random() * (gameConfig.width - (radius * 2))), -radius * 2, radius * 2, radius * 2) )
				.add( new Asteroid(pointValue) )
				.add( new Collision(radius) )
				.add( new Health( asteroidHp) )
				.add( new ExplosiveDamage(damage) )
				.add( new Motion( xMotion, yMotion, Math.random() * 2 - 1, 0 , true) )
				//.add( new Display( new AsteroidView(radius, 0x999968), 2, radius, radius) );
				.add( new Display( astSprite, 2, radius, radius) ); 
			engine.addEntity( asteroid);
			return asteroid;
		}
		
		public function createMoon() : Entity {
			var moon : Entity = new Entity()
				.add(new Position(100, 100))
				.add(new Display(new Images.MOON as Bitmap, 1));
			engine.addEntity(moon);
			return moon;
		}
		
		public function createStar(x:Number, y:Number) : Entity {
			var starview:StarView = new StarView();
			var star : Entity = new Entity()
				.add(new Position(x, y))
				.add(new Display(starview, 1))
				.add(new Animation(starview));
			engine.addEntity(star);
			return star;
		}
		
		public function createSurvivalGameLabels(timerLabel:Label, surfaceHpLabel:Label, pointsLabel:Label): void {
			var timerDisplay:Entity = new Entity()
				.add(timerLabel)
				.add(new Position(20, gameConfig.height - 40))
				.add(new Display(new TextView(timerLabel.text)));
			engine.addEntity(timerDisplay);
			
			var hpDisplay:Entity = new Entity()
				.add(surfaceHpLabel)
				.add(new Position(gameConfig.width - 110, gameConfig.height - 40))
				.add(new Display(new TextView(surfaceHpLabel.text)));
			engine.addEntity(hpDisplay);
			
			var pointsDisplay:Entity = new Entity()
				.add(pointsLabel)
				.add(new Position(120, gameConfig.height - 40))
				.add(new Display(new TextView(pointsLabel.text)));
			engine.addEntity(pointsDisplay);
		}
		
		public function createButton(x:Number, y:Number, buttonID:int, buttonBitmap:Bitmap) : Entity{
			var button:Entity = new Entity()
				.add(new Position(x, y, buttonBitmap.width, buttonBitmap.height))
				.add(new Button(buttonID))
				.add(new Display(buttonBitmap, 3));
			engine.addEntity(button);
			return button;
		}
		
		public function createGameOverScreen(x:Number, y:Number, points:Number): void {
			//create background, label, and 2 separate buttons
			var menuBackground:Bitmap = new Images.MENU_BACKGROUND() as Bitmap;
			menuBackground.width = 256;
			menuBackground.height = 256;
			var background:Entity = new Entity()
				.add(new Position(x, y))
				.add(new Display(menuBackground, 3));
			engine.addEntity(background);
			
			var pointsLabel:Label = new Label();
			pointsLabel.text.text = "Score: " + points;
			var score:Entity = new Entity()
				.add(new Position(x + 64, y + 64))
				.add(pointsLabel)
				.add(new Display(new TextView(pointsLabel.text), 3));
			engine.addEntity(score);
			
			var menuButton:Bitmap = new Images.BUTTON_MAIN_MENU() as Bitmap;
			menuButton.scaleX = 0.5;
			menuButton.scaleY = 0.5;
			var replayButton:Bitmap = new Images.BUTTON_REPLAY() as Bitmap;
			replayButton.scaleX = 0.5;
			replayButton.scaleY = 0.5;
			
			this.createButton(x + 64, y + 128, ButtonIDs.MENU_ID, menuButton);
			this.createButton(x + 64, y + 196, ButtonIDs.REPLAY_ID, replayButton);
			
		}
		
		public function createButtonHighlight():Entity {
			var highlightImg:Bitmap = new Images.BUTTON_HIGHLIGHT as Bitmap;
			highlightImg.visible = false;
			highlightImg.scaleX = 0.5;
			highlightImg.scaleY = 0.5;
			var buttonHighlight:Entity = new Entity()
				.add(new Position(0, 0))
				.add(new Display(highlightImg, 4));
			engine.addEntity(buttonHighlight);
			return buttonHighlight;
		}
	}
}
