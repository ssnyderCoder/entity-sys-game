package net.seansnyder.alphadefense.graphics 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import net.seansnyder.alphadefense.assets.Images;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ReticleView extends Sprite
	{
		
		public function ReticleView(isGreenReticle : Boolean = true)
		{
			if (isGreenReticle) {
				this.addChild(new Images.RETICLE_GREEN as Bitmap);
			}
			else {
				this.addChild(new Images.RETICLE_RED as Bitmap);
			}
		}
		
	}

}