package yourdomain.shell.controllers.commands
{
	import commons.models.SomeModel;
	
	import yourdomain.shell.controllers.events.ShellLocalEvent;

	public class ShellCommand
	{
		[Inject]
		public var someModel:SomeModel;
		
		[Inject]
		public var event:ShellLocalEvent;

		public function execute():void
		{
			trace("ShellCommand.execute()");
			
			someModel.someProperty = event.payload;
		}
	}
}