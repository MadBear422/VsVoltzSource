package;

import flixel.FlxObject;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.BitmapFilter;
import lime.math.ColorMatrix;
import flixel.FlxCamera;
#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
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
import flixel.util.FlxColor;
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

class CharSelectState extends MusicBeatState
{
	var daCharacter:FlxText;
	public static var curSelected:Int = 0;

	var newShader:ColorSwap = new ColorSwap();
	var oldShader:ColorSwap = new ColorSwap();

	public var sat:ColorSwap = new ColorSwap();

	var coverUp:FlxSprite = new FlxSprite().loadGraphic(Paths.image('titlemenu/thing'));

	var play_characters:FlxTypedGroup<FlxSprite>;

	var selectedcharacter:Bool = false;
	var canSelect:Bool = false;
	var noFuckYou:Bool = true;

	private var camGame:FlxCamera;
	private var camDistort:FlxCamera;
	private var camNormal:FlxCamera;

	var selText:FlxSprite;
	var noDan:FlxSprite;
	var effect = new MosaicEffect();
	var deSat = new ColorMatrixFilter();
	var effectX = new MosaicEffect();
	var effectTween:FlxTween;
	var effectTweenX:FlxTween;

	var characters:Array<String> = [
		'bf', 
		'voltz'
	];

	var character_names:Array<String> = [
		'BOYFRIEND
		\n-gets bitches
		\n-has balls
		\n-bitch', 
		'VOLTZ
		\n-gets no bitches
		\n-bullies children
		\n-war criminal'
	];

	var camFollow:FlxObject;

	override public function create()
	{
		persistentUpdate = persistentDraw = true;
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;

		coverUp.setGraphicSize(Std.int(coverUp.width * 10));
		coverUp.screenCenter();
		coverUp.alpha = 0;
		add(coverUp);
		camDistort = new FlxCamera();
		camNormal = new FlxCamera();
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camDistort);
		FlxG.cameras.add(camNormal);
		camGame.bgColor.alpha = 0;
		camDistort.bgColor.alpha = 0;
		camNormal.bgColor.alpha = 0;
		FlxCamera.defaultCameras = [camGame];

		camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);

		effectTweenX = FlxTween.num(12, 14, 1, {type: LOOPING}, function(v)
			{
				effectX.setStrength(v, v);
			});
		effectTween = FlxTween.num(6, 8, 1, {type: LOOPING}, function(v)
			{
				effect.setStrength(v, v);
			});
	//	bg = new FlxSprite().loadGraphic(Paths.image('menuBGMagenta'));
	//	add(bg);
	newShader.saturation = -1;
	newShader.brightness = -0.5;
	oldShader.saturation = 0;
	oldShader.brightness = 0;

		selText = new FlxSprite(0, -625).loadGraphic(Paths.image('charselect/charselect'));
		selText.screenCenter(X);
		add(selText);


		daCharacter = new FlxText(0, 0, FlxG.width, "hi my name is sans sussy chungus", 24);
		daCharacter.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		daCharacter.borderColor = FlxColor.BLACK;
		daCharacter.borderSize = 3;
		daCharacter.borderStyle = FlxTextBorderStyle.OUTLINE;
		daCharacter.screenCenter();
		daCharacter.alpha = 0;
		add(daCharacter);

		play_characters = new FlxTypedGroup<FlxSprite>();

		//trace(characters.length);
		super.create();
		for (i in 0...characters.length)
			{
				var subject:FlxSprite = new FlxSprite(0, 700);
				subject.frames = Paths.getSparrowAtlas('charselect/character_' + characters[i]);
				subject.animation.addByPrefix('idle', "Idle", 24, true);
				subject.animation.addByPrefix('still', "Still", 24, true);
				subject.animation.addByPrefix('selected', "Selected", 24, false);
				subject.ID = i;
				subject.scale.x = 0.75;
				subject.scale.y = 0.75;
				subject.antialiasing = ClientPrefs.globalAntialiasing;
				play_characters.add(subject);
			}
		add(play_characters);
		noDan = new FlxSprite(0, 700).loadGraphic(Paths.image('charselect/nodanforyou'));
		noDan.scale.x = 0.75;
		noDan.scale.y = 0.75;
		noDan.antialiasing = ClientPrefs.globalAntialiasing;
		noDan.cameras = [camNormal];
		if (!FlxG.save.data.straightbuttsex)
		add(noDan);
		FlxG.camera.follow(camFollow);
		startIntro();
	}

	var rc:Float = 1 / 3;
	var gc:Float = 1 / 2;
	var bc:Float = 1 / 6;

	override function update(elapsed:Float)
	{
		#if debug
		if (FlxG.keys.justPressed.R)
			{
				FlxG.save.data.voltzUnlockMessage = false;
				trace('voltz message reset');
			}
		#end
		camDistort.setFilters([new ColorMatrixFilter([rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0])]);
		noDan.shader = effectX.shader;
		daCharacter.text = character_names[curSelected];
		for (subject in play_characters)
			{
				if (subject.ID == 0)
					{
						if (!selectedcharacter)
							{
								subject.offset.y = -200-50;
							}
					}
				if (subject.ID == 1)
					{
						if (!selectedcharacter)
							{
								noDan.offset.x = -720;
								noDan.offset.y = -225;
								subject.offset.x = -700;
								subject.offset.y = -225;
							}
					}

				if (subject.ID == curSelected && !selectedcharacter)
					{
						subject.setColorTransform();
						subject.shader = oldShader.shader;
						subject.cameras = [camNormal];
						subject.animation.play('idle');
					}
				if (subject.ID != curSelected)
					{
						subject.setColorTransform(0.5, 0.5, 0.5);
						subject.shader = effect.shader;
						subject.cameras = [camDistort];
						subject.animation.play('still');
					}
				/*if (subject.ID == curSelected)
					{
						sat.saturation = 0;
						subject.shader = sat.shader;
					}
				else
					{
						sat.saturation = -1;
						subject.shader = sat.shader;
					}*/
			}
		if (!selectedcharacter)
			{
				if (canSelect)
					{
		if (controls.UI_LEFT_P)
			{
				if (!FlxG.save.data.straightbuttsex)
					{
						if (noFuckYou)
							{
								FlxG.sound.play(Paths.sound('noFuckYou'));
								camGame.shake(0.01, 0.15);
								camDistort.shake(0.01, 0.15);
								camNormal.shake(0.01, 0.15);
								noFuckYou = !noFuckYou;
								new FlxTimer().start(0.9, function(tmr:FlxTimer)
									{
										noFuckYou = !noFuckYou;
									});
							}
					}
				else
					{
						FlxG.sound.play(Paths.sound('scrollMenu'));
						change(-1);
					}
			}

			if (controls.UI_RIGHT_P)
			{
				if (!FlxG.save.data.straightbuttsex)
					{
						if (noFuckYou)
							{
								FlxG.sound.play(Paths.sound('noFuckYou'));
								camGame.shake(0.01, 0.15);
								camDistort.shake(0.01, 0.15);
								camNormal.shake(0.01, 0.15);
								noFuckYou = !noFuckYou;
								new FlxTimer().start(0.9, function(tmr:FlxTimer)
									{
										noFuckYou = !noFuckYou;
									});
						}
					}
				else
					{
						FlxG.sound.play(Paths.sound('scrollMenu'));
						change(1);
					}
			}

			if (controls.ACCEPT)
				{
					FlxG.save.data.selectedCharcter = characters[curSelected];
					trace(characters[curSelected]);
					camNormal.flash(FlxColor.WHITE, 0.3);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					selectedcharacter = true;
					for (subject in play_characters)
						{
							if (subject.ID == curSelected)
								{
									if (subject.ID == 1)
										subject.offset.x = -355;
									else
										{
											subject.offset.x = -315;
											subject.offset.y = -200;
										}
									subject.offset.y = -25;
									subject.scale.x = 1; subject.scale.y = 1;
									var charText:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('charselect/' + characters[curSelected] + '_text'));
									charText.screenCenter();
									add(charText);
									subject.animation.play('selected', true);
									subject.animation.finishCallback = function(pog:String)
										{
											FlxTween.tween(subject, {y: subject.y + 700}, 1, {
												ease: FlxEase.cubeIn,
												onComplete: function(twn:FlxTween)
													{
														MusicBeatState.switchState(new StoryMenuState());
													}

											});
											FlxTween.tween(charText, {y: charText.y + 700}, 1.15, {
												ease: FlxEase.cubeIn,
											});
										}
								}
							if (subject.ID != curSelected)
								{
									subject.visible = false;
									daCharacter.visible = false;
									selText.visible = false;
									noDan.visible = false;
								}
						}
				}
				if (controls.BACK)
					{
						canSelect = false;
						FlxG.sound.play(Paths.sound('cancelMenu'));
						for (subject in play_characters)
							{
								FlxTween.tween(subject, {y: subject.y + 700}, 0.8, {
									ease: FlxEase.cubeIn,
									onComplete: function(twn:FlxTween)
										{
											MusicBeatState.switchState(new MainMenuState());
										}
									});
								FlxTween.tween(noDan, {y: noDan.y + 700}, 0.8, {
									ease: FlxEase.cubeIn
									});
								FlxTween.tween(selText, {y: selText.y - 700}, 0.8, {
									ease: FlxEase.cubeIn
									});
								FlxTween.tween(daCharacter, {alpha: 0}, 0.3, {
									ease: FlxEase.cubeIn,
									onComplete: function(twn:FlxTween)
										{
											FlxTween.tween(coverUp, {alpha: 1}, 0.4, {
												ease: FlxEase.cubeIn
											});
										}
									});
								
							}
					}
			}
		}
		super.update(elapsed);
	}

	function startIntro()
		{
			for (subject in play_characters)
				{
					FlxTween.tween(subject, {y: subject.y - 700}, 1.7, {
						ease: FlxEase.cubeOut,
						onComplete: function(twn:FlxTween)
							{
								canSelect = true;
							}
						});
				}
			FlxTween.tween(noDan, {y: noDan.y - 700}, 1.7, {
				ease: FlxEase.cubeOut
				});
			FlxTween.tween(selText, {y: selText.y + 700}, 1.7, {
				ease: FlxEase.cubeOut
				});
			new FlxTimer().start(1.1, function(tmr:FlxTimer)
				{
					FlxTween.tween(daCharacter, {alpha: 1}, 0.6, {
						ease: FlxEase.cubeOut
						});
				});
		}

	function change(am:Int){
		curSelected += am;

		if(curSelected >= characters.length){
			curSelected = 0;
		}
		if(curSelected < 0){
			curSelected = characters.length-1;
		}
		trace('character selected is ' + FlxG.save.data.selectedCharcter);
	}
}