package view 
{
	import events.EventsSocket;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import events.DispatcherGlobal;
	import events.EventConstants;
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.serialization.json.JSONEncoder;
	/**
	 * ...
	 * @author ф
	 */
	public class WindowView
	{
		private var _skin:MovieClip;
		private var _generalText:TextField;
		private var _inputText:TextField;
		private var _memberText:TextField;
		private var _sendButton:SimpleButton;
		
		public function WindowView($skin:MovieClip) 
		{
			_skin = $skin;
			 MainClient.stageM.addChild(_skin);
			 
			_sendButton = _skin.getChildByName("btn_s") as SimpleButton;
			_inputText = _skin.getChildByName("inputText") as TextField;
			_generalText = _skin.getChildByName("generalText") as TextField;
			_memberText = _skin.getChildByName("nickText") as TextField;
		    _sendButton.addEventListener(MouseEvent.CLICK, button_click);
			DispatcherGlobal.listen(EventConstants.RECEIVE_DATA, onReceiveData);
			
		}
		
		private function onReceiveData(e:EventsSocket):void 
		{
			trace("receive data");
			var txt:String=com.adobe.serialization.json.JSON.encode(e.params);
			trace("this is"+txt);
			_generalText.text = txt;
		}
		
		private function button_click(e:MouseEvent):void 
		{
			if (_inputText.text.length > 0) 
			{
				
				var tx:String = com.adobe.serialization.json.JSON.encode(_inputText.text); 
				DispatcherGlobal.dispatch(new EventsSocket(EventConstants.OUTCOME_MESSAGE, tx));
				_inputText.text = " ";
			}
			
		}
		
	}

}