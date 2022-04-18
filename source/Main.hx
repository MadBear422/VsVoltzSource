package;

import openfl.errors.Error;
import openfl.events.ErrorEvent;
import sys.io.File;
import haxe.CallStack;
import haxe.CallStack.StackItem;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.Process;
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import CoolerFPS as FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
#if desktop
import Discord.DiscordClient;
#end

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = BootingUp; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	public static var fpsVar:FPS;
	public static var dothebrit:Bool = false;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = BootingUp;
		#end
	
		ClientPrefs.loadDefaultKeys();
		// fuck you, persistent caching stays ON during sex
		FlxGraphic.defaultPersist = true;
		// the reason for this is we're going to be handling our own cache smartly

		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end
	}

	static final quotes:Array<String> = [
		"Bro stop giving the coders more work!",
		"Bornana flavored tango is the best!",
		"EEEE AAA!",
		"FUCK!",
		"Sorry I didn't fix this issue, I was busy with the eggs.",
		"Optimization who?",
		"BLAME MADBEAR!",
		"BLAME AXION!",
	];

	function onCrash(e:UncaughtErrorEvent):Void
	{
		var dateNow:String = Date.now().toString();
		var errMsg:String = [
			"+----------------------------+",
			"|     Vs Voltz Crash Log     |",
			"+----------------------------+",
			quotes[Std.random(quotes.length)],
			"Date: " + dateNow,
			"",
			"Please report this error to @SparkFNF on twitter",
			"------------------------------",
		].join("\r\n") + "\r\n";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);

		dateNow = StringTools.replace(dateNow, " ", "_");
		dateNow = StringTools.replace(dateNow, ":", "'");

		path = "./crash/" + "VsVoltz_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\r\n";
				default:
					Sys.println(stackItem);
			}
		}

		var m:String = e.error;
		if (Std.isOfType(e.error, Error)) {
			var err = cast(e.error, Error);
			m = '${err.message}';
		} else if (Std.isOfType(e.error, ErrorEvent)) {
			var err = cast(e.error, ErrorEvent);
			m = '${err.text}';
		}

		errMsg += "\r\nUncaught Error: " + m + "\r\n";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\r\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		//new Process('start /B ' + path, null);
		//new Process(path, []);
		//}
		//else
		//{
			// I had to do this or the stupid CI won't build :distress:
		//	Sys.println("No crash dialog found! Making a simple alert instead...");
		Application.current.window.alert(errMsg, "Error!");
		//}

		DiscordClient.shutdown();
		e.stopPropagation();
		e.stopImmediatePropagation();
		//Sys.exit(1);
	}
}
