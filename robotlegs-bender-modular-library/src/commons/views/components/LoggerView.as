package commons.views.components
{
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.TextArea;

	import flash.display.Sprite;
	import flash.events.Event;

	public class LoggerView extends Sprite
	{
		private var panel:Panel;
		private var messagesText:TextArea;
		private var _panelTitel:String;

		public function LoggerView()
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
			panel.width = 200;
			panel.color = 0xCCCCCC;

			var panelLabel:Label = new Label(this, 11, 5, panelTitel);
			panelLabel.opaqueBackground = 0xffffff;

			messagesText = new TextArea(this, 10, 25);
			messagesText.width = 180;
			messagesText.height = 55;

			panel.addChild(panelLabel);
			panel.addChild(messagesText);
			addChild(panel);
		}

		public function onMessageReceived(message:String):void
		{
			messagesText.text = message;
		}

		public function get panelTitel():String
		{
			return _panelTitel;
		}

		public function set panelTitel(value:String):void
		{
			_panelTitel = value;
		}
	}
}
