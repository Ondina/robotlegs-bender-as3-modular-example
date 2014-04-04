package externaldomain.shell.views.components
{
	import com.bit101.components.Label;
	import com.bit101.components.VBox;

	import externaldomain.shell.configs.ExternalContext;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class ExternalContextView extends Sprite
	{
		private var rlContext:ExternalContext;

		public function ExternalContextView()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createRLContext();
		}

		private function onAddedToStage(event:Event):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addChildren();
		}

		private function createRLContext():void
		{
			rlContext = new ExternalContext(this);
		}

		private function addChildren():void
		{
			var vBox:VBox = new VBox(this, 0, 0);
			vBox.spacing = 20;

			var shellLabel:Label = new Label(this, 0, 0, "EXTERNAL:");
			var shellMessageView:ExternalMessagesView = new ExternalMessagesView();

			vBox.addChild(shellLabel);
			vBox.addChild(shellMessageView);
			addChild(vBox);
		}
	}
}
