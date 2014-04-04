package commons.models
{
	import commons.controllers.events.ModularConnectorEvent;
	import commons.models.vos.MessagesVO;

	import flash.events.IEventDispatcher;

	public class SomeModel
	{
		[Inject]
		public var dispatcher:IEventDispatcher;

		private var _someProperty:String;

		public function SomeModel()
		{
		}

		public function get someProperty():String
		{
			return _someProperty;
		}

		public function set someProperty(value:String):void
		{
			_someProperty = value;

			var messageVO:MessagesVO = new MessagesVO();
			messageVO.message = "SomeModel.someProperty changend " + value;
			dispatcher.dispatchEvent(new ModularConnectorEvent(ModularConnectorEvent.MODEL_DATA_CHANGED, messageVO));
		}
	}
}
