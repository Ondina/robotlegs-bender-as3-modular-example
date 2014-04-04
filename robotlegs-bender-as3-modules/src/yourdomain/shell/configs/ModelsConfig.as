package yourdomain.shell.configs
{
	import commons.models.SomeModel;

	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;

	public class ModelsConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		public function configure():void
		{
			//library class
			injector.map(SomeModel).asSingleton();
		}
	}
}
