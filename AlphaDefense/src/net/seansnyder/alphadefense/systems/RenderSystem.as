package net.seansnyder.alphadefense.systems
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import net.seansnyder.alphadefense.components.Display;
	import net.seansnyder.alphadefense.components.Position;
	import net.seansnyder.alphadefense.nodes.RenderNode;

	public class RenderSystem extends System
	{
		private var container : DisplayObjectContainer;
		private var renderLayerIndexes : Array = [0,0,0,0,0]; //refactor at some point; will fail if layer above 4 used
		
		private var nodes : NodeList;
		
		public function RenderSystem( container : DisplayObjectContainer )
		{
			this.container = container;
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			nodes = engine.getNodeList( RenderNode );
			for( var node : RenderNode = nodes.head; node; node = node.next )
			{
				addToDisplay( node );
			}
			
			nodes.nodeAdded.add( addToDisplay );
			nodes.nodeRemoved.add( removeFromDisplay );
		}
		
		private function addToDisplay( node : RenderNode ) : void
		{
			var layer:int = node.display.renderLayer;
			container.addChildAt( node.display.displayObject, renderLayerIndexes[layer] );
			for (var i:int = layer; i < renderLayerIndexes.length; i++) {
				renderLayerIndexes[i]++;
			}
			
		}
		
		private function removeFromDisplay( node : RenderNode ) : void
		{
			var layer:int = node.display.renderLayer;
			container.removeChild( node.display.displayObject );
			for (var i:int = layer; i < renderLayerIndexes.length; i++) {
				renderLayerIndexes[i]--;
			}
		}
		
		override public function update( time : Number ) : void
		{
			var node : RenderNode;
			var position : Position;
			var display : Display;
			var displayObject : DisplayObject;
			
			for( node = nodes.head; node; node = node.next )
			{
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;
				
				displayObject.x = position.position.x + display.offsetX;
				displayObject.y = position.position.y + display.offsetY;
				displayObject.rotation = position.rotation * 180 / Math.PI;
			}
		}

		override public function removeFromEngine( engine : Engine ) : void
		{
			nodes.nodeAdded.remove(addToDisplay);
			nodes.nodeRemoved.remove(removeFromDisplay);
			for( var node : RenderNode = nodes.head; node; node = node.next )
			{
				removeFromDisplay(node);
			}
			nodes = null;
		}
	}
}
