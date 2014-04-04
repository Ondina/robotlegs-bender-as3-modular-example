package yourdomain.modules.moduleA.configs
{
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;

	import yourdomain.modules.moduleA.views.components.ModuleAView;
	import yourdomain.modules.moduleA.views.mediators.ModuleAMediator;

	public class MediatorsConfig implements IConfig
	{
		[Inject]
		public var mediatorMap:IMediatorMap;

		public function configure():void
		{
			mediatorMap.map(ModuleAView).toMediator(ModuleAMediator);
		}
	}
}
