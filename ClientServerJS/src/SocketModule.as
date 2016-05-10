package 
{
	import events.DispatcherGlobal;
	import events.EventConstants;
	import events.EventsSocket;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.XMLSocket;
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONDecoder;
	
	/**
	 * ...
	 * @author ф
	 */
	public class SocketModule 
	{
		private var _xmlSocket:XMLSocket;
		
		public function SocketModule ($host:String = "127.0.0.1",$port:int = 8080) 
		{
			_xmlSocket = new XMLSocket();
			//socket listeners 127.0.0.1:8080
			DispatcherGlobal.listen(EventConstants.OUTCOME_MESSAGE, onOutcomeMessageHandler);
			_xmlSocket.addEventListener(Event.CONNECT, onConnectHandler);
			_xmlSocket.addEventListener(DataEvent.DATA, onIcomingDataHandler);
			_xmlSocket.addEventListener(Event.CLOSE, onCloseHandler);
			_xmlSocket.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			_xmlSocket.connect($host, $port);
			
			
		}
		
		private function onOutcomeMessageHandler(e:EventsSocket):void 
		{
			_xmlSocket.send(e.params);
		}
			
		private function onConnectHandler(e:Event):void 
		{
			trace("ServerConnected");
			DispatcherGlobal.dispatch(new EventsSocket(EventConstants.SERVER_CONNECTED));
		}
		
		private function onCloseHandler(e:Event):void 
		{
			DispatcherGlobal.dispatch(new EventsSocket(EventConstants.SERVER_CLOSED));
		}
		
		
		
		private function onErrorHandler(e:IOErrorEvent):void 
		{
			DispatcherGlobal.dispatch(new EventsSocket(EventConstants.SERVER_ERROR));
		}
		
		
		private function onIcomingDataHandler(e:DataEvent):void 
		{
			trace("IncomingData");
			var obj:Object = com.adobe.serialization.json.JSON.decode(e.data);//по другому не работает
			DispatcherGlobal.dispatch(new EventsSocket(EventConstants.RECEIVE_DATA, obj));
			//trace(e.data);
			//DispatcherGlobal.dispatch(new EventsSocket(EventConstants.OUTCOME_MESSAGE, obj));
			
		}
	}

}