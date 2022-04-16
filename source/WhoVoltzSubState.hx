import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

using StringTools;

class WhoVoltzSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var text:FlxSprite;
	var voltz:FlxSprite;
	var curText:Int = 1;
	var canInput:Bool = false;
	public function new()
	{
		super();

		// Mouse Cursor
		FlxG.mouse.enabled = true;
		FlxG.mouse.visible = true;
		var smashCursor:FlxSprite = new FlxSprite();
		smashCursor.loadGraphic(Paths.image('cursor'));
		smashCursor.antialiasing = ClientPrefs.globalAntialiasing;
		FlxG.mouse.load(smashCursor.pixels, 0.25, -5, -5);

		bg = new FlxSprite().loadGraphic(Paths.image('who/BG1'), false, FlxG.width, FlxG.height);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		text = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('who/Text1'), false, FlxG.width, FlxG.height);
		text.scrollFactor.set();
		add(text);

		voltz = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('who/Voltz'), false, FlxG.width, FlxG.height);
		voltz.scrollFactor.set();
		add(voltz);
		
		new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				FlxTween.tween(text, {y: 0}, 1, {
				ease: FlxEase.expoOut,
				onComplete: function(twn:FlxTween)
					{
						canInput = true;
					}
				});
				FlxTween.tween(voltz, {y: 0}, 1, {
				ease: FlxEase.expoOut
				});
				basicAwardGrant('voltz_menu');
			});

	}

    var fakehitbox:Array<Float> = [670,300,820,340]; // twitch
    var fakehitbox2:Array<Float> = [1030,250,1200,300];// youtube
    var fakehitbox3:Array<Float> = [870,570,970,630];// turkey
    var fakehitbox4:Array<Float> = [1020,540,1200,580];// credits
	var useUnderline:Bool = false;
	var useUnderline2:Bool = false;
	var backwarddd:Bool = false;
	override function update(elapsed:Float)
	{
		if (!backwarddd && bg.alpha < 1)
			{
				bg.alpha += elapsed * 1.5;
				if(bg.alpha > 1) bg.alpha = 1;
			}
		else if (bg.alpha > 0)
			{
				bg.alpha -= elapsed * 1.5;
				if(bg.alpha < 0) bg.alpha = 0;
			}

		if(controls.UI_LEFT_P && canInput) {
			curText--;
			if (curText < 1)
				curText = 3;
			bg.loadGraphic(Paths.image('who/BG${curText}'));
			text.loadGraphic(Paths.image('who/Text${curText}'));
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
		}
		else if (controls.UI_RIGHT_P && canInput)
		{
			curText++;
			if (curText > 3)
				curText = 1;
			bg.loadGraphic(Paths.image('who/BG${curText}'));
			text.loadGraphic(Paths.image('who/Text${curText}'));
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
		}

		if (curText == 3 && ((FlxG.mouse.screenX > fakehitbox[0] && FlxG.mouse.screenX < fakehitbox[2]) && (FlxG.mouse.screenY > fakehitbox[1] && FlxG.mouse.screenY < fakehitbox[3])))
			{
				text.loadGraphic(Paths.image('who/TextTW'));
				useUnderline = true;
				if (canInput && FlxG.mouse.justPressed)
				CoolUtil.browserLoad('https://www.twitch.tv/danvoltz');
			}
		else if (curText == 3 && ((FlxG.mouse.screenX > fakehitbox2[0] && FlxG.mouse.screenX < fakehitbox2[2]) && (FlxG.mouse.screenY > fakehitbox2[1] && FlxG.mouse.screenY < fakehitbox2[3])))
			{
				text.loadGraphic(Paths.image('who/TextYT'));
				useUnderline = true;
				if (canInput && FlxG.mouse.justPressed)
					CoolUtil.browserLoad('https://www.youtube.com/channel/UC7dmhduVprBZypLJm46xiEg');
			}
		else if (curText == 3 && ((FlxG.mouse.screenX > fakehitbox3[0] && FlxG.mouse.screenX < fakehitbox3[2]) && (FlxG.mouse.screenY > fakehitbox3[1] && FlxG.mouse.screenY < fakehitbox3[3])))
			{
				text.loadGraphic(Paths.image('who/TextV'));
				useUnderline = true;
				if (canInput && FlxG.mouse.justPressed)
				CoolUtil.browserLoad('https://www.youtube.com/watch?v=85_YulxOSNk');
			}
		else if (curText == 3 && useUnderline)
			{
				text.loadGraphic(Paths.image('who/Text3'));
				useUnderline = false;
			}

		if (curText == 2 && ((FlxG.mouse.screenX > fakehitbox4[0] && FlxG.mouse.screenX < fakehitbox4[2]) && (FlxG.mouse.screenY > fakehitbox4[1] && FlxG.mouse.screenY < fakehitbox4[3])))
			{
				text.loadGraphic(Paths.image('who/Credits'));
				useUnderline2 = true;
				if (canInput && FlxG.mouse.justPressed)
					MusicBeatState.switchState(new CreditsVoltz());
			}
		else if (curText == 2 && useUnderline2)
			{
				text.loadGraphic(Paths.image('who/Text2'));
				useUnderline2 = false;
			}

		if(canInput && controls.BACK) {
			canInput = false;
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			exitanim();
		} else if(canInput && controls.ACCEPT) {
			canInput = false;
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			exitanim();
		}
		super.update(elapsed);
	}
	function exitanim()
		{
			mousedisable();
			
			ExtrasMenu.delayshit(0.44);
			FlxTween.tween(text, {y: FlxG.height}, 0.4, {
			ease: FlxEase.cubeIn,
			onComplete: function(twn:FlxTween)
				{
					close();
				}
			});
			FlxTween.tween(voltz, {y: FlxG.height}, 0.4, {
			ease: FlxEase.cubeIn
			});
			backwarddd = true;
		}
	function mousedisable()
		{
            // Mouse Cursor
            FlxG.mouse.enabled = false;
            FlxG.mouse.visible = false;
		}
	#if ACHIEVEMENTS_ALLOWED
	function basicAwardGrant(awardname:String) { 
			Achievements.loadAchievements();
			var achieveID:Int = Achievements.getAchievementIndex(awardname);
			if (achieveID != -1) {
				var redundant:String = Achievements.achievementsStuff[achieveID][2];
				if(!Achievements.isAchievementUnlocked(redundant)) { 
					Achievements.achievementsMap.set(redundant, true);
					add(new Achievements.AchievementObject(redundant));
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
}