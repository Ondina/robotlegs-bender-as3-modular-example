package
{
	import com.bit101.components.Label;
	import com.bit101.components.VBox;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import yourdomain.shell.configs.ShellContext;
	import yourdomain.shell.views.components.ModulesLoaderView;
	import yourdomain.shell.views.components.ShellMessagesView;

	public class ShellContextView extends Sprite
	{
		private var rlContext:ShellContext;

		public function ShellContextView()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			createRLContext();
			addChildren();
		}

		private function createRLContext():void
		{
			rlContext = new ShellContext(this);
		}

		private function addChildren():void
		{
			var vBox:VBox = new VBox(this, 0, 0);
			vBox.spacing = 15;

			var shellLabel:Label = new Label(this, 0, 0, "SHELL:");
			var shellMessageView:ShellMessagesView = new ShellMessagesView();

			var moduleLabel:Label = new Label(this, 0, 0, "MODULE:");
			var moduleLoaderView:ModulesLoaderView = new ModulesLoaderView();

			//module compiled with the application:
			//moduleLoaderView.moduleURL = "yourdomain/modules/moduleA/views/components/ModuleAView.swf";

			//external app:
			moduleLoaderView.moduleURL = "yourdomain/modules/moduleB/ExternalApp.swf";

			vBox.addChild(shellLabel);
			vBox.addChild(shellMessageView);
			vBox.addChild(moduleLabel);
			vBox.addChild(moduleLoaderView);

			addChild(vBox);
		}
	}
}
