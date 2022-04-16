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
import flixel.FlxCamera;
#if sys
import sys.io.File;
import sys.FileSystem;
#end
#if desktop
import Discord.DiscordClient;
#end
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import openfl.display.BlendMode;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxObject;
import Shaders;
using StringTools;

class ArtworkSubState extends MusicBeatSubstate
{
    var artworkGroup:FlxSpriteGroup;

    var borderGroup:FlxSpriteGroup;

    var curImage:FlxSprite;
    var borderGlow:FlxSprite;

    var artSuffixFull:String = '';

    var artSuffix:String = '';
    var disableInput:Bool = false;
    var fullscreenState:Bool = false;

    var author:String = 'sussy chungus';
    var artistName:FlxText;
    //

    public static var curSelected:Int = 1;

    var menuDirectory:String = 'gallery/artwork/';
    var artDirectory:String = 'gallery/artwork/gallery_subs/';

    /*private var creditMap:Map<Int, String> = [
        0 =>
    ];*/

    public static var creditLink:Map<String, String> = [
        'moxxie' => 'https://twitter.com/Roaming_Pikachu',
        'racckoon' => 'https://twitter.com/GirlWaluigi',
        'riveroaken' => 'https://twitter.com/RiverOaken',
        'sunkydunky' => 'https://twitter.com/RealSunkyDunky',
        'cherrylove' => 'https://twitter.com/KazooSheep_',
        'joeyanimations' => 'https://twitter.com/joey_animations',
        'springy' => 'https://twitter.com/Springy_4264',
        'rue' => 'https://twitter.com/LuckiiBean',
        'g-nux' => 'https://www.youtube.com/channel/UCekuN8pNWtqxAeDIR-CMM9A',
        'cookie' => 'https://twitter.com/CookieRSF',
        'wither' => 'https://twitter.com/DatWither',
        'flan' => 'https://twitter.com/F14nTh3M4n',
        'leomming' => 'https://twitter.com/Leomming',
        'sajiarts' => 'https://twitter.com/sajiarts',
        'offbi' => 'https://twitter.com/Officiallythat2',
        'megafreedom' => 'https://twitter.com/MegaFreedom1274',
        'ellis' => 'https://twitter.com/EllisBros',
        'boidhouse' => 'https://twitter.com/boidhouse',
        'squib' => 'https://twitter.com/FUNGUS_FACTORY',
        'crae' => 'https://twitter.com/Crae_YT',
        'grassjeak' => 'https://twitter.com/grass__jeak',
        'kafei_yuki' => 'https://twitter.com/kafei_yuki',
        'von' => 'https://twitter.com/VonSketchz',
        'renx' => 'https://twitter.com/RenxTheHedgehog',
        'kaoskurve' => 'https://twitter.com/KaoskurveA',
        'curse' => 'https://twitter.com/TGEMPRESS_Curse',
        'galosaur' => 'https://twitter.com/Galosaur',
        'kalpy' => 'https://twitter.com/Kalpy19',
        'azeria' => 'https://twitter.com/Azeriaa2'
    ];

    override function create()
        {
            //shader data
            /*newShader.saturation = -1;
            newShader.brightness = -0.5;
            oldShader.saturation = 0;
            oldShader.brightness = 0;*/

            artistName = new FlxText(0, 0, 0, author, 36);
		    artistName.setFormat(Paths.font("microgramma.otf"), 40, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
            artistName.y = 650;
            artistName.screenCenter(X);
            artistName.alpha = 0;
            artistName.cameras = [ArtworkState.camFullscreen];

            artworkGroup = new FlxSpriteGroup();
            borderGroup = new FlxSpriteGroup();

            createImageList();

            add(artworkGroup);
            add(borderGroup);

            changeImagePath();

            curImage = new FlxSprite().loadGraphic(Paths.image(artDirectory + artSuffixFull));
            curImage.antialiasing = ClientPrefs.globalAntialiasing;
            curImage.alpha = 0;
            curImage.updateHitbox();
            curImage.screenCenter();
            curImage.cameras = [ArtworkState.camFullscreen];

            add(curImage);
            add(artistName);

            super.create();
            changeSelectionBorder();
            moveCamObject();
            updateImageList();
        }

        var mouseUse:Bool = false;

        var lastMousePoint:Float;
    override function update(elapsed:Float)
        {
            checkForInput();
            if (mouseUse && !disableInput && !fullscreenState)
                {
                    checkMouseHover();
                }
            
            if (lastMousePoint != FlxG.mouse.screenX)
                {
                    lastMousePoint = FlxG.mouse.screenX;
                    mouseUse = true;
                }
            super.update(elapsed);
        }
    
    var hoveringSomething:Bool = false;

    function checkMouseHover()
        {
            artworkGroup.forEach(function(spr:FlxSprite)
                {
                    if (!hoveringSomething && FlxG.mouse.overlaps(spr))
                    {
                        hoveringSomething = true;
                        if (spr.ID != curSelected)
                            FlxG.sound.play(Paths.sound('scrollMenu'));
                        curSelected = spr.ID;
                        changeImagePath(true, curImage);
                        changeSelectionBorder();
                    }
                    if (!FlxG.mouse.overlaps(spr) && hoveringSomething && spr.ID == curSelected)
                        hoveringSomething = false;
                });
        }

    function moveCamObject(amount:Float = 0)
        {
            ArtworkState.camFollow.y += amount;
            if (ArtworkState.camFollow.y < 359)
                ArtworkState.camFollow.y = 359;
            else if (ArtworkState.camFollow.y > 1200)
                ArtworkState.camFollow.y = 1200;
            //trace(ArtworkState.camFollow.y);
        }

    function checkForInput()
        {
            if (FlxG.mouse.wheel != 0 && !fullscreenState)
                {
                    if (FlxG.keys.pressed.SHIFT)
                        moveCamObject(-1*(FlxG.mouse.wheel * 55));
                    else
                    moveCamObject(-1*(FlxG.mouse.wheel * 30));
                }
            if (controls.BACK)
                {
                    disableInput = true;
                    FlxG.sound.play(Paths.sound('cancelMenu'), 1);
                    if (fullscreenState)
                        {
                            FlxTween.cancelTweensOf(artistName);
                            fullscreenState = false;
                            FlxTween.tween(curImage, {alpha: 0}, 0.15, {
                                onComplete: function(twn:FlxTween)
                                    {
                                        disableInput = false;
                                    }
                            });
                            FlxTween.tween(artistName, {alpha: 0}, 0.15);
                        }
                    else
                        exitanim();

                }
            if ((controls.ACCEPT && !fullscreenState) || (FlxG.mouse.justPressed && !disableInput && hoveringSomething && !fullscreenState))
                {
                    disableInput = true;
                    fullscreenState = true;
                    FlxG.sound.play(Paths.sound('expand'));
                    updateLockImage();
                    curImage.updateHitbox();
                    curImage.screenCenter();
                    
                    FlxTween.tween(curImage, {alpha: 1}, 0.15, {
                        onComplete: function(twn:FlxTween)
                            {
                                disableInput = false;
                            }
                    });
                    FlxTween.tween(artistName, {alpha: 1}, 0.15, {
                        onComplete: function(twn:FlxTween)
                            {
                                pulse(artistName, 0);
                            }
                        });
                }
            if (controls.ACCEPT && fullscreenState && !disableInput)
                {
                    CoolUtil.browserLoad(curLink);
                }
            if (controls.UI_RIGHT_P)
                {
                    FlxG.sound.play(Paths.sound('scrollMenu'));
			        changeItem(1);
                    if (curSelected % 5 == 1 && curSelected != 1)
                        {
                            moveCamObject(100);
                        }
                }
            if (controls.UI_LEFT_P)
                {
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    changeItem(-1);
                    if (curSelected % 5 == 0 && curSelected != 50)
                        {
                            moveCamObject(-100);
                        }
                }
            if (!fullscreenState)
                {
                    if (controls.UI_UP_P)
                        {
                            FlxG.sound.play(Paths.sound('scrollMenu'));
                            changeItem(-5);
                            moveCamObject(-100);
                        }
                    if (controls.UI_DOWN_P)
                        {
                            FlxG.sound.play(Paths.sound('scrollMenu'));
                            changeItem(5);
                            moveCamObject(100);
                        }
                }
        }

    function changeItem(sel:Int = 0)
        {
            curSelected += sel;

            if (!fullscreenState)
                {
                    if (curSelected < 1)
                        {
                            ArtworkState.camFollow.y = 359;
                            curSelected = 1;
                        }
                    if (curSelected > 50)
                        {
                            ArtworkState.camFollow.y = 1200;
                            curSelected = 50;
                        }
                }
            else
                {
                    if (curSelected < 1)
                        {
                            ArtworkState.camFollow.y = 1200;
                            curSelected = 50;
                        }
                    if (curSelected > 50)
                        {
                            ArtworkState.camFollow.y = 359;
                            curSelected = 1;
                        }
                }

            changeSelectionBorder();
            changeImagePath(true, curImage);
            updateLockImage();
            curImage.updateHitbox();
            curImage.screenCenter();
            ArtworkState.curSelected = curSelected;
            mouseUse = false;
        }

        var curLink:String = '';
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
                                        artSuffixFull = file.replace('.png', '');
                                        author = artSuffixFull.replace(curSelected + '_', '');
                                        curLink = creditLink.get(author.toLowerCase());
                                        artistName.text = author.toUpperCase();
                                        artistName.screenCenter(X);
                                        //artSuffix = artSuffix.replace('.png', '');
                                        //trace(artSuffix);
                                    }
                                }
                        }
                }

            if (reloadImage)
                {
                    spr.loadGraphic(Paths.image(artDirectory + artSuffixFull));
                    spr.updateHitbox();
                    spr.screenCenter();
                }
        }

    function changeSelectionBorder()
    {
        borderGroup.forEach(function(spr:FlxSprite)
            {
                if (spr.ID == curSelected)
                    {
                        spr.loadGraphic(Paths.image(menuDirectory + 'expanded_border_selected'));
                    }
                else
                    {
                        spr.loadGraphic(Paths.image(menuDirectory + 'expanded_border'));
                    }
            });
    }

    function exitanim()
        {
            ArtworkState.delayshit(0.44);
            artworkGroup.forEach(function(spr:FlxSprite)
                {
                    FlxTween.tween(spr, {alpha: 0}, 0.22, {
                    ease: FlxEase.cubeIn
                    });
                });
            borderGroup.forEach(function(spr:FlxSprite)
                {
                    FlxTween.tween(spr, {alpha: 0}, 0.22, {
                    ease: FlxEase.cubeIn
                    });
                });

            new FlxTimer().start(0.22, function(tmr:FlxTimer)
            {
                close();
            });
            
        }

    function pulse(spr:FlxSprite, alph:Float = 0.5, dur:Float = 1)
        {
            FlxTween.cancelTweensOf(spr);
            FlxTween.tween(spr, {alpha: alph}, dur,
                {
                ease: FlxEase.quadInOut,
                type: FlxTweenType.PINGPONG
                });
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

                    case 38:
                        if (!Achievements.isAchievementUnlocked('all_voltz_clear'))
                            {
                                curImage.loadGraphic(Paths.image(artDirectory + 'locked'));
                            }

                }
            }

    function createImageList()
        {
            var foldersToCheck:Array<String> = [Paths.getPreloadPath('images/gallery/artwork/gallery_subs/')];
            //var fileNum:Int = 0;
            var column:Int = 0;
            var row:Int = 0;

            var filePrefix:String;

            for (i in 1...51)
                {
                    //fileNum = 0;
                    for (folder in foldersToCheck)
                        {
                            if (FileSystem.exists(folder))
                                {
                                    for (file in FileSystem.readDirectory(folder))
                                        {
                                            //if (fileNum < 50 )
                                            //.fileNum++;
                                            filePrefix = i + '_';
                                            //trace(fileNum);
                                            //trace(file);
                                            //trace(file.startsWith(filePrefix));
                                            if (file.startsWith(filePrefix))
                                                {
                                                    if (row == 5)
                                                        {
                                                            column++;
                                                            row = 0;
                                                        }
                                                    //trace(fileNum);
                                                    artSuffix = file.replace('.png', '');
                                                    //trace(artSuffix);
                                                    var spr = new FlxSprite(28, 29).loadGraphic(Paths.image(artDirectory + artSuffix));
                                                    var border = new FlxSprite(25, 25).loadGraphic(Paths.image(menuDirectory + 'expanded_border'));
                                                    spr.antialiasing = ClientPrefs.globalAntialiasing;
                                                    border.antialiasing = ClientPrefs.globalAntialiasing;
                                                    
                                                    spr.x += 250*row;
                                                    spr.y += 153*column;

                                                    border.x += 250*row;
                                                    border.y += 153*column;

                                                    spr.scale.set(0.176, 0.176);
                                                    spr.updateHitbox();
                                                    spr.ID = i;
                                                    border.ID = i;
                                                    artworkGroup.add(spr);
                                                    borderGroup.add(border);
                                                    row++;
                                                }
                                        }
                                }
                        }

                }
        }

    function updateLockImageCreate(spr:FlxSprite)
        {
            spr.loadGraphic(Paths.image(artDirectory + 'locked'));
            spr.scale.set(0.176, 0.176);
            spr.updateHitbox();
        }

    function updateImageList()
        {
            artworkGroup.forEach(function(spr:FlxSprite)
                {
                    switch (spr.ID)
                        {
                            case 2:
                                if (!Achievements.isAchievementUnlocked('checkpoint_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 5:
                                if (!Achievements.isAchievementUnlocked('rolecall_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 10:
                                if (!Achievements.isAchievementUnlocked('homestretch_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 21:
                                if (!Achievements.isAchievementUnlocked('lightswing_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 22:
                                if (!Achievements.isAchievementUnlocked('tangroove_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 23:
                                if (!Achievements.isAchievementUnlocked('checkpoint_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 24:
                                if (!Achievements.isAchievementUnlocked('meowmix_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 25:
                                if (!Achievements.isAchievementUnlocked('week1-v_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 26:
                                if (!Achievements.isAchievementUnlocked('week2-v_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 27:
                                if (!Achievements.isAchievementUnlocked('week3-v_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 28:
                                if (!Achievements.isAchievementUnlocked('week4-v_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 29:
                                if (!Achievements.isAchievementUnlocked('week5-v_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 30:
                                if (!Achievements.isAchievementUnlocked('week6-v_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 31:
                                if (!Achievements.isAchievementUnlocked('heavyswing_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 32:
                                if (!Achievements.isAchievementUnlocked('fizz_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 33:
                                if (!Achievements.isAchievementUnlocked('homestretch_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 34:
                                if (!Achievements.isAchievementUnlocked('twomah_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 35:
                                if (!Achievements.isAchievementUnlocked('lmhy_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 36:
                                if (!Achievements.isAchievementUnlocked('slightswing_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 37:
                                if (!Achievements.isAchievementUnlocked('rolecall_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                            case 38:
                                if (!Achievements.isAchievementUnlocked('all_voltz_clear'))
                                    {
                                        updateLockImageCreate(spr);
                                    }

                        }
                });
        }

}