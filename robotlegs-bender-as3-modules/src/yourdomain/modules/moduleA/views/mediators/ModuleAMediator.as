package yourdomain.modules.moduleA.views.mediators
{
	import commons.controllers.events.ModularConnectorEvent;

	import robotlegs.bender.bundles.mvcs.Mediator;

	import yourdomain.modules.moduleA.views.components.ModuleAView;

	public class ModuleAMediator extends Mediator
	{
		[Inject]
		public var view:ModuleAView;

		override public function initialize():void
		{
			addViewListener(ModularConnectorEvent.VIEW_TO_MEDIATOR_MESSAGE, onMessageSent, ModularConnectorEvent);
			addContextListener(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE, onMessageReceived, ModularConnectorEvent);
		}

		private function onMessageSent(event:ModularConnectorEvent):void
		{
			dispatch(new ModularConnectorEvent(ModularConnectorEvent.MODULE_TO_SHELL_MESSAGE, event.messagesVO));
		}

		private function onMessageReceived(event:ModularConnectorEvent):void
		{
			view.onMessageReceived(event.messagesVO.message);
		}
	}
}
