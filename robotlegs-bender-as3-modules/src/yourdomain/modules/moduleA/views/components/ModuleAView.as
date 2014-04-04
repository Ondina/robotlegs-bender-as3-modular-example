package yourdomain.modules.moduleA.views.components
{
	import commons.views.components.MessagesView;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import yourdomain.modules.moduleA.configs.ModuleAContext;

	public class ModuleAView extends Sprite
	{
		private var messagesView:MessagesView;
		private var rlContext:ModuleAContext;

		public function ModuleAView()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createRLContext();
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			messagesView = new MessagesView();
			addChild(messagesView);
		}

		private function createRLContext():void
		{
			rlContext = new ModuleAContext(this);
		}

		public function onMessageReceived(message:String):void
		{
			messagesView.onMessageReceived(message);
		}
	}
}
