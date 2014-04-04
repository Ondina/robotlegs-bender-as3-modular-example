package commons.controllers.events
{
	import commons.models.vos.MessagesVO;

	import flash.events.Event;

	public class ModularConnectorEvent extends Event
	{
		public static const SHELL_TO_MODULES_MESSAGE:String = "shellToModulesMessage";
		public static const MODULE_TO_SHELL_MESSAGE:String = "moduleToShellMessage";

		public static const MODEL_DATA_CHANGED:String = "modelDataChanged";

		public static const VIEW_TO_MEDIATOR_MESSAGE:String = "viewToMediatorMessage";

		private var _messagesVO:MessagesVO;

		public function ModularConnectorEvent(type:String, messagesVO:MessagesVO = null, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_messagesVO = messagesVO;
		}

		public function get messagesVO():MessagesVO
		{
			return _messagesVO;
		}

		override public function clone():Event
		{
			return new ModularConnectorEvent(type, messagesVO, bubbles, cancelable);
		}
	}
}
