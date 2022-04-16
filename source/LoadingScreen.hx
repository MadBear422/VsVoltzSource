package;

import lime.app.Promise;
import lime.app.Future;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.text.FlxText;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;

import haxe.io.Path;

class LoadingScreen extends MusicBeatState
{
    // opponent assets lol
    public static var opponent:String = "dad";

    var bgSpr:FlxSprite;
    var logoSpr:FlxSprite;
    var charSpr:FlxSprite;
    var boxSpr:FlxSprite;
    var skipSpr:FlxSprite;

    var descSpr:FlxSprite;

    override function create()
        {
            bgSpr = new FlxSprite(0, 0).loadGraphic(Paths.image('loadscreen/background/' + opponent));
            bgSpr.antialiasing = ClientPrefs.globalAntialiasing;
            bgSpr.screenCenter();

            add(bgSpr);

            boxSpr = new FlxSprite(731, 90).loadGraphic(Paths.image('loadscreen/box'));
            boxSpr.antialiasing = ClientPrefs.globalAntialiasing;
            //boxSpr.screenCenter();

            add(boxSpr);

            charSpr = new FlxSprite(0, 0).loadGraphic(Paths.image('loadscreen/characters/' + opponent));
            charSpr.antialiasing = ClientPrefs.globalAntialiasing;
            //charSpr.screenCenter();

            add(charSpr);

            descSpr = new FlxSprite(758, 298).loadGraphic(Paths.image('loadscreen/text/' + opponent));
            descSpr.antialiasing = ClientPrefs.globalAntialiasing;
            //charSpr.screenCenter();

            add(descSpr);

            logoSpr = new FlxSprite(0, 0).loadGraphic(Paths.image('loadscreen/logos/' + opponent));
            logoSpr.antialiasing = ClientPrefs.globalAntialiasing;
            logoSpr.screenCenter();

            add(logoSpr);

            skipSpr = new FlxSprite(1170, 629).loadGraphic(Paths.image('loadscreen/skip'));
            skipSpr.antialiasing = ClientPrefs.globalAntialiasing;
            skipSpr.alpha = 0;
            //charSpr.screenCenter();

            add(skipSpr);

            FlxG.sound.play(Paths.sound('continue'));
            slideOut();
            charReposition();
            logoReposition();
            new FlxTimer().start(3, function(tmr:FlxTimer)
                {
                    alphaPulse(skipSpr);
                });
        }

        function hideSpr(spr:FlxSprite)
            {
                FlxTween.cancelTweensOf(spr);
                FlxTween.tween(spr, {alpha: 0}, 0.3,
                    {
                        ease: FlxEase.quadInOut
                    });
            }

        function slideOut()
            {
                var pokeTop:FlxSprite = new FlxSprite();
                //pokeTop.screenCenter();
                //pokeTop.scrollFactor.set();
                pokeTop.loadGraphic(Paths.image('poke1'));
                FlxTween.tween(pokeTop, {y: pokeTop.y -700}, 1, {
                    ease: FlxEase.cubeIn,
                    onComplete: function(twn:FlxTween)
                        {
                            pokeTop.kill();
                        }
                    });
                //pokeTop.cameras = [camHUD];
                
    
                var pokeBottom:FlxSprite = new FlxSprite(0, 345);
                //pokeBottom.screenCenter();
                //pokeBottom.scrollFactor.set();
                pokeBottom.loadGraphic(Paths.image('poke2'));
                FlxTween.tween(pokeBottom, {y: pokeBottom.y + 700}, 1, {
                    ease: FlxEase.cubeIn,
                    onComplete: function(twn:FlxTween)
                        {
                            pokeBottom.kill();
                        }
                    });
                //pokeBottom.cameras = [camHUD];
    
                add(pokeBottom);
                add(pokeTop);
            }

        var movedBack:Bool = false;
        var hitEnter:Bool = false;

        override function update(elapsed:Float)
	    {
            if (controls.BACK && !movedBack && !hitEnter)
                {
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    FlxG.sound.music.fadeOut(0.5, 1);
                    movedBack = true;
                    hideSpr(skipSpr);
                    MusicBeatState.switchState(new StoryMenuState());
                }
            if (controls.ACCEPT && !movedBack && !hitEnter)
                {
                    FlxTransitionableState.skipNextTransIn = true;
                    hideSpr(skipSpr);
                    enterPlayState();
                }
            super.update(elapsed);
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
                                    var blackSquare:FlxSprite = new FlxSprite();
                                    blackSquare.makeGraphic(1300, 750, FlxColor.BLACK);
                                    blackSquare.screenCenter();
                                    blackSquare.alpha = 0;
                                    add(blackSquare);
                                    FlxTween.tween(blackSquare, {alpha: 1}, 0.2, {
                                        onComplete: function(twn:FlxTween)
                                            {
                                                MusicBeatState.switchState(new StoryVideo());
                                            }
                                        });
                                });
                        }
                    });
            }

        function charReposition()
		{
			switch (opponent)
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
                    descSpr.y += 50;
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
			}
        }

            function logoReposition()
		    {
                switch (opponent)
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
                }
		}
}