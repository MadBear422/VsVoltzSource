package;

import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.graphics.FlxGraphic;
import flixel.addons.display.FlxTiledSprite;
import flixel.group.FlxSpriteGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import flixel.FlxSprite;
#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxCamera;
#if desktop
import Discord.DiscordClient;
#end
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import openfl.display.BlendMode;
import flixel.FlxG;
import Shaders;
using StringTools;

class ArtworkState extends MusicBeatState {
    public static var camHUD:FlxCamera;
    public static var camGame:FlxCamera;
    public static var camFullscreen:FlxCamera;
    public static var camFollow:FlxObject;

    var sprLeft:FlxSprite;
    var sprRight:FlxSprite;

    var menubg:FlxSprite;
    var menuOverlay:FlxSprite;
    var title:FlxSprite;
    var splat:FlxSprite;
    var exLine:FlxSprite;
    var exGlow:FlxSprite;
    var exText:FlxSprite;
    var border:FlxSprite;
    var glow:FlxSprite;

    var skidGroup:FlxSpriteGroup;

    var bgCheckers:FlxSprite;
    var curImage:FlxSprite;
    var scrollCheckers:FlxBackdrop;

    public var camHUDShaders:Array<ShaderEffect> = [];

    var menuDirectory:String = 'gallery/artwork/';
    var artDirectory:String = 'gallery/artwork/gallery_subs/';
    var artSuffix:String = '';

    var author:String = 'sussy chungus';
    
    var artistName:FlxText;

    public static var disableInput:Bool = true;
    public static var beginOpacityFade:Bool = false;

    var mouseUse:Bool = false;

    public static var curSelected:Int = 1;

    override function create()
    {
        // MEMORY BITCH
        Paths.clearStoredMemory();
        Paths.clearUnusedMemory();

        camGame = new FlxCamera();
        camHUD = new FlxCamera();
        camFullscreen = new FlxCamera();
        FlxG.cameras.reset(camGame);
        FlxG.cameras.add(camHUD);
        FlxG.cameras.add(camFullscreen);
        FlxCamera.defaultCameras = [camGame];
        camGame.bgColor.alpha = 0;
        camHUD.bgColor.alpha = 0;
        camFullscreen.bgColor.alpha = 0;

        camFollow = new FlxObject(0, 0, 2, 2);
        camFollow.screenCenter();
        add(camFollow);

        camGame.follow(camFollow);

        camHUDShaders.push(new ShaderFilter(new VCRDistortionShader()));
        camHUDShaders.push(new ShaderFilter(new ChromaticAberrationShader()));
        var newCamEffects:Array<BitmapFilter>=[];
				for(i in camHUDShaders){
				  newCamEffects.push(new ShaderFilter(i.shader));
				}

        camGame.setFilters(newCamEffects);

        persistentUpdate = persistentDraw = true;

        artistName = new FlxText(0, 0, 0, author, 36);
		artistName.setFormat(Paths.font("microgramma.otf"), 40, FlxColor.WHITE, LEFT);
        artistName.scrollFactor.set();
        //artistName.centerOrigin();

        bgCheckers = new FlxSprite().loadGraphic(Paths.image('gallery/movies/checkers'));
        scrollCheckers = new FlxBackdrop(bgCheckers.graphic, 60, 45, true, true);
        scrollCheckers.velocity.set(-30, 20);
        scrollCheckers.scrollFactor.set();

        FlxTransitionableState.skipNextTransIn = true;

        FlxG.mouse.visible = true;
		FlxG.mouse.enabled = true;
        FlxG.mouse.useSystemCursor = true;

        skidGroup = new FlxSpriteGroup();

        menubg = new FlxSprite().loadGraphic(Paths.image(menuDirectory + 'bg'));
        menubg.antialiasing = ClientPrefs.globalAntialiasing;
        menubg.scrollFactor.set();

        menuOverlay = new FlxSprite().loadGraphic(Paths.image(menuDirectory + 'fade'));
        menuOverlay.antialiasing = ClientPrefs.globalAntialiasing;
        menuOverlay.scrollFactor.set();

        title = new FlxSprite(376, 40).loadGraphic(Paths.image(menuDirectory + 'title'));
        title.antialiasing = ClientPrefs.globalAntialiasing;
        title.scrollFactor.set();

        splat = new FlxSprite(-32.7, -49.3).loadGraphic(Paths.image(menuDirectory + 'splat'));
        splat.antialiasing = ClientPrefs.globalAntialiasing;
        splat.scrollFactor.set();

        changeImagePath();

        curImage = new FlxSprite(708.7, 211.6).loadGraphic(Paths.image(artDirectory + artSuffix));
        curImage.antialiasing = ClientPrefs.globalAntialiasing;
        curImage.scale.set(0.38, 0.38);
        curImage.updateHitbox();
        curImage.scrollFactor.set();

        sprLeft = new FlxSprite(682.6, 211.6).loadGraphic(Paths.image(menuDirectory + 'next'));
        sprLeft.flipX = true;
        sprLeft.antialiasing = ClientPrefs.globalAntialiasing;
        sprLeft.scrollFactor.set();

        sprRight = new FlxSprite(1206.8, 211.6).loadGraphic(Paths.image(menuDirectory + 'next'));
        sprRight.antialiasing = ClientPrefs.globalAntialiasing;
        sprRight.scrollFactor.set();

        border = new FlxSprite(706, 209).loadGraphic(Paths.image(menuDirectory + 'border'));
        border.antialiasing = ClientPrefs.globalAntialiasing;
        border.scrollFactor.set();

        artistName.x = border.x;
        artistName.y = border.y - 50;

        exLine = new FlxSprite(887, 575).loadGraphic(Paths.image(menuDirectory + 'expand_line'));
        exLine.antialiasing = ClientPrefs.globalAntialiasing;
        exLine.scrollFactor.set();

        exGlow = new FlxSprite(890, 502).loadGraphic(Paths.image(menuDirectory + 'expand_glow'));
        exGlow.antialiasing = ClientPrefs.globalAntialiasing;
        exGlow.scrollFactor.set();
        
        exText = new FlxSprite(902.8, 514).loadGraphic(Paths.image(menuDirectory + 'expand_dong'));
        exText.antialiasing = ClientPrefs.globalAntialiasing;
        exText.scrollFactor.set();

        glow = new FlxSprite(655, 160).loadGraphic(Paths.image(menuDirectory + 'glow'));
        glow.antialiasing = ClientPrefs.globalAntialiasing;
        glow.scrollFactor.set();

        var skidpurpOne = new FlxSprite(-324.5, 95.3).loadGraphic(Paths.image(menuDirectory + "skidmark"));
        skidpurpOne.antialiasing = ClientPrefs.globalAntialiasing;
        skidpurpOne.alpha = 0;
        skidGroup.add(skidpurpOne);

        var skidpurpTwo = new FlxSprite(-314.5, 90.3).loadGraphic(Paths.image(menuDirectory + "skidmark"));
        skidpurpTwo.antialiasing = ClientPrefs.globalAntialiasing;
        skidGroup.add(skidpurpTwo);
        skidpurpTwo.alpha = 0;

        var skid = new FlxSprite(-301.1, 80.3).loadGraphic(Paths.image(menuDirectory + "skid"));
        skid.antialiasing = ClientPrefs.globalAntialiasing;
        skidGroup.add(skid);
        skid.alpha = 0;

        skidGroup.scrollFactor.set();

        add(menubg);
        add(menuOverlay);
        add(scrollCheckers);
        add(skidGroup);
        add(title);
        add(glow);
        add(exGlow);
        add(exText);
        add(curImage);
        add(border);
        add(artistName);
        add(sprLeft);
        add(sprRight);
        add(splat);

        new FlxTimer().start(0.5, function(tmr:FlxTimer)
            {
                bringInSkid();
            });


        super.create();
        pulse(menuOverlay, 0.5, 2.5);
        //charRotation();
        pulse(glow);
        pulse(exGlow);
        updateLockImage();
    }

    override function update(elapsed:Float) {
        if (!disableInput)
            checkForInput();
        if (beginOpacityFade)
            {
                changeItem();
                opacityFade();
                beginOpacityFade = false;
            }
        super.update(elapsed);
    }

    function goInMenu()
        {
            disableInput = true;
            camFollow.y = 359 + (100 * ((curSelected - (curSelected%5))/5));
            //trace(camFollow.y);
            FlxG.sound.play(Paths.sound('expand'));
            camHUD.fade(FlxColor.WHITE, 0.15, false, function()
                {
                    openSubState(new ArtworkSubState());
                    spritesVisibility(0);
                    new FlxTimer().start(0.1, function(tmr:FlxTimer)
                        {
                            camHUD.fade(FlxColor.WHITE, 0.15, true, function(){}, true);
                        });
                });
        }
    function checkForInput()
        {
            if (controls.BACK)
                {
                    FlxG.sound.playMusic(Paths.music('freakyMenu'));
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    disableInput = true;
                    FlxG.mouse.visible = false;
                    FlxG.mouse.enabled = false;
                    ExtrasMenu.returnFromGallery = true;
                    FlxG.camera.fade(FlxColor.WHITE, 0.4, false, function()
                        {
                            MusicBeatState.switchState(new ExtrasMenu());
                        });
                }

            if (controls.ACCEPT)
                {
                    goInMenu();
                }

            if (controls.UI_RIGHT_P)
                {
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    sprRight.loadGraphic(Paths.image(menuDirectory + 'nexthit'));
                    changeItem(1);
                }
            else if (!controls.UI_RIGHT)
                {
                    sprRight.loadGraphic(Paths.image(menuDirectory + 'next'));
                }

            if (controls.UI_LEFT_P)
                {
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    sprLeft.loadGraphic(Paths.image(menuDirectory + 'nexthit'));
                    changeItem(-1);
                }
            else if (!controls.UI_LEFT)
                {
                    sprLeft.loadGraphic(Paths.image(menuDirectory + 'next'));
                }
                
                if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(exText))
                    {
                        goInMenu();
                    }
                if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(curImage))
                    {
                        goInMenu();
                    }

                    if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(sprRight))
                        {
                            changeItem(1);
                            FlxG.sound.play(Paths.sound('scrollMenu'));
                        }
                    else if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(sprLeft))
                        {
                            changeItem(-1);
                            FlxG.sound.play(Paths.sound('scrollMenu'));
                        }

                if (FlxG.mouse.pressed && FlxG.mouse.overlaps(sprRight))
                    {
                        sprRight.loadGraphic(Paths.image(menuDirectory + 'nexthit'));
                    }
                else if (!FlxG.mouse.pressed && FlxG.mouse.overlaps(sprRight))
                    {
                        sprRight.loadGraphic(Paths.image(menuDirectory + 'next'));
                    }
                if (FlxG.mouse.pressed && FlxG.mouse.overlaps(sprLeft))
                    {
                        sprLeft.loadGraphic(Paths.image(menuDirectory + 'nexthit'));
                    }
                else if (!FlxG.mouse.pressed && FlxG.mouse.overlaps(sprLeft))
                    {
                        sprLeft.loadGraphic(Paths.image(menuDirectory + 'next'));
                    }
        }

    function spritesVisibility(alph:Int = 1)
        {
            //add(skidGroup);
            skidGroup.alpha = alph;

            //add(title);
            title.alpha = alph;

            //add(glow);
            FlxTween.cancelTweensOf(glow);
            glow.alpha = alph;

            //add(exGlow);
            FlxTween.cancelTweensOf(exGlow);
            exGlow.alpha = alph;

            //add(exText);
            exText.alpha = alph;

            //add(curImage);
            curImage.alpha = alph;

            //add(border);
            border.alpha = alph;

            //add(sprLeft);
            sprLeft.alpha = alph;
            
            //add(sprRight);
            sprRight.alpha = alph;

            artistName.alpha = alph;
        }

        function updateLockImage()
            {
                switch (curSelected)
                {
                    case 2:
                        if (!Achievements.isAchievementUnlocked('checkpoint_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 5:
                        if (!Achievements.isAchievementUnlocked('rolecall_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 10:
                        if (!Achievements.isAchievementUnlocked('homestretch_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 21:
                        if (!Achievements.isAchievementUnlocked('lightswing_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 22:
                        if (!Achievements.isAchievementUnlocked('tangroove_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 23:
                        if (!Achievements.isAchievementUnlocked('checkpoint_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 24:
                        if (!Achievements.isAchievementUnlocked('meowmix_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 25:
                        if (!Achievements.isAchievementUnlocked('week1-v_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 26:
                        if (!Achievements.isAchievementUnlocked('week2-v_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 27:
                        if (!Achievements.isAchievementUnlocked('week3-v_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 28:
                        if (!Achievements.isAchievementUnlocked('week4-v_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 29:
                        if (!Achievements.isAchievementUnlocked('week5-v_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 30:
                        if (!Achievements.isAchievementUnlocked('week6-v_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 31:
                        if (!Achievements.isAchievementUnlocked('heavyswing_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 32:
                        if (!Achievements.isAchievementUnlocked('fizz_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 33:
                        if (!Achievements.isAchievementUnlocked('homestretch_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 34:
                        if (!Achievements.isAchievementUnlocked('twomah_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 35:
                        if (!Achievements.isAchievementUnlocked('lmhy_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 36:
                        if (!Achievements.isAchievementUnlocked('slightswing_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                    case 37:
                        if (!Achievements.isAchievementUnlocked('rolecall_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                }
            }

        public static function delayshit(thedoksfokfdsajnuandjiasndiads:Float)
            {
                beginOpacityFade = true;
                new FlxTimer().start(thedoksfokfdsajnuandjiasndiads, function(tmr:FlxTimer)
                    {
                        disableInput = false;
                    });
            }
    function opacityFade()
        {
            FlxTween.tween(skidGroup, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
            FlxTween.tween(artistName, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
            FlxTween.tween(title, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
            FlxTween.tween(glow, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn,
                onComplete: function(twn:FlxTween)
                    {
                        pulse(glow);
                    }
            });
            FlxTween.tween(exGlow, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn,
                onComplete: function(twn:FlxTween)
                    {
                        pulse(exGlow);
                    }
            });
            FlxTween.tween(exText, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
            FlxTween.tween(curImage, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
            FlxTween.tween(border, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
            FlxTween.tween(sprLeft, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
            FlxTween.tween(sprRight, {alpha: 1}, 0.2, {
                ease: FlxEase.cubeIn
            });
        }

    function changeImagePath(reloadImage:Bool = false, ?spr:FlxSprite = null)
        {
            var foldersToCheck:Array<String> = [Paths.getPreloadPath('images/gallery/artwork/gallery_subs/')];

            for (folder in foldersToCheck)
                {
                    if (FileSystem.exists(folder))
                        {
                            for (file in FileSystem.readDirectory(folder))
                                {
                                    //trace(file);
                                    if(file.startsWith(curSelected + '_'))
                                    {
                                        artSuffix = file.replace('.png', '');
                                        author = artSuffix.replace(curSelected + '_', '');
                                        artistName.text = author.toUpperCase();
                                        //artSuffix = artSuffix.replace('.png', '');
                                        trace(artSuffix);
                                    }
                                }
                        }
                }

            if (reloadImage)
                {
                    spr.loadGraphic(Paths.image(artDirectory + artSuffix));
                    spr.scale.set(0.38226562, 0.38226562);
                    spr.updateHitbox();
                }
        }

    function changeItem(sel:Int = 0)
        {
            curSelected += sel;

            if (curSelected < 1)
                curSelected = 50;
            if (curSelected > 50)
                curSelected = 1;

            changeImagePath(true, curImage);
            updateLockImage();
            ArtworkSubState.curSelected = curSelected;
        }

    function bringInSkid()
        {
                    FlxTween.tween(skidGroup.members[0], {x: -4.7, alpha: 0.4}, 1.05, {
                        ease: FlxEase.cubeOut,
                        onComplete: function(twn:FlxTween)
                            {
                                disableInput = false;
                            }
                    });

                    FlxTween.tween(skidGroup.members[1], {x: 5.3, alpha: 1}, 0.9, {
                        ease: FlxEase.cubeOut
                    });
                    FlxTween.tween(skidGroup.members[2], {x: 18.7, alpha: 1}, 0.74, {
                        ease: FlxEase.cubeOut
                    });
        }

    function charRotation() {
        for (i in 0...skidGroup.length) {
		    FlxTween.angle(skidGroup.members[i], 4, -4, 5, {
		    	ease: FlxEase.sineInOut,
	    		type: FlxTweenType.PINGPONG
		    });
        }
	}	

    function pulse(spr:FlxSprite, alph:Float = 0.5, dur:Float = 1)
        {
            FlxTween.tween(spr, {alpha: alph}, dur,
                {
                ease: FlxEase.quadInOut,
                type: FlxTweenType.PINGPONG
                });
        }

    
}