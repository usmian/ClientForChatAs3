package events 


{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author ф
	 */
	public class DispatcherGlobal
	{
		
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		private static var _listenerList:Dictionary = new Dictionary();
		
		public static function dispatch($event:EventsSocket):void 
		{
			_dispatcher.dispatchEvent($event);//event gain from function dispatch()
		}
		
		public static function listen($type:String,$handler:Function):void 
		{
			
			_listenerList[$type] = $handler;
			_dispatcher.addEventListener($type, $handler);//gain from function listen
		}
		
		public static function removeListener($type:String):void
		{
			
			if (_listenerList[$type]==null) //_listenerList[eventconstants.ON_READY="OnReady"]
			{
				return;
			}
			_dispatcher.removeEventListener($type, _listenerList[$type]);//(eventconstants.ON_READY = "OnReady",_listenerList["OnReady"]=OnReadyHandler)
			_listenerList[$type] = null;
		
		}
		
		public static function removeAllListeners():void 
		{
			for (var item:String in _listenerList) 
			{
				if (_listenerList[item]!=null) 
				{
					_dispatcher.removeEventListener(item, _listenerList[item]);
					_listenerList[item] == null;
				}
			}
		}
	}
}