package yourdomain.shell.views.components
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class ModulesLoaderView extends Sprite
	{
		private var _moduleURL:String;

		public function ModulesLoaderView()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function get moduleURL():String
		{
			return _moduleURL;
		}

		public function set moduleURL(value:String):void
		{
			_moduleURL = value;
		}

		private function onAddedToStage(event:Event):void
		{
			loadModule();
		}

		private function loadModule():void
		{
			var loader:Loader = new Loader();
			//configureListeners(loader.contentLoaderInfo);

			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;

			var request:URLRequest = new URLRequest(moduleURL);

			loader.load(request, loaderContext);
			addChild(loader);
		}

		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
		}

		private function completeHandler(event:Event):void
		{
			trace("completeHandler: " + event);
		}

		private function httpStatusHandler(event:HTTPStatusEvent):void
		{
			//trace("httpStatusHandler: " + event);
		}

		private function initHandler(event:Event):void
		{
			//trace("initHandler: " + event);
		}

		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("ioErrorHandler: " + event);
		}

		private function openHandler(event:Event):void
		{
			//trace("openHandler: " + event);
		}

		private function progressHandler(event:ProgressEvent):void
		{
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}

		private function unLoadHandler(event:Event):void
		{
			//trace("unLoadHandler: " + event);
		}

		private function clickHandler(event:MouseEvent):void
		{
			//trace("clickHandler: " + event);
			var loader:Loader = Loader(event.target);
			loader.unload();
		}
	}
}
