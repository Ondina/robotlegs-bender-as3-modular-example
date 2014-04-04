package yourdomain.shell.configs
{
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.framework.api.IConfig;

	import yourdomain.shell.controllers.commands.ShellCommand;
	import yourdomain.shell.controllers.events.ShellLocalEvent;

	public class ControllersConfig implements IConfig
	{
		[Inject]
		public var commandMap:IEventCommandMap;

		public function configure():void
		{
			commandMap.map(ShellLocalEvent.TRIGGER_SHELL_COMMAND, ShellLocalEvent).toCommand(ShellCommand);
		}
	}
}
