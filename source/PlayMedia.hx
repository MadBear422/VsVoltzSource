package;

import FlxVideo;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxCamera;
import openfl.utils.Assets as OpenFlAssets;

#if sys
import sys.FileSystem;
#end

using StringTools;

class PlayMedia extends MusicBeatState // script by 4Axion!!! please credit :)
{
    public static var di:Array<String>;
    var video:FlxVideo;
	var isInstance:Bool = true;
	// Madbear Code (not much)
	public static var isStoryMode:Bool = false;
	//
	public var camHUD:FlxCamera;
	public var camGame:FlxCamera;
	var bg:FlxSpriteExtra;
	var leVid:FlxVideoPC = null;
	var vidFin:Bool = false;
	var ready:Bool = false;
    override function create() 
	{
		isInstance = true;
		ready = false;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxCamera.defaultCameras = [camGame];
		persistentUpdate = true;
		switch (di[0])
		{
			case 'video':
				startVideo(di[1]);
		}
	}

    override function update(elapsed:Float)
	{
		if (controls.BACK || controls.ACCEPT)
		{
			isInstance = false;
			returnto(${di[2]});
		}
	}

    function returnto(name:String)
	{
		FlxG.sound.music.stop();
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);
		//remove(leVid); //why you removing something you never added
		if (leVid != null) {
			leVid.skipVideo();
		}
		if (!isStoryMode)
			LoadingState.loadAndSwitchState(new CreditsVoltz());
		else
		{
			StoryMenuState.tosslerScreen = true;
			MusicBeatState.switchState(new StoryMenuState());
		}
	}

	function displayImage(pathImg:String)
	{
		var image:FlxSprite = new FlxSprite().loadGraphic(Paths.image('secret/${pathImg}', 'ridzak'));
		image.antialiasing = ClientPrefs.globalAntialiasing;
		image.setGraphicSize(1280,720);
		image.screenCenter();
		add(image);
	}

	public function startVideo(name:String):Void 
	{
		#if VIDEOS_ALLOWED
		var foundFile:Bool = false;
		var fileName:String = #if MODS_ALLOWED Paths.modFolders('videos/' + name + '.' + Paths.VIDEO_EXT); #else ''; #end
		#if sys
		if(FileSystem.exists(fileName)) {
			foundFile = true;
		}
		#end

		if(!foundFile) 
		{
			fileName = Paths.video(name);
			
			if(#if sys FileSystem.exists(fileName) #else OpenFlAssets.exists(fileName) #end) {
				foundFile = true;
			}
		}

		if(foundFile) {
			bg = new FlxSpriteExtra(-FlxG.width, -FlxG.height).makeSolid(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
			bg.scrollFactor.set();
			add(bg);
			leVid = new FlxVideoPC(fileName, true);
			FlxG.game.setChildIndex(FlxVideoPC.vlcBitmap, FlxG.game.getChildIndex(camHUD.flashSprite));
			(leVid).readyAndPlaying = function() {
				FlxG.sound.playMusic(Paths.music('credsvid'), 0.7);
			}
			(leVid).finishCallback = function() {
				leVid = null;
				if (isInstance) { returnto(di[2]); }
			}
			return;
		} else {
			FlxG.log.warn('Couldnt find video file: ' + fileName);
		}
		#end
		if (isInstance)
		returnto(di[2]);
	}
}