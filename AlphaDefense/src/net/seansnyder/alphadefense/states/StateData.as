package net.seansnyder.alphadefense.states 
{
	import flash.utils.Dictionary;
	/**
	 * This class is used to hold any data that must be passed from one state to another,
	 * specifically information that a just now activated state receives from the previous state.
	 * @author Sean Snyder
	 *
	 */
	public class StateData 
	{
		private var data:Dictionary;
		
		public function StateData() 
		{
			data = new Dictionary();
		}
		
		public function addData(name:String, obj:Object):void{
			data.put(name, obj);
			data[name] = obj;
		}
		
		public function getData(name:String):Object{
			return data[name];
		}
	}

}