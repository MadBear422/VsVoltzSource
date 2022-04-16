package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;

class FreeplaySelect extends MusicBeatState
{
    var bg:FlxSprite;
    var normal:FlxSprite;
    var voltz:FlxSprite;
    var bonus:FlxSprite;
	var highlightnormal:Bool = true;
	var highlightvoltz:Bool = true;
	var highlightbonus:Bool = true;
    var noFuckYou:Bool = true;
    var normalT:FlxSprite;
    var voltzT:FlxSprite;
    var bonusT:FlxSprite;
	var coverUp:FlxSprite = new FlxSprite().loadGraphic(Paths.image('titlemenu/thing'));
    override function create()
        {
            FlxTransitionableState.skipNextTransIn = true;
            FlxTransitionableState.skipNextTransOut = true;
            // Mouse Cursor
            FlxG.mouse.enabled = true;
            FlxG.mouse.visible = true;
            var smashCursor:FlxSprite = new FlxSprite();
            smashCursor.loadGraphic(Paths.image('cursor'));
            smashCursor.antialiasing = ClientPrefs.globalAntialiasing;
            FlxG.mouse.load(smashCursor.pixels, 0.25, -5, -5);

            bg = new FlxSprite().loadGraphic(Paths.image('freeplayThing/bg'));
            bg.antialiasing = ClientPrefs.globalAntialiasing;
            bg.alpha = 0;
            add(bg);

            normalT = new FlxSprite(8,36).loadGraphic(Paths.image('freeplayThing/normal2'));
            normalT.visible = false;
            add(normalT);

            voltzT = new FlxSprite(615,-1).loadGraphic(Paths.image('freeplayThing/voltz2'));
            voltzT.visible = false;
            add(voltzT);

            bonusT = new FlxSprite(611,472).loadGraphic(Paths.image('freeplayThing/bonus2'));
            bonusT.visible = false;
            add(bonusT);

            normal = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('freeplayThing/normalH'));

            if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                normal.loadGraphic(Paths.image('freeplayThing/normal'));
            else
                normal.loadGraphic(Paths.image('freeplayThing/normal_locked'));

            normal.antialiasing = ClientPrefs.globalAntialiasing;
            add(normal);

            voltz = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('freeplayThing/voltzH'));

            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                voltz.loadGraphic(Paths.image('freeplayThing/voltz'));
            else
                voltz.loadGraphic(Paths.image('freeplayThing/voltz_locked'));

            voltz.antialiasing = ClientPrefs.globalAntialiasing;
            add(voltz);

            bonus = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('freeplayThing/bonusH'));
            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                bonus.loadGraphic(Paths.image('freeplayThing/bonus'));
            else
                bonus.loadGraphic(Paths.image('freeplayThing/bonus_locked'));

            bonus.antialiasing = ClientPrefs.globalAntialiasing;
            add(bonus);

            coverUp.setGraphicSize(Std.int(coverUp.width * 10));
            coverUp.screenCenter();
            coverUp.alpha = 0;
            add(coverUp);

            FlxTween.tween(bg, {alpha: 1}, 1, {
            ease: FlxEase.expoOut
            });
            doSpriteTweenIn(0.1,normal);
            doSpriteTweenIn(0.2,voltz);
            doSpriteTweenIn(0.3,bonus);
            new FlxTimer().start(1.3, function(tmr:FlxTimer)
                {
                    canInput = true;
                });
            super.create();
        }

    function doSpriteTweenIn(timerthing:Float,spr:FlxSprite)
        {
            new FlxTimer().start(timerthing, function(tmr:FlxTimer)
                {
                    FlxTween.tween(spr, {y: 0}, 1, {
                    ease: FlxEase.expoOut
                    });
                });
        }
    function doSpriteTweenOut(timerthing:Float,spr:FlxSprite,?speed:Float = 2)
        {
            new FlxTimer().start(timerthing, function(tmr:FlxTimer)
                {
                    FlxTween.tween(spr, {y: FlxG.height}, speed, {
                    ease: FlxEase.cubeIn
                    });
                });
        }
        function doSpriteTweenOut2(timerthing:Float,spr:FlxSprite,?speed:Float = 2)
            {
                new FlxTimer().start(timerthing, function(tmr:FlxTimer)
                    {
                        FlxTween.tween(spr, {alpha: 0}, speed, {
                        ease: FlxEase.expoOut
                        });
                    });
            }

    var curSelected:Int = 0;
    var canInput:Bool = false;
    var mouseUse:Bool = false;
    override function update(elapsed:Float)
        {
            /*if (FlxG.mouse.pressed)
                {
                    bonusT.x = FlxG.mouse.screenX; //hitbox positioning system
                    bonusT.y = FlxG.mouse.screenY;
                    trace(bonusT);
                }*/
            if(canInput && controls.ACCEPT) 
                {
                    if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                        {
                            canInput = false;
                            endanim(curSelected);
                        }
                    else
                        {
                            if (noFuckYou)
                                {
                                    mouseUse = false;
                                    changeItem();
                                    FlxG.sound.play(Paths.sound('noFuckYou'));
                                    FlxG.camera.shake(0.01, 0.15);
                                    noFuckYou = !noFuckYou;
                                    new FlxTimer().start(0.9, function(tmr:FlxTimer)
                                        {
                                            noFuckYou = !noFuckYou;
                                        });
                                }
                        }
                }
            else if(canInput && FlxG.mouse.justPressed && (highlightnormal || highlightvoltz || highlightbonus))
                {
                    if (FlxG.mouse.overlaps(normalT))
                        {
                            if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                                {
                                    canInput = false;
                                    endanim(0);
                                }
                            else
                                {
                                    if (noFuckYou)
                                        {
                                            mouseUse = false;
                                            FlxG.sound.play(Paths.sound('noFuckYou'));
                                            FlxG.camera.shake(0.01, 0.15);
                                            noFuckYou = !noFuckYou;
                                            new FlxTimer().start(0.9, function(tmr:FlxTimer)
                                                {
                                                    noFuckYou = !noFuckYou;
                                                });
                                        }
                                }
                        }
                    else if (FlxG.mouse.overlaps(voltzT))
                        {
                            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                                {
                                    canInput = false;
                                    endanim(1);
                                }
                            else
                                {
                                    if (noFuckYou)
                                        {
                                            mouseUse = false;
                                            FlxG.sound.play(Paths.sound('noFuckYou'));
                                            FlxG.camera.shake(0.01, 0.15);
                                            noFuckYou = !noFuckYou;
                                            new FlxTimer().start(0.9, function(tmr:FlxTimer)
                                                {
                                                    noFuckYou = !noFuckYou;
                                                });
                                        }
                                }
                        }   
                    else if (FlxG.mouse.overlaps(bonusT))
                        {
                            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                                {
                                    canInput = false;
                                    endanim(2);
                                }
                            else
                                {
                                    if (noFuckYou)
                                        {
                                            mouseUse = false;
                                            FlxG.sound.play(Paths.sound('noFuckYou'));
                                            FlxG.camera.shake(0.01, 0.15);
                                            noFuckYou = !noFuckYou;
                                            new FlxTimer().start(0.9, function(tmr:FlxTimer)
                                                {
                                                    noFuckYou = !noFuckYou;
                                                });
                                        }
                                }
                        }
                }

            if(controls.BACK && canInput) {
                FlxG.sound.play(Paths.sound('cancelMenu'), 1);
                canInput = false;
                FlxG.mouse.enabled = false;
                FlxG.mouse.visible = false;
                FlxTween.tween(bg, {alpha: 0}, 0.5, {
                ease: FlxEase.expoOut,
                onComplete: function(twn:FlxTween)
                    {
                        FlxTween.tween(coverUp, {alpha: 1}, 0.2, {
                            ease: FlxEase.cubeIn,
                            onComplete: function(twn:FlxTween)
                                {
                                    MusicBeatState.switchState(new MainMenuState());
                                }
                            });
                    }
                });
                doSpriteTweenOut(0.1,normal,0.4);
                doSpriteTweenOut(0.1,voltz,0.4);
                doSpriteTweenOut(0.1,bonus,0.4);
            }

			if ((controls.UI_LEFT_P || controls.UI_DOWN_P) && canInput)
			{
                if (Achievements.isAchievementUnlocked('homestretch_clear'))
                    {
                        FlxG.sound.play(Paths.sound('scrollMenu'));
				        changeItem(-1);
                    }
                    else
                        {
                            if (noFuckYou)
                                {
                                    mouseUse = false;
                                    changeItem();
                                    FlxG.sound.play(Paths.sound('noFuckYou'));
                                    FlxG.camera.shake(0.01, 0.15);
                                    noFuckYou = !noFuckYou;
                                    new FlxTimer().start(0.9, function(tmr:FlxTimer)
                                        {
                                            noFuckYou = !noFuckYou;
                                        });
                                }
                        }
			}
			if ((controls.UI_RIGHT_P || controls.UI_UP_P) && canInput)
			{
				if (Achievements.isAchievementUnlocked('homestretch_clear'))
                    {
                        FlxG.sound.play(Paths.sound('scrollMenu'));
				        changeItem(1);
                    }
                else
                    {
                        if (noFuckYou)
                            {
                                mouseUse = false;
                                changeItem();
                                FlxG.sound.play(Paths.sound('noFuckYou'));
                                FlxG.camera.shake(0.01, 0.15);
                                noFuckYou = !noFuckYou;
                                new FlxTimer().start(0.9, function(tmr:FlxTimer)
                                    {
                                        noFuckYou = !noFuckYou;
                                    });
                            }
                    }

			}

            if (!highlightnormal && FlxG.mouse.overlaps(normalT) && canInput)
                {
                    mouseUse = true;
                    bounceAnim(normal);
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                        normal.loadGraphic(Paths.image('freeplayThing/normalH'));
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                        voltz.loadGraphic(Paths.image('freeplayThing/voltz'));
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                        bonus.loadGraphic(Paths.image('freeplayThing/bonus'));
                    highlightnormal = true;
                    if (FlxG.mouse.justPressed)
                        trace('this fr');
                }
            else if (!highlightvoltz && FlxG.mouse.overlaps(voltzT) && canInput)
                {
                    mouseUse = true;
                    bounceAnim(voltz);
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                        normal.loadGraphic(Paths.image('freeplayThing/normal'));
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                        voltz.loadGraphic(Paths.image('freeplayThing/voltzH'));
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                        bonus.loadGraphic(Paths.image('freeplayThing/bonus'));
                    highlightvoltz = true;
                    if (FlxG.mouse.justPressed)
                        trace('this fr');
                }
            else if (!highlightbonus && FlxG.mouse.overlaps(bonusT) && canInput)
                {
                    mouseUse = true;
                    bounceAnim(bonus);
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                        bonus.loadGraphic(Paths.image('freeplayThing/bonusH'));
                    if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                        normal.loadGraphic(Paths.image('freeplayThing/normal'));
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                        voltz.loadGraphic(Paths.image('freeplayThing/voltz'));
                    highlightbonus = true;
                    if (FlxG.mouse.justPressed)
                        trace('this fr');
                }
            if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                {
                    if (highlightnormal && !FlxG.mouse.overlaps(normalT) && canInput)
                        {
                            normal.loadGraphic(Paths.image('freeplayThing/normal'));
                            highlightnormal = false;
                        }
                }
            
            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                {
                    if (highlightvoltz && !FlxG.mouse.overlaps(voltzT) && canInput)
                        {
                            voltz.loadGraphic(Paths.image('freeplayThing/voltz'));
                            highlightvoltz = false;
                        }
                }
            
            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                {
                    if (highlightbonus && !FlxG.mouse.overlaps(bonusT) && canInput)
                        {
                            bonus.loadGraphic(Paths.image('freeplayThing/bonus'));
                            highlightbonus = false;
                        }
                }

            super.update(elapsed);
        }
    function endanim(curone:Int)
        {
            FlxG.sound.play(Paths.sound('confirmMenu'), 1);

            bg.alpha = 0;

            normal.loadGraphic(Paths.image('freeplayThing/normal'));
            voltz.loadGraphic(Paths.image('freeplayThing/voltz'));
            bonus.loadGraphic(Paths.image('freeplayThing/bonus'));

            FlxG.camera.flash(FlxColor.WHITE, 0.3);
            switch(curone)
            {
                case 0:
                    normal.loadGraphic(Paths.image('freeplayThing/normalH'));
                    doSpriteTweenOut2(1,normal,0.6);
                    voltz.alpha = 0;
                    bonus.alpha = 0;
                    FreeplayState.curList = 'weekList-Bf';
                case 1:
                    voltz.loadGraphic(Paths.image('freeplayThing/voltzH'));
                    doSpriteTweenOut2(1,voltz,0.6);
                    normal.alpha = 0;
                    bonus.alpha = 0;
                    FreeplayState.curList = 'weekList-V';
                case 2:
                    bonus.loadGraphic(Paths.image('freeplayThing/bonusH'));
                    doSpriteTweenOut2(1,bonus,0.6);
                    voltz.alpha = 0;
                    normal.alpha = 0;
                    FreeplayState.curList = 'weekList-Bonus';
            }
            new FlxTimer().start(1.6, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
        }
	function changeItem(huh:Int = 0)
        {
            mouseUse = false;
            curSelected += huh;
            
            if (Achievements.isAchievementUnlocked('checkpoint_clear') && !Achievements.isAchievementUnlocked('homestretch_clear'))
                {
                    if (curSelected > 0)
                        {
                            curSelected = 0;
                        }
                    if (curSelected < 0)
                        {
                            curSelected = 0;
                        }
                }
            else if (Achievements.isAchievementUnlocked('homestretch_clear') && Achievements.isAchievementUnlocked('checkpoint_clear'))
                {
                    if (curSelected > 2)
                        {
                            curSelected = 0;
                        }
                    if (curSelected < 0)
                        {
                            curSelected = 2;
                        }
                }
            if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                normal.loadGraphic(Paths.image('freeplayThing/normal'));
            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                voltz.loadGraphic(Paths.image('freeplayThing/voltz'));
            if (Achievements.isAchievementUnlocked('homestretch_clear'))
                bonus.loadGraphic(Paths.image('freeplayThing/bonus'));

            switch(curSelected)
            {
                case 0:
                    if (Achievements.isAchievementUnlocked('checkpoint_clear'))
                        {
                            normal.loadGraphic(Paths.image('freeplayThing/normalH'));
                            bounceAnim(normal);
                        }
                case 1:
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                    voltz.loadGraphic(Paths.image('freeplayThing/voltzH'));
                    bounceAnim(voltz);
                case 2:
                    if (Achievements.isAchievementUnlocked('homestretch_clear'))
                    bonus.loadGraphic(Paths.image('freeplayThing/bonusH'));
                    bounceAnim(bonus);
            }
        }

    function bounceAnim(spr:FlxSprite)
        {
            spr.scale.set(1,1);
            FlxTween.tween(spr.scale, {x: 1+0.07/*, y: 1+0.07*/}, 0.025, {
            ease: FlxEase.linear,
            onComplete: function(twn:FlxTween)
            {
                FlxTween.tween(spr.scale, {x: 1/*, y: 1*/}, 0.3, {
                ease: FlxEase.circOut
                });
            }
            });
        }
}