package externaldomain.shell.configs
{
	import externaldomain.shell.controllers.commands.ModuleCommand;
	import externaldomain.shell.controllers.events.ModuleLocalEvent;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.framework.api.IConfig;

	public class ControllersConfig implements IConfig
	{
		[Inject]
		public var commandMap:IEventCommandMap;

		public function configure():void
		{
			commandMap.map(ModuleLocalEvent.TRIGGER_MODULE_COMMAND, ModuleLocalEvent).toCommand(ModuleCommand);
		}
	}
}
