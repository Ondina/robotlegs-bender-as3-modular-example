package yourdomain.shell.configs
{
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	
	import yourdomain.shell.views.components.ShellMessagesView;
	import yourdomain.shell.views.mediators.ShellMessagesMediator;

	public class MediatorsConfig implements IConfig
	{
		[Inject]
		public var mediatorMap:IMediatorMap;

		public function configure():void
		{
			mediatorMap.map(ShellMessagesView).toMediator(ShellMessagesMediator);	
		}
	}
}
