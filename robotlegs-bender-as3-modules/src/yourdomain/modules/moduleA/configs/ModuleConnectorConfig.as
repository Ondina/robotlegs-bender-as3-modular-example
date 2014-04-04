package yourdomain.modules.moduleA.configs
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
			// MODULE A LISTENS onDefaultChannel for Shell's event
			//============================================================================
			/*moduleConnector.onDefaultChannel()
				.receiveEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);*/
			//============================================================================
			// MODULE A LISTENS on 'parent-child-channel' for SHELL_TO_MODULES_MESSAGE
			//============================================================================
			moduleConnector.onChannel('parent-child-channel')
				.receiveEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);	
			//============================================================================
			// MODULE A dispatches on 'parent-child-channel' channel MODULE_TO_SHELL_MESSAGE
			//============================================================================
			moduleConnector.onChannel('parent-child-channel')
				.relayEvent(ModularConnectorEvent.MODULE_TO_SHELL_MESSAGE);						
		}
	}
}
