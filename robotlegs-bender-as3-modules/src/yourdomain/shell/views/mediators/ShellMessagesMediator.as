package yourdomain.shell.views.mediators
{
	import commons.controllers.events.ModularConnectorEvent;

	import robotlegs.bender.bundles.mvcs.Mediator;

	import yourdomain.shell.controllers.events.ShellLocalEvent;
	import yourdomain.shell.views.components.ShellMessagesView;

	public class ShellMessagesMediator extends Mediator
	{
		[Inject]
		public var view:ShellMessagesView;

		override public function initialize():void
		{
			addViewListener(ModularConnectorEvent.VIEW_TO_MEDIATOR_MESSAGE, onMessageSent, ModularConnectorEvent);
			addContextListener(ModularConnectorEvent.MODULE_TO_SHELL_MESSAGE, onMessageReceived, ModularConnectorEvent);
			addContextListener(ModularConnectorEvent.MODEL_DATA_CHANGED, onModelDataChanged, ModularConnectorEvent);
		}

		private function onModelDataChanged(event:ModularConnectorEvent):void
		{
			view.logMessage(event.messagesVO.message);
		}

		private function onMessageSent(event:ModularConnectorEvent):void
		{
			dispatch(new ShellLocalEvent(ShellLocalEvent.TRIGGER_SHELL_COMMAND, " - from shell"));
			dispatch(new ModularConnectorEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE, event.messagesVO));
		}

		private function onMessageReceived(event:ModularConnectorEvent):void
		{
			view.onMessageReceived(event.messagesVO.message);
		}
	}
}
