package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;

using StringTools;

class CreditsVoltz extends MusicBeatState
{
    public static var curSelected:Int = 0;
	var scrollBar:FlxSprite;
	var vidBtn:FlxSprite;
	var grpPeople:FlxTypedGroup<ShadableSprite>;
	var grpTitle:FlxTypedGroup<FlxText>;
	var grpDesc:FlxTypedGroup<FlxText>;
    var credsList:Array<String> = [''];
	var grpff:FlxTypedGroup<FlxSprite>;
	var scrollDots:FlxBackdrop;
    var lowestScrollGoes:Int = 640;

    var leWidth:Int = 228;
    var leHeight:Int = 465;

    override function create()
        {
            credsList = CoolUtil.coolTextFile(Paths.txt('creditsThing2'));
            var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('creds/backskin'));
            bg.setGraphicSize(Std.int(FlxG.width));
            bg.updateHitbox();
            bg.antialiasing = ClientPrefs.globalAntialiasing;
            add(bg);

            grpPeople = new FlxTypedGroup<ShadableSprite>();
            add(grpPeople);

            grpff = new FlxTypedGroup<FlxSprite>();
            add(grpff);

            grpTitle = new FlxTypedGroup<FlxText>();
            add(grpTitle);

            grpDesc = new FlxTypedGroup<FlxText>();
            add(grpDesc);

            var leID:Int = 0;
            var contArr:Int = 1;
            var contArr2:Int = 0;
            for (i in credsList)
                {
                    var cnum:Int = Std.parseInt(i.split(':')[0]);
                    var cname:String = i.split(':')[1].replace('&','\n');
                    var cfile:String = i.split(':')[2];
                    var cdiscription:String = i.split(':')[3].replace('&','\n');
                    var clink:String = i.split(':')[4];

                    trace('made ${cname} | creds/people/${cnum}. ${cfile}.png');
                    var pp:ShadableSprite = new ShadableSprite(117+(contArr*leWidth),0+(contArr2*leHeight));
                    pp.loadGraphic(Paths.image('creds/people/${cnum}. ${cfile}'));
                    pp.antialiasing = ClientPrefs.globalAntialiasing;
                    pp.setGraphicSize(leWidth,leHeight);
                    pp.updateHitbox();
                    pp.ID = leID;
                    if (leID != 0)
                        pp.setDesat(-100,-30);
                    pp.name = cname;
                    pp.link = clink;
                    if (contArr == 3)
                        pp.isThird = true;
                    grpPeople.add(pp);

		            var titleText:FlxText = new FlxText(-180, 160, FlxG.width - 600, cname, 32);
		            titleText.setFormat(Paths.font("microgramma.otf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		            titleText.scrollFactor.set();
		            titleText.borderSize = 1.25;
                    titleText.ID = leID;
                    if (leID != 0)
                        titleText.visible = false;
		            grpTitle.add(titleText);

		            var descText:FlxText = new FlxText(-180, 180+(titleText.height), FlxG.width - 600, cdiscription, 19);
		            descText.setFormat(Paths.font("microgramma.otf"), 19, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		            descText.scrollFactor.set();
		            descText.borderSize = 0.75;
                    descText.ID = leID;
                    if (leID != 0)
                        descText.visible = false;
		            grpDesc.add(descText);

                    leID++;
                    contArr++;
                    if (contArr > 3)
                        contArr = 1;
                    if (contArr == 1)
                        contArr2++;
                }
            
            var foer:FlxSprite = new FlxSprite().loadGraphic(Paths.image('creds/foreskin'));
            foer.setGraphicSize(Std.int(FlxG.width));
            foer.updateHitbox();
            foer.antialiasing = ClientPrefs.globalAntialiasing;
            grpff.add(foer);
            
            scrollBar = new FlxSprite().loadGraphic(Paths.image('creds/midskin'));
            scrollBar.antialiasing = ClientPrefs.globalAntialiasing;
            scrollBar.setGraphicSize(Std.int(FlxG.width));
            scrollBar.updateHitbox();
            add(scrollBar);

            scrollDots = new FlxBackdrop(Paths.image('soundtest/dots2'), 60, 0, true, false);
            add(scrollDots);

            vidBtn = new FlxSprite().loadGraphic(Paths.image('creds/vid'));
            vidBtn.antialiasing = ClientPrefs.globalAntialiasing;
            vidBtn.setGraphicSize(Std.int(FlxG.width));
            vidBtn.updateHitbox();
            add(vidBtn);

            var stupidText:FlxSprite = new FlxSprite().loadGraphic(Paths.image('creds/spr'));
            stupidText.setGraphicSize(Std.int(FlxG.width));
            stupidText.updateHitbox();
            stupidText.antialiasing = ClientPrefs.globalAntialiasing;
            add(stupidText);

            // Mouse Cursor
            FlxG.mouse.enabled = true;
            FlxG.mouse.visible = true;
            var smashCursor:FlxSprite = new FlxSprite();
			smashCursor.loadGraphic(Paths.image('cursor'));
			smashCursor.antialiasing = ClientPrefs.globalAntialiasing;
			FlxG.mouse.load(smashCursor.pixels, 0.25, -5, -5);

            super.create();
        }

        var lastMouse:Int = 0;
        var isMouse:Bool = false;
        var lastMousePoint:Float;
    override function update(elapsed:Float)
        {
            if (lastMousePoint != FlxG.mouse.screenX)
                {
                    lastMousePoint = FlxG.mouse.screenX;
                    isMouse = true;
                }
            if (FlxG.keys.justPressed.C)
                trace('scroll y : ${scrollBar.y}');

                scrollDots.x += 0.50;
            if (controls.UI_LEFT_P)
                changeItem(-1,true,false);
            if (controls.UI_RIGHT_P)
                changeItem(1,true,false);
            if ((FlxG.mouse.wheel > 0 || controls.UI_UP_P))
                changeItem(-3);
            if ((FlxG.mouse.wheel < 0 || controls.UI_DOWN_P))
                changeItem(3);

            if (isMouse && FlxG.mouse.pressed && FlxG.mouse.screenY < 630 && FlxG.mouse.screenY > 30 && FlxG.mouse.screenX > 990)
                {
                    scrollBar.y = FlxG.mouse.screenY;
                    curSelected = (Math.floor((Math.floor((scrollBar.y / (lowestScrollGoes/credsList.length))) / 3)))*3;
                    selectGraphic(true,scrollBar.y);
                }
            if (isMouse && FlxG.mouse.justPressed && FlxG.mouse.screenY > 395 && FlxG.mouse.screenX < 210 && FlxG.mouse.overlaps(vidBtn))
                {
                    trace('pressed vid button');
					FlxG.sound.music.stop();
                    PlayMedia.di = ['video','creditsNoSound','no'];
                    MusicBeatState.switchState(new PlayMedia());
                    //FlxG.sound.play(Paths.sound('tan'));
                }

                grpPeople.forEach(function(spr:ShadableSprite)
                    {
                        if (isMouse && FlxG.mouse.overlaps(spr))
                            {
                                curSelected = spr.ID;
                                if (lastMouse != curSelected)
                                    FlxG.sound.play(Paths.sound('scrollMenu'));
                                lastMouse = curSelected;
                                selectGraphic(false,0,true);
                            }
                        if (isMouse && FlxG.mouse.justPressed && FlxG.mouse.overlaps(spr))
                            {
                                CoolUtil.browserLoad(spr.link.replace('BROWNBRICKS','https:'));
                            }
                    });

            if (controls.ACCEPT)
                {
                    grpPeople.forEach(function(spr:ShadableSprite)
                        {
                            if (spr.ID == curSelected)
                                CoolUtil.browserLoad(spr.link.replace('BROWNBRICKS','https:'));
                        });
                }

            if (controls.BACK)
                {
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    FlxG.mouse.enabled = false;
                    FlxG.mouse.visible = false;
                    backTrans();
                }
            super.update(elapsed);
        }

        var isR:Bool = false;
        var littleDelay:Bool = true;
        function changeItem(huh:Int = 0,?playSnd:Bool = true,?canShowScroll:Bool = true)
        {
            littleDelay = false;
            isMouse = false;
            isR = false;
            if (huh == 1)
                isR = true;
            if (playSnd)
            FlxG.sound.play(Paths.sound('scrollMenu'));
            curSelected += huh;
    
            if (curSelected >= credsList.length)
                curSelected = credsList.length - 1;
            if (curSelected < 0)
                curSelected = 0;

            if (canShowScroll)
            scrollBar.y = (curSelected * (lowestScrollGoes/(credsList.length)));
            selectGraphic();
        }

        var canScroll:Bool = true;
        function selectGraphic(?doScollCam:Bool = false,?scrollTo:Float = 0,?noScroll:Bool = false)
            {
                canScroll = false;
                grpPeople.forEach(function(spr:ShadableSprite)
                    {
                        if (spr.ID == curSelected)
                            spr.setDesat(0,0);
                        else
                            spr.setDesat(-1,-30);

                        if (spr.x == 117+(leWidth*1) && spr.ID == curSelected && isR)
                            scrollBar.y = (curSelected * (lowestScrollGoes/(credsList.length)));
                        else if (!isR && spr.isThird && spr.ID == curSelected)
                            scrollBar.y = (curSelected * (lowestScrollGoes/(credsList.length)));

                        var calcThing:Float = (leHeight*Math.floor(spr.ID / 3))-(leHeight*Math.floor(curSelected / 3));
    
                        new FlxTimer().start(0.1, function(tmr:FlxTimer)
                            {
                                littleDelay = true;
                            });
                        if (!noScroll)
                            {
                                if (curSelected > -1 && curSelected < credsList.length - 3)
                                    {
                                        FlxTween.tween(spr, {y: calcThing}, 0.2, {
                                            ease: FlxEase.quartOut,
                                            onComplete: function(twn:FlxTween)
                                                {
                                                    canScroll = true;
                                                }
                                        });
                                    }
                                else if (curSelected > -1)
                                    {
                                        //trace('using new cam');
                                        calcThing = (leHeight*Math.floor(spr.ID / 3))-(leHeight*Math.floor((curSelected) / 3));
                                        calcThing += leHeight-200;
                                        FlxTween.tween(spr, {y: calcThing}, 0.2, {
                                            ease: FlxEase.quartOut
                                        });
                                    }
                            }
                    });
                grpTitle.forEach(function(spr:FlxText)
                {
                    if (spr.ID == curSelected)
                        spr.visible = true;
                    else
                        spr.visible = false;
                });
                grpDesc.forEach(function(spr:FlxText)
                {
                    if (spr.ID == curSelected)
                        spr.visible = true;
                    else
                        spr.visible = false;
                });
            }

        function backTrans()
            {
                FlxTransitionableState.skipNextTransIn = true;
                FlxTransitionableState.skipNextTransOut = true;
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
}