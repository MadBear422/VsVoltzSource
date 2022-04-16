package;

import Achievements;
#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var logoSpr:FlxSprite;
	var drops:FlxSprite;

	public static var justLeftTitle:Bool = false;
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;
	var canThrow:FlxSprite;

	var gfDanceTrans:FlxSprite;

	var triggeredFlash:Bool = false;
	var triggeringFlash:Bool = false;
	var theThing:FlxSprite;

	override public function create():Void
	{
		Paths.clearUnusedMemory();

		#if (polymod && !html5)
		if (sys.FileSystem.exists('mods/')) {
			var folders:Array<String> = [];
			for (file in sys.FileSystem.readDirectory('mods/')) {
				var path = haxe.io.Path.join(['mods/', file]);
				if (sys.FileSystem.isDirectory(path)) {
					folders.push(file);
				}
			}
			if(folders.length > 0) {
				polymod.Polymod.init({modRoot: "mods", dirs: folders});
			}
		}
		//Gonna finish this later, probably
		#end
		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = [FlxKey.ZERO];
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;

		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		
		// PlayerSettings.init();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		swagShader = new ColorSwap();
		super.create();

		FlxG.mouse.visible = false;
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
			
			MusicBeatState.switchState(new FlashingState());
		} else {
			#if desktop
			DiscordClient.initialize();
			Application.current.onExit.add (function (exitCode) {
				DiscordClient.shutdown();
			});
			#end
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				startIntro();
			});
		}
		#end
	}

	var logoBl:FlxSprite;
	var logoBlhit:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var bump1:Bool = false;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;
	var pressEnter:FlxSprite;

	var got:Int = 0;
	var britChance:Float = 10;
	var brickChance:Float = 20;
	function startIntro()
	{
		if (!initialized)
		{
			#if ACHIEVEMENTS_ALLOWED
			Achievements.loadAchievements();
			if (!Achievements.isAchievementUnlocked('all_voltz_clear'))
			{
				got = 0;
				for (i in 0...27) {
					if (Achievements.isAchievementUnlocked(Achievements.achievementsStuff[i][2])) { 
						trace('$i: ' + Achievements.achievementsStuff[i][2] + ' - yes');
						got++;
					}
					else if (i == 17) {
						trace('$i: ' + 'all_voltz_clear - skip');
					}
					else {
						trace('$i: ' + Achievements.achievementsStuff[i][2] + ' - no!');
					}	
				}
				britChance = 10 + (got*got)/30;
				brickChance = 20 + (got*got)/51;
			}
			#end
			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
			if(FlxG.sound.music == null) {
				trace('im gonna roll for british');
				if (FlxG.random.bool(britChance))	// 1/10 by default
					{
						FlxG.sound.playMusic(Paths.music('britannia'), 0.95);
						Conductor.changeBPM(88);
						basicAwardGrant('brit_startup');
						trace('im gonna roll for bricks');
						if (FlxG.random.bool(brickChance)) // 1/5 by default, 1/50 total chance
							{
								Main.dothebrit = true;
								basicAwardGrant('brit_startup_minecrap');
							}
					}
					
				else
					{
						FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);
						Conductor.changeBPM(92);
					}
				//FlxG.sound.music.fadeIn(4, 0, 0.7);
			}
		}
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// bg.antialiasing = ClientPrefs.globalAntialiasing;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		logoBl = new FlxSprite(-150, -17);
		logoBl.frames = Paths.getSparrowAtlas('titlemenu/logo');
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByIndices('bump1', 'Symbol 3 instance 1', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		logoBl.animation.addByIndices('bump2', 'Symbol 3 instance 1', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		//logoBl.animation.addByPrefix('bump', 'Symbol 3 instance 1', 23);
		
		logoBl.scale.set(0.9, 0.9);
		logoBl.updateHitbox();

		logoBlhit = new FlxSprite(-103, -17);
		logoBlhit.frames = Paths.getSparrowAtlas('titlemenu/logo_trans');
		logoBlhit.antialiasing = ClientPrefs.globalAntialiasing;
		logoBlhit.animation.addByPrefix('bump', 'logo bumpin copy 2 instance 1', 24, false);
		logoBlhit.animation.play('bump');
		logoBlhit.scale.set(0.9, 0.9);
		logoBlhit.updateHitbox();

		swagShader = new ColorSwap();
		
		gfDance = new FlxSprite(557, 127);
		gfDance.frames = Paths.getSparrowAtlas('titlemenu/voltzfixedanim');
		gfDance.animation.addByIndices('danceLeft', 'Symbol 2 instance 1', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'Symbol 2 instance 1', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		//gfDance.animation.addByPrefix('idle', 'Symbol 2 instance 1', 24, true);
		gfDance.antialiasing = ClientPrefs.globalAntialiasing;
		add(gfDance);
		gfDance.shader = swagShader.shader;
		

		gfDanceTrans = new FlxSprite(560, 55);
		gfDanceTrans.frames = Paths.getSparrowAtlas('titlemenu/voltz_trans');
		gfDanceTrans.animation.addByPrefix('idle', 'GF Dancing Beat copy instance 1', 24, false);
		gfDanceTrans.antialiasing = ClientPrefs.globalAntialiasing;
		gfDanceTrans.alpha = 0;
		add(gfDanceTrans);
		gfDanceTrans.shader = swagShader.shader;
		//gfDance.animation.play('idle');

		add(logoBl);
		logoBlhit.alpha = 0;
		add(logoBlhit);
		//logoBl.shader = swagShader.shader;

		pressEnter = new FlxSprite(90, 483);

		pressEnter.frames = Paths.getSparrowAtlas('titlemenu/ass');
		pressEnter.animation.addByIndices('idle', 'bop', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		//pressEnter.animation.addByPrefix('idle', "bop", 24);
		
		pressEnter.antialiasing = ClientPrefs.globalAntialiasing;
		add(pressEnter);

		// var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		// logo.screenCenter();
		// logo.antialiasing = ClientPrefs.globalAntialiasing;
		// add(logo);

		theThing = new FlxSprite(-516, -2764).loadGraphic(Paths.image('titlemenu/thing'));
		theThing.antialiasing = ClientPrefs.globalAntialiasing;
		add(theThing);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		logoSpr = new FlxSprite(0, FlxG.height * 0.3).loadGraphic(Paths.image('spark'));
		add(logoSpr);
		logoSpr.visible = false;
		logoSpr.setGraphicSize(Std.int(logoSpr.width * 0.40));
		logoSpr.updateHitbox();
		logoSpr.screenCenter(X);
		logoSpr.antialiasing = ClientPrefs.globalAntialiasing;

		
		drops = new FlxSprite(370, 175);
		drops.frames = Paths.getSparrowAtlas('titlemenu/drops');
		drops.animation.addByPrefix('drop', 'drops', 24, false);
		drops.visible = false;
		add(drops);

		canThrow = new FlxSprite(194, -16);
		canThrow.frames = Paths.getSparrowAtlas('volt_transition');
		canThrow.animation.addByPrefix('throw', 'can', 24, false);
		canThrow.visible = false;
		add(canThrow);
		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);
		
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		if (triggeringFlash) {
			if (!triggeredFlash) {
				if (gfDanceTrans.animation.curAnim.curFrame == 8) {
					FlxG.camera.shake(0.01, 0.1, null, true);
					FlxG.camera.flash(FlxColor.WHITE, 2, null, true);
					triggeredFlash = true;
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
					FlxG.sound.play(Paths.sound('BoxOpen'), 0.7);
					pressEnter.alpha = 0;
					if(titleText != null) titleText.animation.play('press');
				}
			}
		}
		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro)
		{
			
			pressEnter.animation.pause();
			logoBl.alpha = 0;
			logoBlhit.alpha = 1;
			logoBlhit.animation.play('bump', true);

			gfDance.alpha = 0;
			gfDanceTrans.alpha = 1;
			gfDanceTrans.animation.play('idle', true);
			//FlxG.camera.flash(FlxColor.WHITE, 1);
			

			transitioning = true;
			triggeringFlash = true;
			// FlxG.sound.music.stop();
			new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				FlxTween.tween(theThing, {y:  0}, 3, {ease: FlxEase.cubeOut});
				
			});
			new FlxTimer().start(1.5, function(tmr:FlxTimer) {
				drops.visible = true;
				drops.animation.play('drop');
				drops.animation.finishCallback = function (name:String) {
					drops.visible = false;
				}
			});
			justLeftTitle = true;
			new FlxTimer().start(4, function(tmr:FlxTimer)
			{
				MusicBeatState.switchState(new MainMenuState());
				closedState = true;
			});
		}

		if (pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>, ?offset:Float = 0)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200 + offset;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String, ?offset:Float = 0)
	{
		if(textGroup != null) {
			var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
			coolText.screenCenter(X);
			coolText.y += (textGroup.length * 60) + 200 + offset;
			credGroup.add(coolText);
			textGroup.add(coolText);
		}
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	private static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();
		if (logoBl != null && curBeat & 2 == 0) {
			logoBl.animation.play('bump');
			gfDance.animation.play('idle');
			pressEnter.animation.play('idle', true);
		}
		
		if (gfDance != null) {
			danceLeft = !danceLeft;
			if (danceLeft)
			gfDance.animation.play('danceRight');
			else
				gfDance.animation.play('danceLeft');
		}
		
		
		if (logoBl != null) {
			bump1 = !bump1;
			if (bump1)
			logoBl.animation.play('bump2');
			else
				logoBl.animation.play('bump1');
		}

		if(!closedState) {
			switch (curBeat)
			{
				case 1:
					createCoolText(['Spark Studios'], -60);
				case 2:
				case 3:
					addMoreText('A mod made by', -60);
				case 4:
				case 5:
					logoSpr.visible = true;
				case 6:
					logoSpr.visible = false;
					deleteCoolText();
				case 7:
					createCoolText([curWacky[0]]);
				case 8:
				case 9:
					addMoreText(curWacky[1]);
				case 10:
					deleteCoolText();
				case 11:
					createCoolText(['Friday Night Funkin', 'Vs Voltz'], -60);
					for (i in textGroup) 
					{
						FlxTween.tween(i, {y:  -149}, 2, {ease: FlxEase.quartOut, startDelay: 0.8});
					}
				case 12:
					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						canThrow.animation.play('throw', true);	
						canThrow.visible = true;
					});
					
				case 13:
				case 14:
				case 15:
				case 16:
					skipIntro();
			}
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			basicAwardGrant('startup');
			remove(logoSpr);
			remove(canThrow);
			FlxG.camera.flash(FlxColor.WHITE, 2);
			remove(credGroup);
			skippedIntro = true;
		}
	}

	function basicAwardGrant(awardname:String) { 
		#if ACHIEVEMENTS_ALLOWED
			Achievements.loadAchievements();
			var achieveID:Int = Achievements.getAchievementIndex(awardname);
			if (achieveID != -1) {
				var redundant:String = Achievements.achievementsStuff[achieveID][2];
				if(!Achievements.isAchievementUnlocked(redundant)) { 
					Achievements.achievementsMap.set(redundant, true);
					add(new AchievementObject(redundant));
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
					trace('Giving achievement "'+ redundant +'"');
					ClientPrefs.saveSettings();
				}
			}
			else {
				trace('invalid award');
			}
		#end
	}
}
