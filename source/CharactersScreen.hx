package;

import lime.app.Promise;
import lime.app.Future;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.text.FlxText;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;

import haxe.io.Path;

class CharactersScreen extends MusicBeatState
{
    // character assets lol
    var charList:Array<String> = [
        'bf',
		'gf',
        'voltz',
        'cat',
		'dad',
		'spookeez',
        'monster',
		'pico',
		'mom',
		'parents',
		'senpai',
        'soon'
	];

    private static var curSelected:Int = 0;

    var disableInput:Bool = true;

    var monsterImage:FlxSprite;
    var monsterTimeout:Bool = false;
    var monsterRandom:Int;
    var monsterGlitchSound:FlxSound;

    var logoSpr:FlxSprite;
    var charSpr:FlxSprite;
    var boxSpr:FlxSprite;
    //var skipSpr:FlxSprite;

    var bgSpr:FlxTypedGroup<FlxSprite>;

    var descSpr:FlxSprite;

    override function create()
        {
            FlxTransitionableState.skipNextTransIn = true;
            FlxTransitionableState.skipNextTransOut = true;
            //FlxG.sound.music.fadeOut(0.25, 1);
            monsterGlitchSound = new FlxSound().loadEmbedded(Paths.sound('glitched'), true);
            FlxG.sound.playMusic(Paths.music('characterMenu'), 0.7);

            bgSpr = new FlxTypedGroup<FlxSprite>();

            for (i in 0...charList.length)
                {
                    var spr:FlxSprite = new FlxSprite(0, 0);
                    spr.loadGraphic(Paths.image('loadscreen/background/' + charList[i]));
                    spr.ID = i;
                    if (spr.ID != curSelected)
                        {
                            spr.alpha = 0;
                        }
                    spr.antialiasing = ClientPrefs.globalAntialiasing;
                    spr.screenCenter();
                    bgSpr.add(spr);
                }
            add(bgSpr);

            boxSpr = new FlxSprite(731, 90).loadGraphic(Paths.image('loadscreen/box'));
            boxSpr.antialiasing = ClientPrefs.globalAntialiasing;
            //boxSpr.screenCenter();

            add(boxSpr);

            charSpr = new FlxSprite(0, 0).loadGraphic(Paths.image('loadscreen/characters/' + charList[curSelected]));
            charSpr.antialiasing = ClientPrefs.globalAntialiasing;
            //charSpr.screenCenter();

            add(charSpr);

            descSpr = new FlxSprite(758, 298).loadGraphic(Paths.image('loadscreen/text/' + charList[curSelected]));
            descSpr.antialiasing = ClientPrefs.globalAntialiasing;
            //charSpr.screenCenter();
            descSpr.alpha = 0;

            add(descSpr);

            logoSpr = new FlxSprite(0, 0).loadGraphic(Paths.image('loadscreen/logos/' + charList[curSelected]));
            logoSpr.antialiasing = ClientPrefs.globalAntialiasing;
            logoSpr.screenCenter();

            add(logoSpr);

            monsterImage = new FlxSprite(0, 0).loadGraphic(Paths.image('loadscreen/monsterScare_1'));
            monsterImage.antialiasing = ClientPrefs.globalAntialiasing;
            monsterImage.screenCenter();
            monsterImage.visible = false;

            add(monsterImage);

            // skipSpr = new FlxSprite(1170, 629).loadGraphic(Paths.image('loadscreen/skip'));
            // skipSpr.antialiasing = ClientPrefs.globalAntialiasing;
            // skipSpr.alpha = 0;
            // charSpr.screenCenter();

            // add(skipSpr);

            //FlxG.sound.play(Paths.sound('continue'));
            charReposition();
            logoReposition();

            charSpr.y += 900;
            FlxTween.tween(charSpr, {y: charSpr.y - 900}, 0.95, {
                ease: FlxEase.cubeOut
                });

            logoSpr.y -= 400;
            FlxTween.tween(logoSpr, {y: logoSpr.y + 400}, 0.95, {
                ease: FlxEase.cubeOut
            });
            
            boxSpr.y += 900;
            FlxTween.tween(boxSpr, {y: boxSpr.y - 900}, 0.95, {
                ease: FlxEase.cubeOut,
                onComplete: function(twn:FlxTween)
                    {
                        FlxTween.tween(descSpr, {alpha: 1}, 0.15, {
                            ease: FlxEase.cubeOut,
                            onComplete: function(twn:FlxTween)
                                {
                                    disableInput = false;
                                }
                        });
                    }
            });
            
            for (spr in bgSpr) {
                spr.y += 900;
                FlxTween.tween(spr, {y: spr.y - 900}, 0.9, {
                    ease: FlxEase.cubeOut
                });
            }
            // new FlxTimer().start(3, function(tmr:FlxTimer)
            //     {
            //         alphaPulse(skipSpr);
            //     });
            super.create();
        }

        function cycleChar(spr:FlxSprite)
            {
                spr.x -= 100;
			    spr.alpha = 0;
                FlxTween.tween(spr, {x: spr.x + 100, alpha: 1}, 0.2, {
                    ease: FlxEase.cubeOut,
                    onComplete: function(twn:FlxTween)
                        {
                            disableInput = false;
                        }
                    });
                bgTransition();
            }

        function hideSpr(spr:FlxSprite)
            {
                FlxTween.cancelTweensOf(spr);
                FlxTween.tween(spr, {alpha: 0}, 0.3,
                    {
                        ease: FlxEase.quadInOut
                    });
            }

        var movedBack:Bool = false;
        var hitEnter:Bool = false;

        override function update(elapsed:Float)
	    {
            if (controls.BACK && !movedBack && !hitEnter)
                {
                    monsterGlitchSound.destroy();
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    movedBack = true;
                    //hideSpr(skipSpr);
                    FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);
                    var blackSquare:FlxSprite = new FlxSprite();
                        blackSquare.makeGraphic(1300, 750, 0xFF9C47FF);
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
            if (controls.UI_RIGHT_P && !disableInput)
                {
                    disableInput = true;
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    changeCharacter(1);
                    cycleChar(charSpr);
                }
            if (controls.UI_LEFT_P && !disableInput)
                {
                    disableInput = true;
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    changeCharacter(-1);
                    cycleChar(charSpr);
                }
            /*if (controls.ACCEPT && !movedBack && !hitEnter)
                {
                    hideSpr(skipSpr);
                    enterPlayState();
                }*/
            
            if (charList[curSelected] == 'monster')
                {
                    FlxG.sound.music.fadeOut(0.1);
                    monsterGlitchSound.play();
                    if (!monsterTimeout && ClientPrefs.flashing)
                        {
                            if (!disableInput)
                                {
                                    monsterTimeout = true;
                                    monsterRandom = FlxG.random.int(1, 3);
                                    monsterImage.loadGraphic(Paths.image('loadscreen/monsterScare_' + monsterRandom));
                                    monsterImage.visible = true;
                                    FlxG.sound.play(Paths.sound('monster'));
                                    new FlxTimer().start(0.3, function(tmr:FlxTimer)
                                        {
                                            monsterImage.visible = false;
                                            new FlxTimer().start(FlxG.random.float(0.3, 3), function(tmr:FlxTimer)
                                                {
                                                    monsterTimeout = false;
                                                });
                                        });
                                }
                        }
                }
            else
                {
                    FlxG.sound.music.fadeOut(0.1, 0.7);
                    monsterGlitchSound.pause();
                }
                
            super.update(elapsed);
        }

        function changeCharacter(change:Int = 0)
            {
                curSelected += change;

                if (curSelected >= charList.length)
                    curSelected = 0;
                else if (curSelected < 0)
                    curSelected = charList.length - 1;
                
                reloadCharImage();
                charReposition();
                logoReposition();
            }

            function bgTransition()
                {
                    for (spr in bgSpr) {
                        FlxTween.cancelTweensOf(spr);
                        if (spr.ID == curSelected) {
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

        function reloadCharImage()
            {
                charSpr.loadGraphic(Paths.image('loadscreen/characters/' + charList[curSelected]));
                descSpr.loadGraphic(Paths.image('loadscreen/text/' + charList[curSelected]));
                logoSpr.loadGraphic(Paths.image('loadscreen/logos/' + charList[curSelected]));
            }

        function alphaPulse(spr:FlxSprite)
            {
                FlxTween.tween(spr, {alpha: 1}, 1,
                    {
                    ease: FlxEase.quadInOut,
                    onComplete: function(twn:FlxTween)
                        {
                            FlxTween.tween(spr, {alpha: 0.4}, 1,
                                {
                                ease: FlxEase.quadInOut,
                                type: FlxTweenType.PINGPONG
                                });
                        }
                    });
            }

        function enterPlayState()
            {
                hitEnter = true;
                var whiteSquare:FlxSprite = new FlxSprite();
                whiteSquare.makeGraphic(1300, 750, FlxColor.WHITE);
                whiteSquare.screenCenter();
                whiteSquare.alpha = 0;
                add(whiteSquare);
                FlxG.sound.play(Paths.sound('enterload'));
                FlxTween.tween(whiteSquare, {alpha: 1}, 0.5, {
                    onComplete: function(twn:FlxTween)
                        {
                            new FlxTimer().start(1.5, function(tmr:FlxTimer)
                                {
                                    MusicBeatState.switchState(new StoryVideo());
                                });
                        }
                    });
            }

        function charReposition()
		{
			switch (charList[curSelected])
			{
				case 'gf':
					charSpr.x = 106;
					charSpr.y = 4;
				case 'cat':
					charSpr.x = 53;
					charSpr.y = 86;
				case 'dad':
					charSpr.x = 35;
					charSpr.y = 36;
				case 'spookeez':
					charSpr.x = 56;
					charSpr.y = 17;
                case 'monster':
                    charSpr.x = 0;
                    charSpr.y = 0;
				case 'pico':
					charSpr.x = 0;
					charSpr.y = 85;
				case 'mom':
					charSpr.x = 20;
					charSpr.y = 26;
				case 'parents':
					charSpr.x = 28;
					charSpr.y = 21;
				case 'senpai':
					charSpr.x = 32;
					charSpr.y = 30;
				case 'voltz':
					charSpr.x = 56;
					charSpr.y = 3;
				case 'bf':
					charSpr.x = 82;
					charSpr.y = 61;
                case 'soon':
                    charSpr.x = 82;
                    charSpr.y = 0;
			}
        }

            function logoReposition()
		    {
                switch (charList[curSelected])
                {
                    case 'gf':
                        logoSpr.x = 693;
                        logoSpr.y = 22;
                    case 'cat':
                        logoSpr.x = 746;
                        logoSpr.y = 3;
                    case 'dad':
                        logoSpr.x = 717;
                        logoSpr.y = 1;
                    case 'spookeez':
                        logoSpr.x = 755;
                        logoSpr.y = 8;
                    case 'monster':
                        logoSpr.x = 692;
                        logoSpr.y = 42;
                    case 'pico':
                        logoSpr.x = 675;
                        logoSpr.y = 48;
                    case 'mom':
                        logoSpr.x = 705;
                        logoSpr.y = -10;
                    case 'parents':
                        logoSpr.x = 664;
                        logoSpr.y = 10;
                    case 'senpai':
                        logoSpr.x = 682;
                        logoSpr.y = 24;
                    case 'voltz':
                        logoSpr.x = 787;
                        logoSpr.y = 31;
                    case 'bf':
                        logoSpr.x = 689;
                        logoSpr.y = 4;
                    case 'soon':
                        logoSpr.x = 749;
                        logoSpr.y = 22;
                }
                if (charList[curSelected] == 'spookeez')
                    descSpr.y += 50;
                else if (charList[curSelected] == 'soon')
                    descSpr.y += 50;
                else
                    descSpr.y = 298;
		}
}