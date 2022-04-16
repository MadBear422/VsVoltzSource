package;

import cpp.zip.Flush;
import sys.FileSystem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

class GalleryState extends MusicBeatSubstate
{
    var sprOptions:FlxTypedGroup<FlxSprite>;
    var menuItems:FlxTypedGroup<FlxSprite>;

    var spike:FlxSprite;
    var galleryScreen:FlxSprite;

    var newShader:ColorSwap = new ColorSwap();
	var oldShader:ColorSwap = new ColorSwap();

    var optionShit:Array<String> = ['artwork', 'movies'];

    public static var curSelected:Int = 0;
    var canInput:Bool = true;
    var disableInputIndicator:Bool = true;

    override function create()
        {
            sprOptions = new FlxTypedGroup<FlxSprite>();
            menuItems = new FlxTypedGroup<FlxSprite>();

            for (i in 0...optionShit.length)
                {
                    var spr:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('gallery/' + optionShit[i]));
                    spr.ID = i;
                    spr.x += (Std.int(spr.width * i));
                    sprOptions.add(spr);
                }
            add(sprOptions);

            for (i in 0...optionShit.length)
                {
                    var subject:FlxSprite = new FlxSprite(0, 0);
                    subject.frames = Paths.getSparrowAtlas('extrasMenu/ANIM_TEXT');
                    subject.animation.addByPrefix('idle', optionShit[i] + "_idle", 24, true);
                    subject.animation.addByPrefix('selected', optionShit[i] + "_hover", 24, true);
                    subject.ID = i;
                    subject.scale.x = 0.75;
                    subject.scale.y = 0.75;
                    subject.animation.play('idle');
                    subject.updateHitbox();
                    if (i == 0)
                        {
                            subject.x = 75;
                            subject.y = 50;
                        }
                    else if (i == 1)
                        {
                            subject.x = 820;
                            subject.y = 50;
                        }
                    subject.antialiasing = ClientPrefs.globalAntialiasing;
                    menuItems.add(subject);
                }
            add(menuItems);

            newShader.saturation = -1;
            newShader.brightness = -0.5;
            oldShader.saturation = 0;
            oldShader.brightness = 0;

            spike = new FlxSprite(540, 0).loadGraphic(Paths.image('gallery/mygoodness'));
            spike.antialiasing = ClientPrefs.globalAntialiasing;
            add(spike);

            if (FlxG.save.data.galleryMessage != true)
                {
                    canInput = false;
                }
            else
                canInput = true;

            if (FlxG.save.data.galleryMessage != true)
                {
                    canInput = false;
                    galleryScreen = new FlxSprite(0, 300).loadGraphic(Paths.image('unlockIndicators/galleries'));
                    galleryScreen.antialiasing = ClientPrefs.globalAntialiasing;
                    galleryScreen.alpha = 0;
                    add(galleryScreen);
    
                    new FlxTimer().start(1, function(tmr:FlxTimer) { bringIndicator(); } );
    
                }
            super.create();
            calculateShader();
            changeItem();
        }

        override function update(elapsed:Float)
            {   
                if (!disableInputIndicator)
                    {
                        if (controls.ACCEPT || controls.BACK)
                            {
                                disableInputIndicator = true;
                                FlxG.camera.flash(FlxColor.WHITE, 0.3);
                                FlxG.sound.play(Paths.sound('confirmMenu'));
                                exitIndicator();
                                FlxG.save.data.galleryMessage = true;
                            }
                    }
                if (controls.UI_LEFT_P && canInput)
                    {
                        FlxG.sound.play(Paths.sound('scrollMenu'));
                        changeItem(-1);
                    }
                
                if (controls.UI_RIGHT_P && canInput)
                    {
                        FlxG.sound.play(Paths.sound('scrollMenu'));
                        changeItem(1);
                    }

                if (controls.ACCEPT && canInput)
                    {
                        FlxG.camera.flash(FlxColor.WHITE, 0.3);
                        canInput = false;
                        FlxG.sound.play(Paths.sound('confirmMenu'));
                        // THIS IS FOR YOU MOON FOR THE SWITCH STATES
                        // okay lmao
                        menuItems.forEach(function(spr:FlxSprite)
                            {
                                if (spr.ID == curSelected)
                                    {
                                        FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                                            {
                                                FlxG.camera.fade(FlxColor.BLACK, 0.2, false, function()
                                                    {
                                                        switch (optionShit[curSelected])
                                                        {
                                                            case 'artwork':
                                                                FlxG.sound.playMusic(Paths.music('artgallery'));
                                                                MusicBeatState.switchState(new ArtworkState());
                                                                
                                                            case 'movies':
                                                                FlxG.sound.playMusic(Paths.music('moviesgallery'));
                                                                MusicBeatState.switchState(new MoviesState());
            
                                                        }
                                                    });
                                            });
                                        
                                    }
                            });
                    }
                if (controls.BACK && canInput)
                    {
                        canInput = false;
                        FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			            exitanim();
                    }
                super.update(elapsed);
            }

            function bringIndicator()
                {
                    FlxG.sound.play(Paths.sound('Checkpoint'));
                    FlxTween.tween(galleryScreen, {alpha: 1, y: 0}, 0.4, {
                        ease: FlxEase.cubeOut,
                        onComplete: function(twn:FlxTween)
                            {
                                disableInputIndicator = false;
                            }
                    });
                }

            function exitIndicator()
                {
                    FlxTween.tween(galleryScreen, {alpha: 0, y: 300}, 0.4, {
                        ease: FlxEase.cubeIn,
                        onComplete: function(twn:FlxTween)
                            {
                                canInput = true;
                                galleryScreen.kill();
                            }
                    });
                }

            function exitanim()
                {
                    ExtrasMenu.delayshit(0.44);
                    menuItems.forEach(function(spr:FlxSprite)
                        {
                            FlxTween.tween(spr, {y: spr.y - 200}, 0.2, {
                            ease: FlxEase.cubeIn
                            });
                        });
                    sprOptions.forEach(function(spr:FlxSprite)
                        {
                            FlxTween.tween(spr, {alpha: 0}, 0.4, {
                            ease: FlxEase.cubeIn
                            });
                        });
                    FlxTween.tween(spike, {alpha: 0}, 0.4, {
                            ease: FlxEase.cubeIn
                            });
                    new FlxTimer().start(0.4, function(tmr:FlxTimer)
			        {
                        close();
			        });
                    
                }
        
        function changeItem(increment:Int = 0)
            {
                curSelected += increment;
                if (curSelected >= optionShit.length)
                    {
                        curSelected = 0;
                    }
                else if (curSelected < 0)
                    {
                        curSelected = optionShit.length - 1;
                    }
                changeAnim();
                calculateShader();
            }

        function changeAnim()
            {
                for (spr in menuItems)
                    {
                        if (curSelected == spr.ID)
                            {
                                spr.animation.play('selected');
                                spr.centerOrigin();
                                spr.centerOffsets();
                            }
                        else
                            {
                                spr.animation.play('idle');
                                spr.centerOrigin();
                                spr.centerOffsets();
                            }
                    }
            }

        function calculateShader()
            {
                for (spr in sprOptions)
                    {
                        if (curSelected == spr.ID)
                            {
                                spr.shader = oldShader.shader;
                            }
                        else
                            {
                                spr.shader = newShader.shader;
                            }
                    }
            }

}