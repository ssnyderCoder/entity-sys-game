/*
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2007
 * Version: 1.0.2
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package net.seansnyder.alphadefense.input 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class MousePoll 
	{
		private var leftMouseButtonDown : Boolean = false;
		private var mousePosition : Point = new Point(0, 0);
		
		/**
		 * Constructor
		 * 
		 * @param displayObj a display object on which to test listen for mouse events. To catch all key events use the stage.
		 */
		public function MousePoll( displayObj:DisplayObject ) 
		{
			displayObj.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownListener, false, 0, true );
			displayObj.addEventListener( MouseEvent.MOUSE_UP, mouseUpListener, false, 0, true );
			displayObj.addEventListener( MouseEvent.MOUSE_MOVE, mouseMoveListener, false, 0, true );
			displayObj.addEventListener( Event.ACTIVATE, activateListener, false, 0, true );
			displayObj.addEventListener( Event.DEACTIVATE, deactivateListener, false, 0, true );
		}
		
		private function mouseMoveListener( ev:MouseEvent ):void 
		{
			mousePosition.x = ev.stageX;
			mousePosition.y = ev.stageY;
		}
		
		private function mouseDownListener( ev:MouseEvent ):void
		{
			if (ev.buttonDown) leftMouseButtonDown = true;
			
			//trace("MousePoll: button pushed : " + ev.target);
		}
		
		private function mouseUpListener( ev:MouseEvent ):void
		{
			if (!ev.buttonDown) leftMouseButtonDown = false;
			
			//trace("MousePoll: button let go : " + ev.target);
		}
		
		private function activateListener( ev:Event ):void
		{
			clearButtonStates();
		}

		private function deactivateListener( ev:Event ):void
		{
			clearButtonStates();
		}
		
		private function clearButtonStates():void {
			leftMouseButtonDown = false;
		}
		

		public function isDown():Boolean
		{
			return leftMouseButtonDown;
		}
		

		public function isUp():Boolean
		{
			return !leftMouseButtonDown;
		}
		
		public function getMouseX():Number {
			return mousePosition.x;
		}
		
		public function getMouseY():Number {
			return mousePosition.y;
		}
		
	}

}