package commons.views.components
{
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;

	import commons.controllers.events.ModularConnectorEvent;
	import commons.models.vos.MessagesVO;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class MessagesView extends Sprite
	{
		private var panel:Panel;
		private var sendMessageButton:PushButton;
		private var receivedMessagesText:TextArea;
		private var sendMessagesText:TextArea;

		public function MessagesView()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChildren();
		}

		private function addChildren():void
		{
			panel = new Panel(this, 0, 0);
			panel.height = 110;
			panel.width = 280;
			panel.color = randomPastelColor();

			var sendLabel:Label = new Label(this, 11, 5, "write a message:");
			var receivedLabel:Label = new Label(this, 151, 5, "received messages:");
			sendLabel.opaqueBackground = 0xffffff;
			receivedLabel.opaqueBackground = 0xffffff;

			sendMessagesText = new TextArea(this, 10, 25);
			sendMessagesText.width = 120;
			sendMessagesText.height = 55;

			receivedMessagesText = new TextArea(this, 150, 25);
			receivedMessagesText.width = 120;
			receivedMessagesText.height = 55;
			receivedMessagesText.name = "receivedMessages";

			sendMessageButton = new PushButton(this, 10, 85, "send");
			sendMessageButton.addEventListener(MouseEvent.CLICK, onSendButtonClicked);

			panel.addChild(sendLabel);
			panel.addChild(receivedLabel);
			panel.addChild(sendMessagesText);
			panel.addChild(sendMessageButton);
			panel.addChild(receivedMessagesText);
			addChild(panel);
		}

		private function randomPastelColor():int
		{
			var red:int = Math.random() * 150 + 105; //values for 105 to 255
			var green:int = Math.random() * 150 + 105;
			var blue:int = Math.random() * 150 + 105;
			return rgb(red, green, blue);
		}

		private function rgb(red:int,green:int,blue:int):int
		{
			return (red * 256 * 256) + (green * 256) + blue; //RGB value
		}

		//============================================================================
		// SEND MESSAGES
		//============================================================================
		private function onSendButtonClicked(event:MouseEvent):void
		{
			var messagesVO:MessagesVO = new MessagesVO();
			messagesVO.message = sendMessagesText.text;
			dispatchEvent(new ModularConnectorEvent(ModularConnectorEvent.VIEW_TO_MEDIATOR_MESSAGE, messagesVO));
		}

		//============================================================================
		// RECEIVE MESSAGES
		//============================================================================
		public function onMessageReceived(message:String):void
		{
			receivedMessagesText.text = message;
		}

		/*private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			sendMessageButton.removeEventListener(MouseEvent.CLICK, onSendButtonClicked);
			removeChild(panel);
		}*/
	}
}
