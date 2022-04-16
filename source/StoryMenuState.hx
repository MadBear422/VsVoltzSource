package;

import Achievements;
import flixel.tweens.FlxEase;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxCamera;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	// Wether you have to beat the previous week for playing this one
	// Not recommended, as people usually download your mod for, you know,
	// playing just the modded week then delete it.
	// defaults to True
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	var scoreText:FlxText;

	var disableInput:Bool = true;
	var disableInputIndicator:Bool = true;

	var storyChar:Array<String> = [
		'tutorial',
		'dad',
		'spookeez',
		'pico',
		'mom',
		'parents',
		'senpai',
		'voltz',
	];

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;
	var changeWeekInput:Bool = true;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;

	var uiWhite:FlxSprite;
	var uiBlack:FlxSprite;

	var uiLeft:FlxTypedGroup<FlxSprite>;
	var uiRight:FlxSprite;
	//var uiTest:FlxSprite;

	var effect:ColorSwap = new ColorSwap();
	var oldShader:ColorSwap = new ColorSwap();
	var effectTween:FlxTween;

	private var camNormal:FlxCamera;

	var uiOpponent:FlxSprite;
	var uiPlayer:FlxSprite;

	var uiWeekText:FlxSprite;

	var voltzScreen:FlxSprite;

	private static var curWeek:Int = 0;
	public static var tosslerScreen:Bool = false;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var leftArrowBloo:FlxSprite;
	var rightArrowBloo:FlxSprite;

	override function create()
	{

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		if (FlxG.save.data.selectedCharcter == 'voltz') {
			storyChar[0] = 'cat';
			storyChar[7] = 'bf';
		}
		else if (FlxG.save.data.selectedCharcter == 'bf') {
			storyChar[0] = 'gf';
			storyChar[7] = 'voltz';
		}

		camNormal = new FlxCamera();
		FlxG.cameras.add(camNormal);
		camNormal.bgColor.alpha = 0;
		FlxCamera.defaultCameras = [camNormal];

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true, FlxG.save.data.selectedCharcter);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(0, 665, 0, "SCORE: 49324858", 36);
		scoreText.setFormat(Paths.font("microgramma.otf"), 32, FlxColor.WHITE, CENTER);
		scoreText.screenCenter(X);

		txtWeekTitle = new FlxText(0, 0, 0, "", 32);
		txtWeekTitle.setFormat(Paths.font("microgramma.otf"), 32, FlxColor.WHITE, LEFT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var bgYellow:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 386, 0xFFF9CF51);
		bgSprite = new FlxSprite(0, 56);
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;

		uiLeft = new FlxTypedGroup<FlxSprite>();

		for (i in 0...storyChar.length)
			{
				var spr:FlxSprite = new FlxSprite(0, 0.5);
				spr.loadGraphic(Paths.image('voltzWeeks/bgColors/left/' + storyChar[i]));
				spr.ID = i;
				if (spr.ID != curWeek)
					{
						spr.alpha = 0;
					}
				spr.antialiasing = ClientPrefs.globalAntialiasing;
				uiLeft.add(spr);
			}


		uiRight = new FlxSprite(640, 0.5).loadGraphic(Paths.image('voltzWeeks/bgColors/right/' + FlxG.save.data.selectedCharcter));
		uiRight.antialiasing = ClientPrefs.globalAntialiasing;

		uiWhite = new FlxSprite(0, 0).loadGraphic(Paths.image('voltzWeeks/white'));
		uiBlack = new FlxSprite(0, 0).loadGraphic(Paths.image('voltzWeeks/black'));

		uiOpponent = new FlxSprite(0, 0).loadGraphic(Paths.image('voltzWeeks/characters/' + storyChar[curWeek]));
		var weekImage = 'storymenu/' + WeekData.weeksList[curWeek];
		if (StringTools.endsWith(weekImage, "-V")) {
			weekImage = weekImage.substr(0, weekImage.length - 2);
		}

		uiWeekText = new FlxSprite(0, 0).loadGraphic(Paths.image(weekImage));
		uiWeekText.antialiasing = ClientPrefs.globalAntialiasing;
		uiWeekText.screenCenter();
		uiWeekText.offset.y = -180;
		trace(tosslerScreen);

		leftArrowBloo = new FlxSprite(uiWeekText.x - 70, uiWeekText.y);
		leftArrowBloo.frames = ui_tex;
		leftArrowBloo.animation.addByPrefix('idle', "arrow left");
		leftArrowBloo.animation.addByPrefix('press', "arrow push left");
		leftArrowBloo.animation.play('idle');
		leftArrowBloo.antialiasing = ClientPrefs.globalAntialiasing;
		leftArrowBloo.offset.y = -180;
		//leftArrowBloo.screenCenter(X);
		//leftArrowBloo.x -= 175;
		//leftArrow.color = 0x00FFFF;
		//leftArrowBloo.setGraphicSize(Std.int(leftArrow.width * 0.86));
		//leftArrow.updateHitbox();
		leftArrowBloo.color = 0x00FFFF;

		rightArrowBloo = new FlxSprite(uiWeekText.x + uiWeekText.width + 27, uiWeekText.y);
		rightArrowBloo.frames = ui_tex;
		rightArrowBloo.animation.addByPrefix('idle', "arrow right");
		rightArrowBloo.animation.addByPrefix('press', "arrow push right");
		rightArrowBloo.animation.play('idle');
		rightArrowBloo.antialiasing = ClientPrefs.globalAntialiasing;
		rightArrowBloo.offset.y = -180;
		//leftArrowBloo.screenCenter(X);
		//leftArrowBloo.x -= 175;
		//leftArrow.color = 0x00FFFF;
		//leftArrowBloo.setGraphicSize(Std.int(leftArrow.width * 0.86));
		//leftArrow.updateHitbox();
		rightArrowBloo.color = 0x00FFFF;

		charReposition();
		uiOpponent.x -= 1000;
		uiOpponent.antialiasing = ClientPrefs.globalAntialiasing;

		uiPlayer = new FlxSprite(598 + 1000, -28).loadGraphic(Paths.image('voltzWeeks/characters/' + FlxG.save.data.selectedCharcter));
		uiPlayer.antialiasing = ClientPrefs.globalAntialiasing;
		if (FlxG.save.data.selectedCharcter == 'voltz')
			{
				uiPlayer.flipX = true;
				uiPlayer.x = 380 + 1000;
				uiPlayer.y = -138;
			}

		//uiTest = new FlxSprite(0, 0).loadGraphic(Paths.image('voltzWeeks/bgColors/test'));
		//uiTest.screenCenter(X);

		//add(uiTest);
		add(uiLeft);
		add(uiRight);
		add(uiWhite);
		add(uiPlayer);
		add(uiOpponent);
		add(uiBlack);
		add(uiWeekText);
		add(leftArrowBloo);
		add(rightArrowBloo);
		effectTween = FlxTween.num(0, 359, 240, {type: LOOPING}, function(v)
			{
				effect.hue = v;
			});

		FlxTween.tween(uiPlayer, {x: uiPlayer.x - 1000}, 0.8, {
			ease: FlxEase.cubeOut
			});
		FlxTween.tween(uiOpponent, {x: uiOpponent.x + 1000}, 0.8, {
			ease: FlxEase.cubeOut,
			onComplete: function(twn:FlxTween)
				{
					if (FlxG.save.data.voltzUnlockMessage != true && FlxG.save.data.selectedCharcter == 'voltz')
						{
							disableInput = true;
						}
					else if (tosslerScreen && FlxG.save.data.finishFreeplayUnlock != true)
						{
							disableInput = true;
						}
					else
						disableInput = false;
				}
			});

		grpWeekText = new FlxTypedGroup<MenuItem>();
		//add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		//add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length)
		{
			WeekData.setDirectoryFromWeek(WeekData.weeksLoaded.get(WeekData.weeksList[i]));
			var weekThing:MenuItem = new MenuItem(0, bgSprite.y + 396, WeekData.weeksList[i]);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = ClientPrefs.globalAntialiasing;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (weekIsLocked(i))
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = ClientPrefs.globalAntialiasing;
				grpLocks.add(lock);
			}
		}

		WeekData.setDirectoryFromWeek(WeekData.weeksLoaded.get(WeekData.weeksList[0]));
		var charArray:Array<String> = WeekData.weeksLoaded.get(WeekData.weeksList[0]).weekCharacters;
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, charArray[char]);
			weekCharacterThing.y += 70;
			grpWeekCharacters.add(weekCharacterThing);
		}

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(0, grpWeekText.members[0].y + 145);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		leftArrow.screenCenter(X);
		leftArrow.x -= 180;
		//leftArrow.color = 0x00FFFF;
		leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.86));
		leftArrow.updateHitbox();
		leftArrow.color = 0xFF4E00;
		difficultySelectors.add(leftArrow);

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		sprDifficulty = new FlxSprite(0, grpWeekText.members[0].y + 145);
		sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;
		sprDifficulty.setGraphicSize(Std.int(sprDifficulty.width * 0.85));
		sprDifficulty.screenCenter(X);
		sprDifficulty.updateHitbox();
		shaderChange();
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(leftArrow.x + 376, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		rightArrow.color = 0xFF4E00;
		rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.85));
		rightArrow.updateHitbox();
		difficultySelectors.add(rightArrow);
		selectAlpha();

		//add(bgYellow);
		//add(bgSprite);
		//add(grpWeekCharacters);

		var tracksSprite:FlxSprite = new FlxSprite(FlxG.width * 0.07, bgSprite.y + 425).loadGraphic(Paths.image('Menu_Tracks'));
		tracksSprite.antialiasing = ClientPrefs.globalAntialiasing;
		//add(tracksSprite);

		txtTracklist = new FlxText(FlxG.width * 0.7, 0, 0, "", 32);
		txtTracklist.alpha = 0.7;
		//txtTracklist.alignment = RIGHT;
		txtTracklist.setFormat(Paths.font("microgramma.otf"), 32, FlxColor.WHITE, RIGHT);
		//txtTracklist.font = rankText.font;
		//txtTracklist.color = 0xFFe55777;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);
		changeWeek();
		changeDifficulty();

		if (FlxG.save.data.selectedCharcter == 'voltz')
			{
				if (FlxG.save.data.voltzUnlockMessage != true)
					{
						disableInput = true;
						new FlxTimer().start(1, function(tmr:FlxTimer) { bringIndicator(); } );
		
					}
			}
		if (FlxG.save.data.finishFreeplayUnlock != true)
			{
				if (tosslerScreen)
					{
						disableInput = true;
						new FlxTimer().start(1, function(tmr:FlxTimer) { bringIndicator('hamowt'); } );
					}
			}
		super.create();
		changeDifficulty();
	}

	function bringIndicator(spr:String = 'voltzWeeks')
		{
			FlxG.sound.play(Paths.sound('Checkpoint'));
			voltzScreen = new FlxSprite(0, 300).loadGraphic(Paths.image('unlockIndicators/' + spr));
			voltzScreen.antialiasing = ClientPrefs.globalAntialiasing;
			voltzScreen.alpha = 0;
			add(voltzScreen);

			FlxTween.tween(voltzScreen, {alpha: 1, y: 0}, 0.4, {
				ease: FlxEase.cubeOut,
				onComplete: function(twn:FlxTween)
					{
						disableInputIndicator = false;
					}
			});
		}
	
	function exitIndicator()
		{
			FlxTween.tween(voltzScreen, {alpha: 0, y: 300}, 0.4, {
				ease: FlxEase.cubeIn,
				onComplete: function(twn:FlxTween)
					{
						disableInput = false;
						voltzScreen.kill();
					}
			});
		}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	function slideIn()
		{
			var pokeTop:FlxSprite = new FlxSprite(0,-500);
			pokeTop.loadGraphic(Paths.image('poke1'));
			FlxTween.tween(pokeTop, {y: 0}, 1, {
				ease: FlxEase.bounceOut
				});
			

			var pokeBottom:FlxSprite = new FlxSprite(0, 845);
			pokeBottom.loadGraphic(Paths.image('poke2'));
			FlxTween.tween(pokeBottom, {y: 345}, 1, {
				ease: FlxEase.bounceOut
				});

			add(pokeBottom);
			add(pokeTop);
		}

	function selectAlpha()
		{
			if (changeWeekInput)
				{
					// Lower Alpha for Difficulty
					rightArrow.alpha = 0.4;
					leftArrow.alpha = 0.4;
					sprDifficulty.alpha = 0.4;

					// Increase Alpha for Weeks
					rightArrowBloo.alpha = 1;
					leftArrowBloo.alpha = 1;
					uiWeekText.alpha = 1;
				}
			else
				{
					// Increase Alpha for Difficulty
					rightArrow.alpha = 1;
					leftArrow.alpha = 1;
					sprDifficulty.alpha = 1;

					// Lower Alpha for Weeks
					rightArrowBloo.alpha = 0.4;
					leftArrowBloo.alpha = 0.4;
					uiWeekText.alpha = 0.4;
				}
		}
	
	function shaderChange()
		{
			if (CoolUtil.difficulties[curDifficulty] == 'electrified')
				sprDifficulty.shader = effect.shader;
			else
				sprDifficulty.shader = oldShader.shader;
		}

	override function update(elapsed:Float)
	{
		if (!disableInputIndicator)
			{
				if (controls.ACCEPT || controls.BACK)
					{
						disableInputIndicator = true;
						camNormal.flash(FlxColor.WHITE, 0.3);
						FlxG.sound.play(Paths.sound('confirmMenu'));
						exitIndicator();
						if (FlxG.save.data.voltzUnlockMessage != true)
							FlxG.save.data.voltzUnlockMessage = true;
						if (FlxG.save.data.finishFreeplayUnlock != true && tosslerScreen == true)
							{
								FlxG.save.data.finishFreeplayUnlock = true;
								tosslerScreen = false;
								trace(tosslerScreen);
							}
					}
			}
		shaderChange();

		selectAlpha();
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "BEST SCORE: " + lerpScore;
		scoreText.screenCenter(X);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = !weekIsLocked(curWeek);

		if (!movedBack && !selectedWeek && !disableInput)
		{
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			if (upP && !downP)
			{
				changeWeekInput = !changeWeekInput;
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

		if (downP && !upP)
			{
				changeWeekInput = !changeWeekInput;
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			if (upP && downP)
				{
					new FlxTimer().start(1, function(tmr:FlxTimer) { callKingDick(); } );
				}

			if (controls.UI_RIGHT && !changeWeekInput)
				rightArrow.animation.play('press')
			else
				rightArrow.animation.play('idle');

			if (controls.UI_LEFT && !changeWeekInput)
				leftArrow.animation.play('press');
			else
				leftArrow.animation.play('idle');

			if (controls.UI_RIGHT && changeWeekInput)
				rightArrowBloo.animation.play('press')
			else
				rightArrowBloo.animation.play('idle');

			if (controls.UI_LEFT && changeWeekInput)
				leftArrowBloo.animation.play('press');
			else
				leftArrowBloo.animation.play('idle');

			if (controls.UI_RIGHT_P)
				{
					if (changeWeekInput)
						{
							disableInput = true;
							changeWeek(1);
							cycleChar();
							cycleWeek();
						}
					else
					changeDifficulty(1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
			else if (controls.UI_LEFT_P)
				{
					if (changeWeekInput)
						{
							disableInput = true;
							changeWeek(-1);
							cycleChar();
							cycleWeek();
						}
					else
					changeDifficulty(-1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
				
			/*else if (upP || downP)
				{
					changeDifficulty();
				}*/
			if(FlxG.keys.justPressed.CONTROL)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (controls.ACCEPT)
			{
				FlxG.sound.music.fadeOut(0.5);
				LoadingScreen.opponent = storyChar[curWeek];
				FlxTransitionableState.skipNextTransIn = true;
				camNormal.flash(FlxColor.WHITE, 0.3);
				slideIn();
				selectWeek();
			}
			if (controls.BACK)
				{
					FlxG.sound.play(Paths.sound('cancelMenu'));
					movedBack = true;
					MusicBeatState.switchState(new CharSelectState());
				}
		}

		super.update(elapsed);

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function callKingDick() 
	{
			if (Achievements.isAchievementUnlocked('story_dice_updown') && !(controls.UI_UP && controls.UI_DOWN)) { return; }
			trace('CALLING KING DICK');
			var kingDick:FlxSprite = new FlxSprite(0, 0);
			kingDick.loadGraphic(Paths.image('whatisthismean'));
			kingDick.setGraphicSize(Std.int(sprDifficulty.width * 3.4));
			kingDick.scale.x *= 3;
			kingDick.updateHitbox();
			kingDick.screenCenter();
			add(kingDick);
			basicAwardGrant('story_dice_updown');
			/*FlxTween.tween(kingDick, {alpha: 0}, 0.15, {
				ease: FlxEase.quadOut,
				onComplete: function(twn:FlxTween)
					{
						kingDick.kill();
					}
			});*/
			disableInput = true;

			if(FlxG.sound.music != null) { FlxG.sound.music.pause(); }
			openSubState(new CrashSubstate());
		}

	#if ACHIEVEMENTS_ALLOWED
	function basicAwardGrant(awardname:String) { 
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
	}
	#end

	function selectWeek()
	{
		if (!weekIsLocked(curWeek))
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				if(grpWeekCharacters.members[1].character != '') grpWeekCharacters.members[1].animation.play('confirm');
				stopspamming = true;
			}

			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]).songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			new FlxTimer().start(2.5, function(tmr:FlxTimer)
			{
				MusicBeatState.switchState(new LoadingScreen());
				//LoadingState.loadAndSwitchState(new PlayState(), true);
				FreeplayState.destroyFreeplayVocals();
SoundTest.destroyFreeplayVocals();
			});
		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	var tweenDifficulty:FlxTween;
	var lastImagePath:String;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;
		
		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		var image:Dynamic = Paths.image('menudifficulties/' + Paths.formatToSongPath(CoolUtil.difficulties[curDifficulty]));
		var newImagePath:String = '';
		if(Std.isOfType(image, FlxGraphic))
		{
			var graphic:FlxGraphic = image;
			newImagePath = graphic.assetsKey;
		}
		else
			newImagePath = image;

		if(newImagePath != lastImagePath)
		{
			sprDifficulty.loadGraphic(image);
			sprDifficulty.setGraphicSize(Std.int(sprDifficulty.width * 0.85));
			sprDifficulty.updateHitbox();
			sprDifficulty.x = leftArrow.x + 55;
			sprDifficulty.x += (308 - sprDifficulty.width) / 2;
			sprDifficulty.alpha = 0;
			sprDifficulty.y = leftArrow.y - 10;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftArrow.y + 10, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}
		lastImagePath = newImagePath;
		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getWeekScore(WeekData.weeksList[curWeek], curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function charReposition()
		{
			switch (storyChar[curWeek])
			{
				case 'gf':
					uiOpponent.flipX = false;
					uiOpponent.x = -92;
					uiOpponent.y = -9;
				case 'cat':
					uiOpponent.flipX = false;
					uiOpponent.x = -70;
					uiOpponent.y = -28;
				case 'dad':
					uiOpponent.flipX = false;
					uiOpponent.x = -283;
					uiOpponent.y = -35;
				case 'spookeez':
					uiOpponent.flipX = false;
					uiOpponent.x = 9;
					uiOpponent.y = 29;
				case 'pico':
					uiOpponent.flipX = false;
					uiOpponent.x = -22;
					uiOpponent.y = 42;
				case 'mom':
					uiOpponent.flipX = false;
					uiOpponent.x = -288;
					uiOpponent.y = 7;
				case 'parents':
					uiOpponent.flipX = false;
					uiOpponent.x = -95;
					uiOpponent.y = 33;
				case 'senpai':
					uiOpponent.flipX = false;
					uiOpponent.x = -30;
					uiOpponent.y = -104;
				case 'voltz':
					uiOpponent.flipX = false;
					uiOpponent.x = -107;
					uiOpponent.y = -138;
				case 'bf':
					uiOpponent.flipX = true;
					uiOpponent.x = 40;
					uiOpponent.y = -28;
			}
		}

	function bgTransition()
		{
			for (spr in uiLeft) {
				FlxTween.cancelTweensOf(spr);
				if (spr.ID == curWeek) {
					FlxTween.tween(spr, {alpha: 1}, 0.15, {
						ease: FlxEase.linear
						});
				} else {
					FlxTween.tween(spr, {alpha: 0}, 0.15, {
						ease: FlxEase.linear
					});
				}
			}
		}

	function cycleWeek()
		{
			var weekImage = 'storymenu/' + WeekData.weeksList[curWeek];
			if (StringTools.endsWith(weekImage, "-V")) {
				weekImage = weekImage.substr(0, weekImage.length - 2);
			}
			uiWeekText.loadGraphic(Paths.image(weekImage));
			uiWeekText.screenCenter();
			uiWeekText.y -= 10;
			uiWeekText.alpha = 0;
			FlxTween.tween(uiWeekText, {y: uiWeekText.y + 10, alpha: 1}, 0.1, {
				ease: FlxEase.cubeOut
			});
			leftArrowBloo.x = uiWeekText.x - 70;
			rightArrowBloo.x = uiWeekText.x + uiWeekText.width + 27;
		}

	function cycleChar()
		{
			var image:Dynamic = Paths.image('voltzWeeks/characters/' + storyChar[curWeek]);
			uiOpponent.loadGraphic(image);
			charReposition();
			uiOpponent.x -= 100;
			uiOpponent.alpha = 0;
			FlxTween.tween(uiOpponent, {x: uiOpponent.x + 100, alpha: 1}, 0.2, {
				ease: FlxEase.cubeOut,
				onComplete: function(twn:FlxTween)
					{
						disableInput = false;
					}
				});
			bgTransition();
		}

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;
		if (curWeek >= WeekData.weeksList.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = WeekData.weeksList.length - 1;

		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]);
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		//txtWeekTitle.x = FlxG.width - (txtWeekTitle.width);

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && !weekIsLocked(curWeek))
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) {
			bgSprite.visible = false;
		} else {
			bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));
		}
		
		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
		updateText();
		txtTracklist.x = FlxG.width - (txtTracklist.width + 10);
	}

	function weekIsLocked(weekNum:Int) {
		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[weekNum]);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]).weekCharacters;
		for (i in 0...grpWeekCharacters.length) {
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}

		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]);
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			if (StringTools.endsWith(leWeek.songs[i][0], '-V')) {
				stringThing.push(leWeek.songs[i][0].substr(0, leWeek.songs[i][0].length - 2));
			} else {
				stringThing.push(leWeek.songs[i][0]);
			}
		}

		txtTracklist.text = '- ';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + ' - ';
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		//txtTracklist.screenCenter(X);
		//txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(WeekData.weeksList[curWeek], curDifficulty);
		#end
	}
}
