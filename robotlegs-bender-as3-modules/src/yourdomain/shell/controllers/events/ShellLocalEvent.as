package yourdomain.shell.controllers.events
{
	import flash.events.Event;
	
	public class ShellLocalEvent extends Event
	{
		public static const TRIGGER_SHELL_COMMAND:String = "triggerShellCommand";
		
		public static const DO_SOMETHING:String = "dosomething";
		
		private var _payload:String;
		
		public function ShellLocalEvent(type:String, payload:String = null, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			_payload = payload;
			super(type, bubbles, cancelable);
		}
		
		public function get payload():String
		{
			return _payload;
		}
		
		override public function clone():Event
		{
			return new ShellLocalEvent(type, payload, bubbles, cancelable);
		}
	}
}
