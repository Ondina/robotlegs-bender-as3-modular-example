package externaldomain.shell.controllers.events
{
	import flash.events.Event;

	public class ModuleLocalEvent extends Event
	{
		public static const TRIGGER_MODULE_COMMAND:String = "triggerModuleCommand";

		private var _payload:String;

		public function ModuleLocalEvent(type:String, payload:String = null, bubbles:Boolean = true, cancelable:Boolean = false)
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
			return new ModuleLocalEvent(type, payload, bubbles, cancelable);
		}
	}
}
