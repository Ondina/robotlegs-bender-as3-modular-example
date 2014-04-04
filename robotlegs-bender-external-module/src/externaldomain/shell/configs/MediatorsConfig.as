package externaldomain.shell.configs
{
	import externaldomain.shell.views.components.ExternalMessagesView;
	import externaldomain.shell.views.mediators.ExternalMessagesMediator;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;

	public class MediatorsConfig implements IConfig
	{
		[Inject]
		public var mediatorMap:IMediatorMap;

		public function configure():void
		{
			mediatorMap.map(ExternalMessagesView).toMediator(ExternalMessagesMediator);
		}
	}
}
