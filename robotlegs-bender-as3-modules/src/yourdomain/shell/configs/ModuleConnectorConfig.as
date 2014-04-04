package yourdomain.shell.configs
{
	import commons.controllers.events.ModularConnectorEvent;

	import robotlegs.bender.extensions.modularity.api.IModuleConnector;
	import robotlegs.bender.framework.api.IConfig;

	public class ModuleConnectorConfig implements IConfig
	{
		[Inject]
		public var moduleConnector:IModuleConnector;

		public function configure():void
		{
			//============================================================================
			// SHELL DISPATCHES onDefaultChannel
			//============================================================================
			/*moduleConnector.onDefaultChannel()
				.relayEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);*/

			//============================================================================
			// SHELL DISPATCHES ON parent-child-channel SHELL_TO_MODULES_MESSAGE event type
			//============================================================================
			moduleConnector.onChannel('parent-child-channel')
				.relayEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);

			//============================================================================
			// SHELL LISTENS ON parent-child-channel for MODULE_TO_SHELL_MESSAGE event type
			//============================================================================
			moduleConnector.onChannel('parent-child-channel')
				.receiveEvent(ModularConnectorEvent.MODULE_TO_SHELL_MESSAGE);

			//============================================================================
			// SomeModel is a library class shared by the shell and the external module
			// SomeModel is mapped in the shell's context
			// SomeModel dispatches ModularConnectorEvent.MODEL_DATA_CHANGED on the shell's
			// shared event dispatcher
			// the shell's moduleConnector redispatches(relays) the event on 'model-channel'
			// and the module listens on this channel
			//============================================================================
			moduleConnector.onChannel('model-channel')
				.relayEvent(ModularConnectorEvent.MODEL_DATA_CHANGED);
		}
	}
}
