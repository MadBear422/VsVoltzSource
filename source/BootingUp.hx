package;

import flixel.ui.FlxBar;
import openfl.filters.ShaderFilter;
#if sys
import sys.io.File;
#end
import flixel.text.*;
import openfl.display.BitmapData;
import openfl.utils.AssetCache;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.*;
import openfl.utils.Assets;
import openfl.utils.AssetType;
import haxe.Json;
import haxe.format.JsonParser;
import openfl.Assets;
import openfl.utils.ByteArray;
// import Achievements.MedalSaves;
import haxe.io.Bytes;
import flixel.addons.api.FlxGameJolt;
import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.ui.FlxUIInputText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if sys
import sys.FileSystem;
#end
#if newgrounds
import io.newgrounds.NG;
#end
import lime.app.Application;
#if cpp
import sys.thread.Thread;
#end
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class BootingUp extends MusicBeatState {
	public var logoAnim:FlxSprite;
	public var loadingMush:FlxSprite;
	public var loadedTxt:FlxFixedText;
	public var loadedImages:Int = 0;
	public var loadBar:FlxBar;
	public var loadBarSpr:FlxSprite;
	public var viggy:VignetteShader;
	var boolOne:Bool = false;
	var boolTwo:Bool = false;
	var iscompleted:Bool = false;
	var fuck:Bool = false;

	override function create() {
		FlxG.save.bind('funkin', 'ninjamuffin99');
		//PlayerSettings.init();

		FlxG.game.focusLostFramerate = 60;
		// FlxG.sound.muteKeys = muteKeys;
		// FlxG.sound.volumeDownKeys = volumeDownKeys;
		// FlxG.sound.volumeUpKeys = volumeUpKeys;
		#if desktop
		FlxG.keys.preventDefaultKeys = [TAB];
		#end

		PlayerSettings.init();
		ClientPrefs.loadPrefs();

		Highscore.load();
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		loadingMush = new FlxSprite().loadGraphic(Paths.image("Greassjeak","shared"));
		loadingMush.scale.set(0.4,0.4);
		loadingMush.screenCenter();
		add(loadingMush);

		logoAnim = new FlxSprite();
		logoAnim.frames = Paths.getSparrowAtlas('titlemenu/logo');
		logoAnim.scale.set(0.4,0.4);
		logoAnim.screenCenter();
		logoAnim.y += 500;
		logoAnim.x += 500;
		logoAnim.animation.addByIndices('bump1', 'Symbol 3 instance 1', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		logoAnim.animation.play('bump1',true);
		add(logoAnim);

		loadedTxt = new FlxFixedText(400, 250, FlxG.width - 600, "PRELOADING MENU MUSIC", 32);
		loadedTxt.setFormat(Paths.font("microgramma.otf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		loadedTxt.scrollFactor.set();
		loadedTxt.borderSize = 1.25;
		loadedTxt.screenCenter();
		loadedTxt.y -= 100;
		add(loadedTxt);

		loadBar = new FlxBar(0,0,LEFT_TO_RIGHT,Std.int(1110 / 2),15,this,'loadedImages',0,247,true);
		// loadBar.createGradientBar([FlxColor.BLACK, FlxColor.GRAY], [FlxColor.ORANGE, FlxColor.YELLOW],1,180,true,FlxColor.BLACK);
		loadBar.createFilledBar(FlxColor.BLACK, FlxColor.WHITE, true, FlxColor.BLACK);
		loadBar.antialiasing = true;
		loadBar.numDivisions = 10000;
		loadBar.screenCenter();
		if (FlxG.save.data.preCache)
			add(loadBar);

		viggy = new VignetteShader();
		viggy.radius = 0.4;

		FlxG.camera.setFilters([new ShaderFilter(viggy.shader)]);

		// FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);//genius momento. agree

		loadedTxt.text = "PRELOADED ASSETS: 0";
		fuck = true;
		if (FlxG.save.data.preCache)
			{
				#if cpp
				Thread.create(cacheStuff);
				#else
				cacheStuff();
				#end
			}
		else
			iscompleted = true;

		//trace(SysPathing.getExePath("do NOT readme.txt"));

		super.create();
	}
	
	override public function update(h:Float) {
		super.update(h);

		if (iscompleted) { //  && boolOne && boolTwo
			if (FlxG.save.data.preCache)
				loadedTxt.text = "Assets Loaded\nPress ENTER to continue\n";
			else
				loadedTxt.text = "Ello Guvna!\nPress ENTER to continue\n";
			if (FlxG.keys.justPressed.ENTER) {
				MusicBeatState.switchState(new TitleState());
				trace(loadedImages);
			}
		}
		if (loadedTxt != null && fuck && !iscompleted) {
			loadedTxt.text = "LOADED ASSETS: " + loadedImages;
		}
	}

	//own made caching :P -zackk
	function cacheStuff() { //very hard goin, keep preloading assets only to big asf shit like ui and dialogue.
		#if sys
		// loadfolder("assets/images");
		loadfolder("assets/images/characters");
		// loadfolder("assets/images/charselect");
		loadfolder("assets/images/extrasMenu");
		loadfolder("assets/images/extrasMenu/achievements");
		//loadfolder("assets/images/extrasMenu/artwork");
		loadfolder("assets/images/extrasMenu/back");
		loadfolder("assets/images/extrasMenu/char");
		//loadfolder("assets/images/extrasMenu/dev");
		loadfolder("assets/images/extrasMenu/gallery");
		//loadfolder("assets/images/extrasMenu/movies");
		loadfolder("assets/images/extrasMenu/sound");
		loadfolder("assets/images/extrasMenu/who voltz");
		loadfolder("assets/images/freeplayThing");
		loadfolder("assets/images/icons");
		loadfolder("assets/images/loadscreen");
		loadfolder("assets/images/loadscreen/logos");
		loadfolder("assets/images/loadscreen/background");
		loadfolder("assets/images/loadscreen/characters");
		loadfolder("assets/images/loadscreen/text");
		loadfolder("assets/images/mainmenu");
		loadfolder("assets/images/mainmenu/bf");
		loadfolder("assets/images/mainmenu/cat");
		loadfolder("assets/images/mainmenu/gf");
		loadfolder("assets/images/mainmenu/voltz");
		//loadfolder("assets/images/gallery/artwork/gallery_subs");
		// loadfolder("assets/images/menudifficulties");
		// // loadfolder("assets/images/pixelUI");
		// loadfolder("assets/images/soundtest");
		// loadfolder("assets/images/soundtest/gf");
		// loadfolder("assets/images/soundtest/bf");
		// loadfolder("assets/images/soundtest/voltz");
		// loadfolder("assets/images/soundtest/pico");
		// loadfolder("assets/images/soundtest/cat");
		// loadfolder("assets/images/soundtest/mom");
		// loadfolder("assets/images/soundtest/dad");
		// loadfolder("assets/images/soundtest/noVal");
		// loadfolder("assets/images/soundtest/parents");
		// loadfolder("assets/images/soundtest/monster");
		// loadfolder("assets/images/soundtest/spooky");
		// loadfolder("assets/images/soundtest/spirit");
		loadfolder("assets/images/steam");
		loadfolder("assets/images/ui");
		loadfolder("assets/images/titlemenu");
		loadfolder("assets/images/creds");
		loadfolder("assets/images/creds/people");
		// loadfolder("assets/images/voltzWeeks");
		// loadfolder("assets/images/voltzWeeks/characters");
		// loadfolder("assets/images/voltzWeeks/bgColors");
		// loadfolder("mods/images/gym");
		// loadfolder("mods/images/gym/dusk");
		// loadfolder("mods/images/gym/night");
		// loadfolder("assets/shared/images");
		 // loadfolder("assets/shared/images/characters");
		loadfolder("assets/shared/images/dialogue");
		//loadfolder("mods/images/characters"); /ughhhsghdsh pain/.
		// loadfolder("assets/shared/images/dialogue/stock");
		//loadfolder("assets/shared/images/gymStage");
		// loadfolder("assets/shared/images/park");

		// if (FlxG.save.data.keepPreload) {
		// loadfolder("assets/shared/images/characters");
		// loadfolder("assets/shared/images/8bit");
		// loadfolder("assets/images/pixelUI");
		// }
		//FlxG.sound.cacheAll();
		#end
		iscompleted = true;
	}

	function loadfolder(folder:String) {
		var charpaths = FileSystem.readDirectory(Sys.getCwd() + '/' + folder);

		for (path in charpaths)
		{
			var fullpath = '$folder/$path';
			//trace(fullpath);

			if (!path.contains('.png') || !FileSystem.exists(Sys.getCwd() + '/' + fullpath))
				continue;

			var bitmap = BitmapData.fromFile(Sys.getCwd() + '/' + fullpath);

			FlxG.bitmap.add(bitmap).persist = true;

			Paths.cache.setBitmapData(fullpath, bitmap);
			// Paths.excludeAsset(fullpath); // bullshit so it wont dump the ui assets
			var stupi:FlxGraphic = FlxGraphic.fromBitmapData(bitmap);
			stupi.persist = true;

			Paths.cachedAsses.set(fullpath, stupi);
			Paths.cachedShit.push(fullpath);
			//stupi.destroy();
			// since its all in cached, we dont need cache anymore?? idfk.
			Paths.cache.clear(fullpath);
			if (Paths.cache.hasBitmapData(fullpath))
				Paths.cache.removeBitmapData(fullpath);

			loadedImages++;
		}
		trace("Cache Total: " + loadedImages);
	}
}