package;

import sys.FileSystem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class StoryVideo extends MusicBeatState
{
	private var videoCurrentlyPlaying:FlxVideo = null;
	private var isVideoCurrentlyPlaying:Bool;
	public static var videoPlaying:Bool = false;

	private var videoMap:Map<String, String> = [
		'dad' => 'week1',
		'spookeez' => 'week2',
		'pico' => 'week3',
		'mom' => 'week4',
		'parents' => 'week5',
		'senpai' => 'week6',
		'bf' => 'weekb',
		'voltz' => 'weekv',
		'cat' => 'tutorial'
	];

	public static var completedEnd:Bool = false;
	public static var completedCheckpoint:Bool = false;

	public static var galleryVideo:Bool = false;

	public static var galleryVideoName:String = null;

	public static var playCredits:Bool = false;
	public var inCutscene:Bool = false;

	override public function create()
	{
		if (galleryVideo)
		{
			startVideo("Movies/" + galleryVideoName);
		}
		else if (completedCheckpoint)
			startVideo("Movies/voltzunlock");
		else if (completedEnd)
			startVideo("Movies/ending", true);
		else if (playCredits)
			startVideo("credits");
		else if (FlxG.save.data.selectedCharcter == 'voltz')
			startVideo("Movies/" + videoMap.get(LoadingScreen.opponent), true);
		else if (FlxG.save.data.selectedCharcter == 'bf' && LoadingScreen.opponent == 'voltz')
			startVideo("Movies/" + videoMap.get(LoadingScreen.opponent), true);
		else
			LoadingState.loadAndSwitchState(new PlayState(), true);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (galleryVideoName != 'redacted')
		{
			if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ESCAPE)
			{
				videoCurrentlyPlaying.skipVideo();
				videoCurrentlyPlaying = null;
				isVideoCurrentlyPlaying = false;
			}
		}
	}

	public function startVideo(name:String, hasSkipIcon:Bool = false):Void {
		#if VIDEOS_ALLOWED
		var foundFile:Bool = false;
		var fileName:String = #if MODS_ALLOWED Paths.modFolders('videos/' + name + '.' + Paths.VIDEO_EXT); #else ''; #end
		#if sys
		if(FileSystem.exists(fileName)) {
			foundFile = true;
		}
		#end

		if(!foundFile) {
			fileName = Paths.video(name);
			#if sys
			if(FileSystem.exists(fileName))
			#else
			if(OpenFlAssets.exists(fileName))
			#end
			{
				foundFile = true;
			}
		}

		if(foundFile) {
			inCutscene = true;

			isVideoCurrentlyPlaying = true;
			videoCurrentlyPlaying = new FlxVideo(fileName);
			videoCurrentlyPlaying.hasSkipIcon = hasSkipIcon;

			(videoCurrentlyPlaying).finishCallback = function() {
				isVideoCurrentlyPlaying = false;
				videoCurrentlyPlaying = null;
				if (completedCheckpoint)
				{
					completedCheckpoint = false;
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					MusicBeatState.switchState(new StoryMenuState());
				}
				else if (completedEnd)
				{
					completedEnd = false;
					PlayMedia.isStoryMode = true;
					PlayMedia.di = ['video','creditsNoSound','no'];
					MusicBeatState.switchState(new PlayMedia());
				}
				else if (playCredits)
				{
					playCredits = false;
					StoryMenuState.tosslerScreen = true;
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					MusicBeatState.switchState(new StoryMenuState());
				}
				else if (galleryVideo)
				{
					galleryVideo = false;
					FlxG.sound.music.resume();
					FlxG.sound.music.fadeOut(0.5, 1);
					if (galleryVideoName == 'redacted')
					{
						Sys.exit(0);
					}
					else
						MusicBeatState.switchState(new MoviesState());
				}
				else
					LoadingState.loadAndSwitchState(new PlayState(), true);
			}
			return;
		} else {
			FlxG.log.warn('Couldnt find video file: ' + fileName);
			if (completedEnd)
			{
				completedEnd = false;
				MusicBeatState.switchState(new StoryMenuState());
			}
			else
				LoadingState.loadAndSwitchState(new PlayState(), true);
		}
		#end
	}
}

	/*override function update(elapsed:Float)
	{
		#if windows
		//stole this from aikoyori :p
		if(isVideoCurrentlyPlaying)
		{
			if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ESCAPE)
			{
				videoCurrentlyPlaying.skipVideo();
				isVideoCurrentlyPlaying = false;
			}
		}
		#end
		super.update(elapsed);
	}*/