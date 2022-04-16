#if web
import openfl.net.NetConnection;
import openfl.net.NetStream;
import openfl.events.NetStatusEvent;
import openfl.media.Video;
#else
import openfl.events.Event;
import vlc.VlcBitmap;
#end
import flixel.FlxBasic;
import flixel.FlxG;

class FlxVideoPC extends FlxBasic {
	#if VIDEOS_ALLOWED
	public var finishCallback:Void->Void = null;
	public var readyToPlay:Void->Void = null; // when play on load is FALSE

	public var readyAndPlaying:Void->Void = null; // when play on load is true
	
	#if desktop
	public static var vlcBitmap:VlcBitmap;

	public var loaded:Bool = false;
	public var playOnLoad:Bool = false;
	public var codedPause:Bool = false;
	#end

	public function new(name:String, ?pOnLoad:Bool = false) {
		super();

		#if web
		var player:Video = new Video();
		player.x = 0;
		player.y = 0;
		FlxG.addChildBelowMouse(player);
		var netConnect = new NetConnection();
		netConnect.connect(null);
		var netStream = new NetStream(netConnect);
		netStream.client = {
			onMetaData: function() {
				player.attachNetStream(netStream);
				player.width = FlxG.width;
				player.height = FlxG.height;
			}
		};
		netConnect.addEventListener(NetStatusEvent.NET_STATUS, function(event:NetStatusEvent) {
			if(event.info.code == "NetStream.Play.Complete") {
				netStream.dispose();
				if(FlxG.game.contains(player)) FlxG.game.removeChild(player);

				if(finishCallback != null) finishCallback();
			}
		});
		netStream.play(name);

		#elseif desktop
		// by Polybius, check out PolyEngine! https://github.com/polybiusproxy/PolyEngine

		vlcBitmap = new VlcBitmap();
		vlcBitmap.set_height(FlxG.stage.stageHeight);
		vlcBitmap.set_width(FlxG.stage.stageHeight * (16 / 9));

		playOnLoad = pOnLoad;
		vlcBitmap.onComplete = onVLCComplete;
		vlcBitmap.onError = onVLCError;
		vlcBitmap.onVideoReady = onVLCReady;
		loaded = false;

		FlxG.stage.addEventListener(Event.ENTER_FRAME, fixVolume);
		vlcBitmap.repeat = 0;
		vlcBitmap.inWindow = false;
		vlcBitmap.fullscreen = false;
		fixVolume(null);
		
		FlxG.addChildBelowMouse(vlcBitmap);
		vlcBitmap.play(checkFile(name));
		#end
	}

	#if desktop
	function checkFile(fileName:String):String
	{
		var pDir = "";
		var appDir = "file:///" + Sys.getCwd() + "/";

		if (fileName.indexOf(":") == -1) // Not a path
			pDir = appDir;
		else if (fileName.indexOf("file://") == -1 || fileName.indexOf("http") == -1) // C:, D: etc? ..missing "file:///" ?
			pDir = "file:///";

		return pDir + fileName;
	}
	
	public static function onFocus() {
		if(vlcBitmap != null) {
			vlcBitmap.resume();
		}
	}
	
	public static function onFocusLost() {
		if(vlcBitmap != null) {
			vlcBitmap.pause();
		}
	}

	function fixVolume(e:Event) {
		// shitty volume fix
		vlcBitmap.volume = 0;
		if(!FlxG.sound.muted && FlxG.sound.volume > 0.01) { //Kind of fixes the volume being too low when you decrease it
			vlcBitmap.volume = FlxG.sound.volume * 0.5 + 0.5;
		}
	}
	
	public function activateVideo() {
		if (!vlcBitmap.isPlaying) { vlcBitmap.resume(); }
	}
	// fadeOut() and fadeIn() functions necessary? might just be able to give access to the alpha variables thru lua
	
	public function skipVideo() {
		if(vlcBitmap != null) {
			vlcBitmap.stop();

			vlcBitmap.dispose();

			if (FlxG.game.contains(vlcBitmap))
			{
				FlxG.game.removeChild(vlcBitmap);
			}
			if (finishCallback != null) { finishCallback(); }
		}
	}

	public function onVLCComplete()
	{
		vlcBitmap.stop();
		// Clean player, just in case!
		vlcBitmap.dispose();

		if (FlxG.game.contains(vlcBitmap))
		{
			FlxG.game.removeChild(vlcBitmap);
		}

		if (finishCallback != null) { finishCallback(); }
	}

	public function onVLCReady()
	{
		trace("VLC Ready!");
		loaded = true;
		if (playOnLoad) {
			//Ass?
			codedPause = false;
			if (readyAndPlaying != null) { readyAndPlaying(); }
			}
		else  {
			vlcBitmap.pause();
			vlcBitmap.seek(0.0);
			codedPause = true;
			if (readyToPlay != null) { readyToPlay(); }
		}
	}
	
	function onVLCError()
	{
		trace("An error has occured while trying to load the video.\nPlease, check if the file you're loading exists.");
		if (finishCallback != null) {
			finishCallback();
		}
	}
	#end
	#end
}