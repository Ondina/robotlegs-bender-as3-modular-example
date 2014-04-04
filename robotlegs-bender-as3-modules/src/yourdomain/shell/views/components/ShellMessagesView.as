package yourdomain.shell.views.components
{
	import commons.views.components.LoggerView;
	import commons.views.components.MessagesView;

	import flash.display.Sprite;

	public class ShellMessagesView extends Sprite
	{
		private var messagesView:MessagesView;
		private var loggerView:LoggerView;

		public function ShellMessagesView()
		{
			messagesView = new MessagesView();
			addChild(messagesView);

			loggerView = new LoggerView();
			loggerView.x = 290;
			loggerView.panelTitel = "Shell Logger";
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
