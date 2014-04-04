package externaldomain.shell.views.components
{
	import commons.views.components.LoggerView;
	import commons.views.components.MessagesView;

	import flash.display.Sprite;

	public class ExternalMessagesView extends Sprite
	{
		private var messagesView:MessagesView;
		private var loggerView:LoggerView;

		public function ExternalMessagesView()
		{
			messagesView = new MessagesView();
			addChild(messagesView);

			loggerView = new LoggerView();
			loggerView.x = 290;
			loggerView.panelTitel = "Module Logger";
			addChild(loggerView);
		}

		public function onMessageReceived(message:String):void
		{
			messagesView.onMessageReceived(message);
		}

		public function logMessage(message:String):void
		{
			loggerView.onMessageReceived(message);
		}
	}
}
