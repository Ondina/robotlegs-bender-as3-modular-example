
package externaldomain.shell.configs
{
	import commons.controllers.events.ModularConnectorEvent;

	import robotlegs.bender.extensions.modularity.api.IModuleConnector;
	import robotlegs.bender.framework.api.IConfig;

	public class ExternalConnectorConfig implements IConfig
	{
		[Inject]
		public var moduleConnector:IModuleConnector;

		public function configure():void
		{
			//============================================================================
			// MODULE DISPATCHES ON parent-child-channel to  MODULE_TO_SHELL_MESSAGE event type
			//============================================================================
			moduleConnector.onChannel('parent-child-channel')
				.relayEvent(ModularConnectorEvent.MODULE_TO_SHELL_MESSAGE);

			//============================================================================
			// MODULE LISTENS ON parent-child-channel for SHELL_TO_MODULES_MESSAGE event type
			//============================================================================
			moduleConnector.onChannel('parent-child-channel')
				.receiveEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);

			//============================================================================
			// MODULE LISTENS ON onDefaultChannel
			//============================================================================
			/*moduleConnector.onDefaultChannel()
				.receiveEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);*/

			//============================================================================
			// SomeModel is a library class shared by the shell and the external module
			// SomeModel is mapped in the shell's context
			// SomeModel dispatches ModularConnectorEvent.MODEL_DATA_CHANGED on the shell's
			// shared event dispatcher
			// the shell's moduleConnector redispatches((relays) the event on 'model-channel'
			// and the module listens on this channel
			//============================================================================
			moduleConnector.onChannel('model-channel')
				.receiveEvent(ModularConnectorEvent.MODEL_DATA_CHANGED);
		}
	}
}
