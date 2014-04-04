package externaldomain.shell.controllers.commands
{
	import commons.models.SomeModel;
	
	import externaldomain.shell.controllers.events.ModuleLocalEvent;

	public class ModuleCommand
	{
		[Inject]
		public var someModel:SomeModel;

		[Inject]
		public var event:ModuleLocalEvent;

		public function execute():void
		{
			someModel.someProperty = event.payload;
		}
	}
}
