package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.system.FlxAssets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;

using StringTools;

class MainMenuState extends MusicBeatState
{
	var theThing:FlxSprite;
	var gaybuttsex:Bool = true; // For CanadianGoose. So true.
	public static var psychEngineVersion:String = '0.4.1'; //This is also used for Discord RPC
	public var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<MenuThing>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	//public var bgDots:FlxGraphicAsset;
	
	var optionShit:Array<String> = ['story_mode', 'freeplay', 'extras', 'options'];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	
	var introSweep = new FlxSprite();

	var grpBGs:FlxTypedGroup<MenuThing>;
	var bgDots:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/dots'));	
	var daLogo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/logo'));
	var optionsIntro:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/optionsintro'));
	var orangeStuph:FlxSprite = new FlxSprite().loadGraphic(Paths.image('titlemenu/thing'));
	var coverUp:FlxSprite = new FlxSprite().loadGraphic(Paths.image('titlemenu/thing'));
	var grpSparks:FlxTypedGroup<MenuThing>;
	var grpCharBlack:FlxTypedGroup<MenuThing>;
	var grpCharColor:FlxTypedGroup<MenuThing>;
	var grpCharacters:FlxTypedGroup<MenuThing>;
	var grpExtras:FlxTypedGroup<MenuThing>;
	var scrollDots:FlxBackdrop;
	var inputTaken:Bool = true;
	var notBusy:Bool = false;
	//for the colored things on the bottom right of the screen
	var grpThings:FlxTypedGroup<MenuThing>;
	var justCame:Bool = true;

	var fileDirectories:Array<String> = [
		'voltz',
		'bf',
		'cat',
		'gf'
	];

	var dumbnessValue:Int = 1;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("What's Doomah?", null);
		#end
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];
		
		daLogo.antialiasing = ClientPrefs.globalAntialiasing;


		persistentUpdate = persistentDraw = true;

		//var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		//var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		//bg.scrollFactor.set(0, yScroll);
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		//bg.updateHitbox();
		//bg.screenCenter();
		//bg.antialiasing = ClientPrefs.globalAntialiasing;
		//add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		//add(camFollow);
		//add(camFollowPos);
		

		//magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		//magenta.scrollFactor.set(0, yScroll);
		//magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		//magenta.updateHitbox();
		//magenta.screenCenter();
		//magenta.visible = false;
		//magenta.antialiasing = ClientPrefs.globalAntialiasing;
		//magenta.color = 0xFFfd719b;
		//add(magenta);
		//magenta.scrollFactor.set();
	

		
		grpBGs = new FlxTypedGroup<MenuThing>();
		add(grpBGs);
		scrollDots = new FlxBackdrop(bgDots.graphic, 60, 0, true, false);
		add(scrollDots);
		scrollDots.velocity.set(30, 0);
		grpSparks = new FlxTypedGroup<MenuThing>();
		add(grpSparks);
		add(orangeStuph);
		orangeStuph.scale.set(1.5, 1.5);
		grpCharBlack = new FlxTypedGroup<MenuThing>();
		//add(grpCharBlack);		
		grpCharColor = new FlxTypedGroup<MenuThing>();
		//add(grpCharColor);
		grpExtras = new FlxTypedGroup<MenuThing>();
		//add(grpExtras);
		grpCharacters = new FlxTypedGroup<MenuThing>();
		//add(grpCharacters);
		grpThings = new FlxTypedGroup<MenuThing>();
		//add(grpThings);

		//loadImages(grpBGs, 'bg');
		//loadImages(grpSparks, 'spark');
		//loadImages(grpCharColor, 'charcolor');
		//loadImages(grpCharBlack, 'charblack');
		//loadImages(grpExtras, 'extra');
		//loadImages(grpCharacters, 'character');
		//loadImages(grpThings, 'funkin thing');
		//loadImages(grpLogo, 'logo');

		menuItems = new FlxTypedGroup<MenuThing>();
		//add(menuItems);

		//for (i in 0...optionShit.length)
		//{
		//	var offset:Float = 10 - (Math.max(optionShit.length, 4) - 4) * 80;
		//	var menuItem:MenuThing = new MenuThing(0, (i * 140)  + offset);
		//	menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
		//	menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
		//	menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
		//	menuItem.animation.play('idle');
		//	menuItem.ID = i;
		//	menuItem.screenCenter(X);
		//	menuItems.add(menuItem);
		//	var scr:Float = (optionShit.length - 4) * 0.135;
		//	if(optionShit.length < 6) scr = 0;
		//	menuItem.scrollFactor.set(0, scr);
		//	menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
		//	menuItem.updateHitbox();
		//	if (i != 0)
		//		menuItem.scale.set(0.7, 0.7);
		//	
		//}
		//calculateSpot();
		//for (i in menuItems) {
		//	i.y = (FlxG.height / 2) + (i.menuSpot + 3) * 300 - (i.height / 2);
		//	i.angle = (i.menuSpot + 3) * -20;
		//	FlxTween.tween(i, {y: (FlxG.height / 2) + i.menuSpot * 300 - (i.height / 2), angle: i.menuSpot * -20}, 0.4, {
		//		ease: FlxEase.quadOut,
		//		onComplete: function(twn:FlxTween)
		//		{
		//			//spr.kill();
		//		}
		//	});
		//}
		
		//FlxG.camera.follow(camFollowPos, null, 1);

		//var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		//versionShit.scrollFactor.set();
		//versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//add(versionShit);
		//var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		//versionShit.scrollFactor.set();
		//versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();
		
		

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		
		if (!Achievements.isAchievementUnlocked('all_voltz_clear'))
		{
			var hundredpercent:Bool = true;
			for (i in 0...27) {
				if (Achievements.isAchievementUnlocked(Achievements.achievementsStuff[i][2])) { 
					trace('$i: ' + Achievements.achievementsStuff[i][2] + ' - yes');
				}
				else if (i == 17) {
					trace('$i: ' + 'the 100% achievment - not likely!');
				}
				else {
					trace('$i: ' + Achievements.achievementsStuff[i][2] + ' - no!');
					hundredpercent = false;
				}	
			}
			if (hundredpercent) {	//if it goes thru the whole thing without setting it to false it means you have all the achievmeents
				basicAwardGrant('all_voltz_clear');
			}
			else { trace('sorry kid ya didnt make it'); }
		}
		else { trace('the hell you back here for'); }
		#end

/*		for	(spr in grpCharacters)
		{
			spr.origin.set(0, 0);
		}
		
		for	(spr in grpCharBlack)
		{
			spr.origin.set(940, 346);
		}
		
		for	(spr in grpCharColor)
		{
			spr.origin.set(940, 346);
		}
		
		for	(spr in grpExtras)
		{
			spr.origin.set(940, 346);
		}*/
	
		super.create();
		new FlxTimer().start(0, function(tmr:FlxTimer)
		{
			//changeItem();
			transIntroSetup();
		});
	}
	
	function transIntroSetup()
	{
		Conductor.changeBPM(92);
		
		add(introSweep);
		add(grpExtras);
		add(grpCharBlack);
		add(grpCharColor);
		add(grpCharacters);
		add(grpThings);
		add(daLogo);
		add(menuItems);
		add(coverUp);
		coverUp.scale.set(1.5, 1.5);

		loadImages(grpBGs, 'bg');
		loadImages(grpSparks, 'spark');
		loadImages(grpCharColor, 'charcolor');
		loadImages(grpCharBlack, 'charblack');
		loadImages(grpExtras, 'extra');
		loadImages(grpCharacters, 'character');
		loadImages(grpThings, 'funkin thing');
		
		introSweep.frames = Paths.getSparrowAtlas('mainmenu/voltz/intro');
		introSweep.antialiasing = ClientPrefs.globalAntialiasing;
		introSweep.animation.addByPrefix('intro', 'a', 20, false);
		
		hiLogo();
		comeInSetup(grpExtras);
		comeInSetup(grpCharBlack);
		comeInSetup(grpCharColor);
		comeInSetup(grpCharacters);
		comeInSetup(grpThings);
		comeInSetup(grpSparks);
		introSetup();
	}

	function loadImages(grp:FlxTypedGroup<MenuThing>, name:String) {
		for (i in 0...fileDirectories.length) {
			var spr:MenuThing = new MenuThing();
			spr.loadGraphic(Paths.image('mainmenu/' + fileDirectories[i] + '/' + name));
			spr.antialiasing = ClientPrefs.globalAntialiasing;
			if (i != 0)
				spr.alpha = 0;
			grp.add(spr);
			spr.ID = i;
		}
	}

	function transition(grp:FlxTypedGroup<MenuThing>, xPos:Int, yPos:Int, time:Float)
		{
				for (spr in grp) 
					{
						FlxTween.cancelTweensOf(spr);
						FlxTween.tween(spr, {x: spr.x + xPos, y: spr.y + yPos}, time, {
						ease: FlxEase.cubeIn,
						onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
		}
	
	//setting up the logo-specific scroll in for the opening
	function hiLogo() {
		FlxTween.tween(daLogo, {alpha: 0}, 0.01, {
		ease: FlxEase.linear
		});
		FlxTween.tween(daLogo, {x: 10, y: 400}, 0.01, {
		ease: FlxEase.linear
		});
	}	
	
	//bringin in the logo
	function setUpDaLogo() {
		FlxTween.tween(daLogo, {x: 1046, y: 565}, 0.1, {
		ease: FlxEase.linear,
		onComplete: function(twn:FlxTween)
		{
			FlxTween.tween(daLogo, {alpha: 1}, 0.3, {
			ease: FlxEase.linear
			});
		}
		});
	}
	
	public var hasPlayed:Bool = false;

	//setting up the scroll in for the opening
	function comeInSetup(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) 
		{
			FlxTween.tween(spr, {x: 1280, y: 0}, 0.01, {
			ease: FlxEase.linear,
			onComplete: function(twn:FlxTween)
			{
				//coverUp.scale.set(0, 0);
			}
			});
		}
	}	
	
	//for sparks to come back
	function comeInSparks(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) 
		{
			spr.x = 0;
			spr.y = 0;
		}
	}

	//setting up the animation thing for the intro
	function introSetup(){
		FlxTween.cancelTweensOf(introSweep);
		FlxTween.tween(introSweep, {x: 1280, y: 0}, 0.1, {
		ease: FlxEase.linear,
		onComplete: function(twn:FlxTween)
		{
			goBitchGo();
		}
		});
	}	
	
	//setting up the animation thing for the intro
	function goBitchGo(){
		for (spr in grpSparks)
		{
			FlxTween.tween(spr, {x: 1300, y: 0}, 0.01, {
			ease: FlxEase.linear,
			onComplete: function(twn:FlxTween)
			{
				charRotation1(grpCharacters);
				FlxTween.tween(spr, {x: 1320, y: 0}, 0.2, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					charRotation1(grpCharColor);
					FlxTween.tween(spr, {x: 1340, y: 0}, 0.2, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						charRotation1(grpExtras);
						charRotation1(grpCharBlack);
					}
					});	
				}
				});
			}
			});
		}

		introTransition(grpCharacters);
		introTransition(grpExtras);
		hasPlayed = false;
		if (hasPlayed)
			{
				alphaTransition(grpThings);
			}
		introTransitionBlack(grpCharBlack);
		introTransitionColor(grpCharColor);
		menuReady();
		//setUpDaLogo();

		introSweep.animation.play('intro', true);
		FlxTween.tween(introSweep, {x: 0, y: 0}, 0.7, {
		ease: FlxEase.cubeOut,
		onComplete:function(twn:FlxTween)
		{
			//trace('glitch occurs here');
			changeItem();
			comeInSparks(grpSparks);
			notBusy = true;
			justCame = true;
			FlxTween.cancelTweensOf(introSweep);
			introSweep.visible = false;
			FlxTween.tween(introSweep, {alpha: 0}, 0.1 , {
			ease: FlxEase.linear,
			onComplete:function(twn:FlxTween)
			{
				sparkSlide1(grpSparks);
				justCame = false;
				inputTaken = false;
			}
			});
		}
		});
		FlxTween.tween(orangeStuph, {alpha: 0}, 0.4 , {
		ease: FlxEase.linear,
		onComplete:function(twn:FlxTween)
			{
				thingTransition(grpThings);
				setUpDaLogo();
				hasPlayed = true;
			}
		});	
		FlxTween.tween(coverUp, {alpha: 0}, 0.5 , {
		ease: FlxEase.linear
		});
//		FlxTween.tween(optionsIntro, {x: 0, y: 0}, 1, {
//		ease: FlxEase.quadOut,
//		onComplete:function(twn:FlxTween)
//		{
//			menuReady();
//			add(menuItems);
//			FlxTween.tween(optionsIntro, {alpha: 0}, 0.1, {
//			ease: FlxEase.linear,
//			onComplete:function(twn:FlxTween)
//			{	
//				justCame = false;
//				inputTaken = false;
//			}
//			});
//		}
//		});
	}

	
	
	
	function menuReady(){
		for (i in 0...optionShit.length)
		{
			var offset:Float = 10 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:MenuThing = new MenuThing(0, (i * 140)  + offset);
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
			if (i != 0)
			{
				menuItem.scale.set(0.7, 0.7);
			}
			else
			{
				menuItem.scale.set(0.9, 0.9);
				menuItem.animation.play('selected');
			}
			
		}
		calculateSpot();
		for (i in menuItems) {
			if (i.ID == curSelected)
				{
					if (i.ID == 0)
						{
							i.offset.x += 20;
						}
				}
			i.y = (FlxG.height / 2) + (i.menuSpot + 3) * 300 - (i.height / 2);
			i.angle = (i.menuSpot + 3) * -15;
			FlxTween.tween(i, {y: (FlxG.height / 2) + i.menuSpot * 300 - (i.height / 2), angle: i.menuSpot * -15}, 0.4, {
				ease: FlxEase.cubeOut,
				onComplete: function(twn:FlxTween)
				{
					//spr.kill();
				}
			});
		}
	}
	
	//Gets corner sprite to fade in on startup
	function thingTransition(grp:FlxTypedGroup<MenuThing>)
		{
			for (spr in grp) {
				FlxTween.cancelTweensOf(spr);
				spr.x = 0;
				spr.y = 0;
				if (spr.ID == 0)
				{
					spr.alpha = 0;
					FlxTween.tween(spr, {alpha: 1}, 0.5, {
						ease: FlxEase.quadOut
						});
				}
			}
		}

	//for sprites that only use alpha to transition
	function alphaTransition(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			FlxTween.cancelTweensOf(spr);
			if (spr.ID == curSelected) {
				FlxTween.tween(spr, {x: 0, y: 0}, 0.01, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr, {alpha: 1}, 0.3, {
						ease: FlxEase.linear
						});
					}
				});
			} else {
				FlxTween.tween(spr, {alpha: 0}, 0.3, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						inputTaken = false;
						FlxTween.tween(spr, {x: 0, y: 0}, 0.3, {
						ease: FlxEase.linear
						});
					}
				});
			}
		}
	}	
	
	//for transitioning the sparks w/o losing slide
	function sparkTransition(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			if (spr.ID == curSelected) {
					FlxTween.tween(spr, {alpha: 1}, 0.3, {
					ease: FlxEase.linear
					});
			} else {
				FlxTween.tween(spr, {alpha: 0}, 0.3, {
				ease: FlxEase.linear
				});
			}
		}
	}	
	
	//for the spark slide back and forth
	function sparkSlide1(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			FlxTween.tween(spr, {x: -50}, 3.5,
				{
				ease: FlxEase.quadInOut,
				type: FlxTweenType.PINGPONG
				});
		}
		}		
	
	//for to make the character turn
	function charRotation1(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
		if (spr.ID == curSelected) {
			FlxTween.angle(spr, 4, -4, 5, {
				ease: FlxEase.sineInOut,
				onComplete: function(twn:FlxTween)
				{
				charRotation2(grp);
				}
			});
		}
		}
	}	
	
	//for to make the character turn
	function charRotation2(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
		if (spr.ID == curSelected) {
			FlxTween.angle(spr, -4, 4, 5, {
				ease: FlxEase.sineInOut,
				onComplete: function(twn:FlxTween)
				{
				charRotation1(grp);
				}
			});
		}
		}
	}	

	
	//for sliding in on the intro
	function introTransition(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			if (spr.ID == curSelected) {
				FlxTween.tween(spr, {x: 800, y: 0}, 0.1, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.1, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(spr, {x: 30, y: 0}, 0.6, {
							ease: FlxEase.cubeOut,
							onComplete: function(twn:FlxTween)
							{
								//spr.kill();
							}
							});
						}
					});
				}	
				});
			}
		}
	}	
	
	//for sliding in on the intro (color silhouette)
	function introTransitionColor(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			if (spr.ID == curSelected) {
				FlxTween.tween(spr, {x: 800, y: 0}, 0.1, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.15, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(spr, {x: 30, y: 0}, 0.6, {
							ease: FlxEase.cubeOut,
							onComplete: function(twn:FlxTween)
							{
								//spr.kill();
							}
							});
						}
					});
				}	
				});
			}
		}
	}
	
	//for sliding in on the intro (black silhouette)
	function introTransitionBlack(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			if (spr.ID == curSelected) {
				FlxTween.tween(spr, {x: 800, y: 0}, 0.1, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.2, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(spr, {x: 33, y: 0}, 0.6, {
							ease: FlxEase.cubeOut,
							onComplete: function(twn:FlxTween)
							{
								//spr.kill();
							}
							});
						}
					});
				}	
				});
			}
		}
	}
	
	//for character sprites to move in n out
	function charTransition(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			FlxTween.cancelTweensOf(spr);
			if (spr.ID == curSelected) {
				FlxTween.tween(orangeStuph, {x: 1300, y: 0}, 0.01, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					charRotation1(grpCharacters);
					FlxTween.tween(orangeStuph, {x: 1320, y: 0}, 0.2, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						charRotation1(grpCharColor);
						FlxTween.tween(orangeStuph, {x: 1340, y: 0}, 0.2, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							charRotation1(grpExtras);
							charRotation1(grpCharBlack);
						}
						});	
					}
					});
				}
				});
				FlxTween.tween(spr, {x: 800, y: 0}, 0.1, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.1, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(spr, {x: 30, y: 0}, 0.8, {
							ease: FlxEase.cubeOut,
							onComplete: function(twn:FlxTween)
							{
								//spr.kill();
							}
							});
						}
					});
				}	
			});
			} else {
				FlxTween.tween(spr, {x: 1600, y: 0}, 0.74, {
					ease: FlxEase.cubeIn,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr, {alpha: 0}, 0.1, {
						ease: FlxEase.linear,
						});
					}
				});
			}
		}
	}
	
	//for character colorshadows to move in n out
	function charColorTransition(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			FlxTween.cancelTweensOf(spr);
			if (spr.ID == curSelected) {
				FlxTween.tween(spr, {x: 800, y: 0}, 0.1, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.15, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(spr, {x: 30, y: 0}, 0.8, {
							ease: FlxEase.cubeOut,
							onComplete: function(twn:FlxTween)
							{
								//spr.kill();
							}
							});
						}
					});
				}	
			});
			} else {
				FlxTween.cancelTweensOf(spr);
				FlxTween.tween(spr, {x: 1600, y: 0}, 0.75, {
					ease: FlxEase.cubeIn,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr, {alpha: 0}, 0.1, {
						ease: FlxEase.linear,
						});
					}
				});
			}
		}
	}
	
	//for character trueshadows to move in n out
	function charBlackTransition(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			FlxTween.cancelTweensOf(spr);
			if (spr.ID == curSelected) {
				FlxTween.tween(spr, {x: 800, y: 0}, 0.1, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.2, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(spr, {x: 33, y: 0}, 0.8, {
							ease: FlxEase.cubeOut,
							onComplete: function(twn:FlxTween)
							{
								//spr.kill();
							}
							});
						}
					});
				}	
			});
			} else {
				FlxTween.cancelTweensOf(spr);
				FlxTween.tween(spr, {x: 1600, y: 0}, 0.76, {
					ease: FlxEase.cubeIn,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr, {alpha: 0}, 0.1, {
						ease: FlxEase.linear,
						});
					}
				});
			}
		}
	}
	
	//for the little fuckers to move in n out
	function extrTransition(grp:FlxTypedGroup<MenuThing>) {
		for (spr in grp) {
			FlxTween.cancelTweensOf(spr);
			if (spr.ID == curSelected) {
				FlxTween.tween(spr, {x: 650, y: 0}, 0.1, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.4, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(spr, {x: 30, y: 0}, 0.6, {
							ease: FlxEase.cubeOut,
							onComplete: function(twn:FlxTween)
							{
								//spr.kill();
							}
							});
						}
					});
				}	
			});
			} else {
				FlxTween.cancelTweensOf(spr);
				FlxTween.tween(spr, {x: 700, y: 0}, 0.7, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr, {alpha: 0}, 0.1, {
						ease: FlxEase.linear,
						});
					}
				});
			}
		}
	}
	

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	function basicAwardGrant(awardname:String) { 
			Achievements.loadAchievements();
			var achieveID:Int = Achievements.getAchievementIndex(awardname);
			if (achieveID != -1) {
				var redundant:String = Achievements.achievementsStuff[achieveID][2];
				if(!Achievements.isAchievementUnlocked(redundant)) { 
					Achievements.achievementsMap.set(redundant, true);
					add(new AchievementObject(redundant,camAchievement));
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

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		// MENU ORIGINS FOR ROTATION
		for	(spr in grpCharacters)
		{
			spr.origin.set(940, 346);
		}

		for	(spr in grpCharBlack)
		{
			spr.origin.set(940, 346);
		}
		
		for	(spr in grpCharColor)
		{
			spr.origin.set(940, 346);
		}
		
		for	(spr in grpExtras)
		{
			spr.origin.set(940, 346);
		}

		for	(spr in grpThings)
			{
				spr.origin.set(1280, 720);
			}

		if (FlxG.sound.music != null)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		/*for (i in grpSparks) {
			if (!Math.isNaN(i.offset.x)) {
				i.offset.x = i.offset.x + ((Math.sin((elapsed / 400) * (180 / Math.PI))) * 50);
			}
			
			trace(i.offset.x);
		}*/
		var lerpVal:Float = CoolUtil.boundTo(elapsed * 5.6, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P && !inputTaken)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P && !inputTaken)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK && !inputTaken)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT && !inputTaken)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							transition(grpSparks, 1400, 0, 0.7);
							transition(grpThings, 500, 0, 0.72);
							transition(grpCharacters, 700, 0, 0.7);
							transition(grpCharBlack, 700, 0, 0.8);
							transition(grpCharColor, 700, 0, 0.75);
							transition(grpExtras, 700, 0, 0.82);
							transition(grpBGs, 1400, 0, 0.7);
									FlxTween.tween(scrollDots, {x: scrollDots.x + 1000}, 0.7, {
										ease: FlxEase.cubeIn
										});
							FlxTween.tween(daLogo, {x: daLogo.x + 500}, 0.7, {
								ease: FlxEase.cubeIn
								});
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];
								switch (daChoice)
								{
									case 'story_mode':
										new FlxTimer().start(0.5, function(tmr:FlxTimer)
											{
												MusicBeatState.switchState(new CharSelectState());
											});
									case 'freeplay':
										new FlxTimer().start(0.5, function(tmr:FlxTimer)
											{
												//MusicBeatState.switchState(new FreeplayState());
												MusicBeatState.switchState(new FreeplaySelect());
											});
									case 'extras':
										new FlxTimer().start(0.2, function(tmr:FlxTimer)
											{
												backTrans();
											});
									case 'options':
										new FlxTimer().start(0.5, function(tmr:FlxTimer)
											{
												MusicBeatState.switchState(new options.OptionsState());
											});
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.justPressed.SEVEN)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
			spr.x -= 350;
		});
	}

	function backTrans()
		{
			var blackSquare:FlxSprite = new FlxSprite();
				blackSquare.makeGraphic(1300, 750, 0xFF9c47ff);
				blackSquare.screenCenter();
				blackSquare.alpha = 0;
				add(blackSquare);
				FlxTween.tween(blackSquare, {alpha: 1}, 0.4, {
					onComplete: function(twn:FlxTween)
						{
							new FlxTimer().start(0.4, function(tmr:FlxTimer)
								{
									MusicBeatState.switchState(new ExtrasMenu());
								});
						}
					});
		}
	function calculateSpot() {
		
		var bullShit:Int = 0;
		for (item in menuItems.members)
		{
			item.prevMenuSpot = item.menuSpot;
			item.menuSpot = bullShit - curSelected;
			bullShit++;
			if (item.menuSpot == 3)
				item.menuSpot = -1;
			if (item.menuSpot == -3)
				item.menuSpot = 1;
		}
		
	}
	
	function changeItem(huh:Int = 0)
	{
		inputTaken = true;
		notBusy = false;
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		calculateSpot();

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.offset.y = 0;
			spr.updateHitbox();
			spr.centerOrigin();

			if (spr.ID == curSelected)
			{
			//	spr.offset.x += 20;
				spr.animation.play('selected');
				//spr.scale.set(1, 1);
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
				FlxG.log.add(spr.frameWidth);
				switch (spr.ID)
				{
					case 0:
						spr.offset.x += 20;
					case 1:
						spr.offset.x += 50;
					case 2:
						spr.offset.x += 20;
					case 3:
						spr.offset.x += 40;
				}
			}
			else{
			if(!justCame)
			{
			//	spr.offset.x -= 20;
			}
			}

		});
		
		if (!justCame)
		{
		alphaTransition(grpBGs);
		sparkTransition(grpSparks);
		if (hasPlayed)
			{
				sparkTransition(grpThings);
			}
		extrTransition(grpExtras);
		charTransition(grpCharacters);
		charColorTransition(grpCharColor);
		charBlackTransition(grpCharBlack);
		dotspeed();
		}
		
		for (spr in menuItems) {
			FlxTween.cancelTweensOf(spr);
			spr.y = (FlxG.height / 2) + (spr.menuSpot + huh) * 300 - (spr.height / 2);
			spr.angle = (spr.menuSpot + huh) * -15;

			//trace(spr.menuSpot);

			//tweens positions of menuitems
			FlxTween.tween(spr, {y: (FlxG.height / 2) + spr.menuSpot * 300 - (spr.height / 2), angle: spr.menuSpot * -15}, 0.6, {
				ease: FlxEase.quartOut,
				onComplete: function(twn:FlxTween)
				{
					notBusy = true;
				}
			});

			//a bit of a dumb solution but it fixes a glitch where menuitems sometimes disappear instead of going offscreen
			if (spr.prevMenuSpot == -huh) {
				FlxTween.cancelTweensOf(spr);
				spr.y = (FlxG.height / 2) + (-huh * 300) - (spr.height / 2);
				spr.angle = (-huh * -15);
				FlxTween.tween(spr, {y: (FlxG.height / 2) + (2 * -huh) * 300 - (spr.height / 2), angle: (2 * -huh) * -15}, 0.6, {
					ease: FlxEase.quartOut,
					onComplete: function(twn:FlxTween)
					{
					}
				});
			}

			//tweens scale of menuitems
			if (spr.ID == curSelected) {
				FlxTween.tween(spr.scale, {x: 0.9, y: 0.9}, 0.3, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
					}
				});
			} else {
				FlxTween.tween(spr.scale, {x: 0.7, y: 0.7}, 0.3, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
					}
				});
			}
		}
		
	}
	
	//for the little fuckers to move in n out
	function dotspeed() {
		scrollDots.velocity.set(40, 0);
		FlxTween.tween(orangeStuph, {x: 6000, y: 0}, 0.05, {
		ease: FlxEase.linear,
		onComplete: function(twn:FlxTween)
		{
			scrollDots.velocity.set(60, 0);
			FlxTween.tween(orangeStuph, {x: 1000, y: 0}, 0.1, {
			ease: FlxEase.linear,
			onComplete: function(twn:FlxTween)
				{
					scrollDots.velocity.set(70, 0);
					FlxTween.tween(orangeStuph, {x: 1200, y: 0}, 0.5, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						scrollDots.velocity.set(60, 0);
						FlxTween.tween(orangeStuph, {x: 1400, y: 0}, 0.2, {
						ease: FlxEase.linear,
						onComplete: function(twn:FlxTween)
						{
							scrollDots.velocity.set(45, 0);
							FlxTween.tween(orangeStuph, {x: 1600, y: 0}, 0.12, {
							ease: FlxEase.linear,
							onComplete: function(twn:FlxTween)
							{
								scrollDots.velocity.set(30, 0);
							}
							});
						}
						});
					}
					});
				}
				});
			}
		});
	}

	override function beatHit()
	{
		super.beatHit();
		
		FlxTween.tween(daLogo.scale, {x: 1.07, y: 1.07}, 0.025, {
		ease: FlxEase.linear,
		onComplete: function(twn:FlxTween)
		{
			FlxTween.tween(daLogo.scale, {x: 1, y: 1}, 0.3, {
			ease: FlxEase.quadOut
			});
		}
		});		
		
		for (spr in grpThings){
			if (spr.ID == curSelected) {
			FlxTween.tween(spr.scale, {x: 1.02, y: 1.02}, 0.025, {
			ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr.scale, {x: 1, y: 1}, 0.3, {
					ease: FlxEase.quadOut
					});
				}
			});	
			}
		}		
		
		for (spr in grpCharacters){
			if (spr.ID == curSelected) {
			FlxTween.tween(spr.scale, {x: 1.02, y: 1.02}, 0.025, {
			ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr.scale, {x: 1, y: 1}, 0.3, {
					ease: FlxEase.quadOut
					});
				}
			});		
			}
		}	
		for (spr in grpCharColor){
			if (spr.ID == curSelected) {
			FlxTween.tween(spr.scale, {x: 1.02, y: 1.02}, 0.025, {
			ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr.scale, {x: 1, y: 1}, 0.3, {
					ease: FlxEase.quadOut
					});
				}
			});		
			}
		}		
		for (spr in grpCharBlack){
			if (spr.ID == curSelected) {
			FlxTween.tween(spr.scale, {x: 1.02, y: 1.02}, 0.025, {
			ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr.scale, {x: 1, y: 1}, 0.3, {
					ease: FlxEase.quadOut
					});
				}
			});		
			}
		}		
		for (spr in grpExtras){
			if (spr.ID == curSelected) {
			FlxTween.tween(spr.scale, {x: 1.02, y: 1.02}, 0.025, {
			ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr.scale, {x: 1, y: 1}, 0.3, {
					ease: FlxEase.quadOut
					});
				}
			});		
			}
		}
		
		//menu item bounce? considering it
		menuItems.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curSelected && notBusy) 
			{
				FlxTween.tween(spr.scale, {x: 0.95, y: 0.95}, 0.025, {
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr.scale, {x: 0.9, y: 0.9}, 0.3, {
					ease: FlxEase.quadOut
					});
				}
				});
			} else{
				if (notBusy)
				{
					FlxTween.tween(spr.scale, {x: 0.68, y: 0.692}, 0.025, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr.scale, {x: 0.7, y: 0.7}, 0.3, {
						ease: FlxEase.quadOut
						});
					}
					});
				}
			}
		});
		
	}
	
}

class MenuThing extends FlxSprite {
	public var prevMenuSpot:Int = 0;
	public var menuSpot:Int = 0;
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}
}