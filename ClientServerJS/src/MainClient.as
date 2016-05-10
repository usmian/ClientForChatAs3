package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import view.WindowView;
	
	
	/**
	 * ...
	 * @author ф
	 */
	public class MainClient extends Sprite 
	{
		private var _window:WindowView;
		public static var stageM:Stage;
		
		public function MainClient() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stageM = stage;
			build();
			// entry point
		}
		
		private function build():void 
		{
			_window = new WindowView(new Fon());
			var sm:SocketModule = new SocketModule();
			
		}
		
	}
	
}