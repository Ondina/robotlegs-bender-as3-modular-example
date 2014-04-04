package externaldomain.shell.views.mediators
{
	import commons.controllers.events.ModularConnectorEvent;

	import externaldomain.shell.controllers.events.ModuleLocalEvent;
	import externaldomain.shell.views.components.ExternalMessagesView;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class ExternalMessagesMediator extends Mediator
	{
		[Inject]
		public var view:ExternalMessagesView;

		override public function initialize():void
		{
			addViewListener(ModularConnectorEvent.VIEW_TO_MEDIATOR_MESSAGE, onMessageSent, ModularConnectorEvent);
			addContextListener(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE, onMessageReceived, ModularConnectorEvent);
			addContextListener(ModularConnectorEvent.MODEL_DATA_CHANGED, onModelDataChanged, ModularConnectorEvent);
		}

		private function onModelDataChanged(event:ModularConnectorEvent):void
		{
			view.logMessage(event.messagesVO.message);
		}

		private function onMessageSent(event:ModularConnectorEvent):void
		{
			dispatch(new ModuleLocalEvent(ModuleLocalEvent.TRIGGER_MODULE_COMMAND, " - from external module"));
			dispatch(new ModularConnectorEvent(ModularConnectorEvent.MODULE_TO_SHELL_MESSAGE, event.messagesVO));
		}

		private function onMessageReceived(event:ModularConnectorEvent):void
		{
			view.onMessageReceived(event.messagesVO.message);
		}
	}
}
