package net.seansnyder.alphadefense.systems 
{
	import ash.core.Entity;
	import ash.tools.ListIteratingSystem;
	import flash.display.Bitmap;
	import net.seansnyder.alphadefense.assets.Images;
	import net.seansnyder.alphadefense.components.Display;
	import net.seansnyder.alphadefense.components.Position;
	import net.seansnyder.alphadefense.EntityCreator;
	import net.seansnyder.alphadefense.input.MousePoll;
	import net.seansnyder.alphadefense.nodes.ButtonNode;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ButtonSystem extends ListIteratingSystem 
	{
		private var listener:Function;
		private var mousePoll:MousePoll;
		private var buttonHighlight:Entity;
		private var isHighlightingButton:Boolean;
		private var endUpdate:Boolean;
		public function ButtonSystem(listener:Function, mousePoll:MousePoll, entitycreator:EntityCreator) 
		{
			super(ButtonNode, updateNode);
			this.listener = listener;
			this.mousePoll = mousePoll;
			this.buttonHighlight = entitycreator.createButtonHighlight();
			this.isHighlightingButton = false;
			this.endUpdate = false;
		}
		
		private function updateNode( node : ButtonNode, time : Number ) : void
		{
			//end early if button already reacted to mouse
			if (endUpdate) {
				if (node.next == null) {
					endUpdate = false;
				}
				return;
			}
			var buttonPos:Position = node.position;
			var mouseX:Number = mousePoll.getMouseX();
			var mouseY:Number = mousePoll.getMouseY();
			
			//if mouse within button boundaries, show button Highlight
			var highlight:Display = buttonHighlight.get(Display);
			if (mouseX >= buttonPos.position.x && mouseY >= buttonPos.position.y
				&& mouseX < buttonPos.position.x + buttonPos.width && mouseY < buttonPos.position.y + buttonPos.height) {
					//show highlight
					highlight.displayObject.visible = true;
					var highlightPos:Position = buttonHighlight.get(Position);
					highlightPos.position.x = buttonPos.position.x;
					highlightPos.position.y = buttonPos.position.y;
					isHighlightingButton = true;
					
					//if clicked, alert listener
					if(mousePoll.isDown()){
						this.listener( node.button.buttonID );
					}
					
					endUpdate = true;
				}
			else if(isHighlightingButton){ //disable highlight
				highlight.displayObject.visible = false;
				isHighlightingButton = false;
			}
		}
	}

}