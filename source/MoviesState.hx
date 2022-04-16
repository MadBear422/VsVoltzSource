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
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import openfl.display.BlendMode;
import flixel.FlxG;
import Shaders;

class MoviesState extends MusicBeatState {

    //shaders
    var newShader:ColorSwap = new ColorSwap();
	var oldShader:ColorSwap = new ColorSwap();

    public var camHUDShaders:Array<ShaderEffect> = [];

    var bgSprites:FlxSpriteGroup;
    var fgSprites:FlxSpriteGroup;
    var pumpGroup:FlxSpriteGroup;
    var sectionButtons:FlxSpriteGroup;

    var thumbSprites:FlxSpriteGroup;

    var selectedLine:FlxSprite;
    var bgCheckers:FlxSprite;
    var scrollCheckers:FlxBackdrop;

    var sectionInfo:FlxSprite;
    var blurredMap:FlxSprite;
    var overlayGlow:FlxSprite;

    var fgLines:FlxSprite;

    var menuDirectory:String = 'gallery/movies/';

    var disableInput:Bool = false;
    var mouseUse:Bool = false;

    public static var curSelected:Int = 0;

    public static var curSection:Int = 0;
    var denyAccess:Bool = false;
    var noFuckYou:Bool = true;

    // video codenames
    private var thumbList:Array<String> = [
        'ballgame',         //0
		'transformation',       //1
        'checkpoint',   //2
        'tutorial', //3
		'week1',    //4
		'week2',    //5
        'week3',    //6
		'week4',    //7
		'week5',    //8
		'week6',    //9
		'rematch',  //10
        'ending',   //11
        'twomah',   //12
        'LMHY',     //13
        'slightswing',//14
        'rolecall',//15
        'unlockginger',//16
        'doomah',//17
        'real',//18
        'artisticaltitude',//19
        'grannyvanny',//20
        'picocomelon',//21
        'poggerz',//22
        'knob',//23
        'betamale',//24
        'awwsad',//25
        'hesgood',//26
        'eeaa',//27
        'gobble',//28
        'oldtrailer',//29
        'finaltrailer',//30
        'watchthis'//31
	];

    private var videoMap:Map<String, String> = [
        'ballgame' => 'weekv',
        'transformation' => 'week1S',
        'checkpoint' => 'week1End',
        'tutorial' => 'tutorial',
        'week1' => 'week1',
        'week2' => 'week2',
        'week3' => 'week3',
        'week4' => 'week4',
        'week5' => 'week5',
        'week6' => 'week6',
        'rematch' => 'weekb',
        'ending' => 'ending',
        'slightswing' => 'Slightswing',
        'LMHY' => 'LMHY',
        'twomah' => 'Twomah',
        'rolecall' => 'Rolecall',
        'unlockginger' => 'voltzunlock',
        'doomah' => 'Doomah',
        'real' => 'GetReal',
        'artisticaltitude' => 'ILOVEARTISTICALTITUDE',
        'grannyvanny' => 'MyGrandson',
        'picocomelon' => 'Pico',
        'poggerz' => 'TheRat',
        'knob' => 'TheTimeKnob',
        'betamale' => 'TUTORIAL_BETA_CUTSCENE',
        'awwsad' => 'SadCutscene',
        'hesgood' => 'hesgood',
        'eeaa' => 'eeaa',
        'gobble' => 'gobble',
        'oldtrailer' => 'oldtrailer',
        'finaltrailer' => 'finaltrailer',
        'watchthis' => 'watchthis'
    ];

    override function create() {
        // MEMORY BITCH
        Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

        camHUDShaders.push(new ShaderFilter(new VCRDistortionShader()));
        camHUDShaders.push(new ShaderFilter(new ChromaticAberrationShader()));
        var newCamEffects:Array<BitmapFilter>=[];
				for(i in camHUDShaders){
				  newCamEffects.push(new ShaderFilter(i.shader));
				}
        FlxG.camera.setFilters(newCamEffects);
        //shader data
        newShader.saturation = -1;
	    newShader.brightness = -0.5;
	    oldShader.saturation = 0;
	    oldShader.brightness = 0;

        persistentUpdate = persistentDraw = true;

        bgCheckers = new FlxSprite().loadGraphic(Paths.image(menuDirectory + 'checkers'));
        scrollCheckers = new FlxBackdrop(bgCheckers.graphic, 60, 45, true, true);
        scrollCheckers.velocity.set(30, 20);

        FlxTransitionableState.skipNextTransIn = true;
		//FlxTransitionableState.skipNextTransOut = true;

        FlxG.mouse.visible = true;
		FlxG.mouse.enabled = true;
        FlxG.mouse.useSystemCursor = true;

        bgSprites = new FlxSpriteGroup();
        fgSprites = new FlxSpriteGroup();
        pumpGroup = new FlxSpriteGroup();
        sectionButtons = new FlxSpriteGroup();

        thumbSprites = new FlxSpriteGroup();
        
        var menubg = new FlxSprite().loadGraphic(Paths.image('gallery/movies/menubg'));
        menubg.setGraphicSize(FlxG.width, FlxG.height);
        menubg.screenCenter();
        bgSprites.add(menubg);

        /*var checker1 = new FlxSprite().loadGraphic(Paths.image('gallery/movies/checker1'));
        checker1.screenCenter();
        checker1.alpha = 0.65;
		checker1.antialiasing = ClientPrefs.globalAntialiasing;
        bgSprites.add(checker1);*/

        /*var checker2 = new FlxSprite().loadGraphic(Paths.image('gallery/movies/checker2'));
        checker2.screenCenter();
        checker2.alpha = 0.65;
        checker2.antialiasing = ClientPrefs.globalAntialiasing;
        bgSprites.add(checker2);*/

        var thingy1 = new FlxSprite(-78.7, 583.3).loadGraphic(Paths.image('gallery/movies/thingy1'));
        thingy1.antialiasing = ClientPrefs.globalAntialiasing;
        // thingy1.x += 300;
        fgSprites.add(thingy1);

        var thingy2 = new FlxSprite(1109.4, -52.4).loadGraphic(Paths.image('gallery/movies/thingy2'));
        thingy2.antialiasing = ClientPrefs.globalAntialiasing;
        fgSprites.add(thingy2);

        blurredMap = new FlxSprite().loadGraphic(Paths.image('gallery/movies/glow'));
        blurredMap.antialiasing = ClientPrefs.globalAntialiasing;

        sectionInfo = new FlxSprite().loadGraphic(Paths.image(menuDirectory + 'sections/section_' + (curSection+1)));
        updateText();
        sectionInfo.antialiasing = ClientPrefs.globalAntialiasing;

        var sprTitle:FlxSprite = new FlxSprite(122.1, 41.9).loadGraphic(Paths.image(menuDirectory + 'state_text'));
        sprTitle.antialiasing = ClientPrefs.globalAntialiasing;


        overlayGlow = new FlxSprite().loadGraphic(Paths.image(menuDirectory + 'overlay'));
        overlayGlow.setGraphicSize(FlxG.width, FlxG.height);
        overlayGlow.screenCenter();
        overlayGlow.antialiasing = ClientPrefs.globalAntialiasing;

        selectedLine = new FlxSprite(0,0).loadGraphic(Paths.image(menuDirectory + 'selected'));
        selectedLine.antialiasing = ClientPrefs.globalAntialiasing;

        var staticline = new FlxSprite().loadGraphic(Paths.image('gallery/movies/staticlines'));
        staticline.setGraphicSize(FlxG.width, FlxG.height);
        staticline.screenCenter();
        staticline.alpha = 0.25;
        staticline.antialiasing = ClientPrefs.globalAntialiasing;
        //fgSprites.add(staticline);

        var pumpshad = new FlxSprite().loadGraphic(Paths.image('gallery/movies/pumpbg2'));
        pumpshad.scale.set(0.58,0.58);
        pumpshad.screenCenter();
        pumpshad.x = 1600;
        pumpshad.alpha = 0.0001;
        pumpshad.antialiasing = ClientPrefs.globalAntialiasing;
        pumpGroup.add(pumpshad);

        var pumpcolor = new FlxSprite().loadGraphic(Paths.image('gallery/movies/pumpbg1'));
        pumpcolor.scale.set(0.58,0.58);
        pumpcolor.screenCenter();
        pumpcolor.x = 1600;
        pumpcolor.alpha = 0.0001;
        pumpcolor.antialiasing = ClientPrefs.globalAntialiasing;
        pumpcolor.color.lightness = 0.65;
        pumpGroup.add(pumpcolor);

        var pump = new FlxSprite().loadGraphic(Paths.image('gallery/movies/pump'));
        pump.scale.set(0.58,0.58);
        pump.screenCenter();
        pump.x = 1600;
        pump.alpha = 0.0001;
        pump.antialiasing = ClientPrefs.globalAntialiasing;
        pumpGroup.add(pump);


        // Section Buttons
        for (i in 0...3)
            {
                switch (i)
                {
                case 0:
                    var spr = new FlxSprite(105.9, 660).loadGraphic(Paths.image(menuDirectory + 'selection_' + (curSection+1)));
                    spr.antialiasing = ClientPrefs.globalAntialiasing;
                    sectionButtons.add(spr);
                    spr.ID = i;
                
                case 1:
                    var spr = new FlxSprite(79.9, 666.3).loadGraphic(Paths.image(menuDirectory + 'next'));
                    spr.antialiasing = ClientPrefs.globalAntialiasing;
                    spr.flipX = true;
                    sectionButtons.add(spr);
                    spr.ID = i;

                case 2:
                    var spr = new FlxSprite(162.6, 666.3).loadGraphic(Paths.image(menuDirectory + 'next'));
                    spr.antialiasing = ClientPrefs.globalAntialiasing;
                    sectionButtons.add(spr);
                    spr.ID = i;
                    

                }
                    
            }

        // Thumbnail Groups
        for (i in 0...8)
            {
                var spr = new FlxSprite().loadGraphic(Paths.image(menuDirectory + 'thumbs/' + thumbList[i + (8*curSection)]));
                spr.antialiasing = ClientPrefs.globalAntialiasing;
                switch (i)
                {
                    case 0:
                        spr.x = 82;
                        spr.y = 160.4;
                    
                    case 1:
                        spr.x = 82;
                        spr.y = 280.9;


                    case 2:
                        spr.x = 82;
                        spr.y = 402.9;


                    case 3:
                        spr.x = 82;
                        spr.y = 524.3;


                    case 4:
                        spr.x = 431;
                        spr.y = 158.8;

                    case 5:
                        spr.x = 431;
                        spr.y = 279.8;

                    case 6:
                        spr.x = 431;
                        spr.y = 400.8;
                    
                    case 7:
                        spr.x = 431;
                        spr.y = 522.7;

                }
                spr.ID = i;
                thumbSprites.add(spr);
            }

        fgLines = new FlxSprite(172.1, 199.2).loadGraphic(Paths.image(menuDirectory + 'lines'));
        fgLines.antialiasing = ClientPrefs.globalAntialiasing;





        add(bgSprites);
        add(overlayGlow);
        add(scrollCheckers);
        add(pumpGroup);

        add(sprTitle);

        add(blurredMap);

        add(fgLines);

        add(sectionInfo);

        add(thumbSprites);

        add(selectedLine);

        add(fgSprites);

        add(sectionButtons);

        for	(spr in pumpGroup)
        {
            spr.origin.set(940, 346);
        }

        new FlxTimer().start(0, function (tmr:FlxTimer) {
            charTransitionIn();
        });
        
        super.create();
        repositionSelected();
        pulse(selectedLine);
        pulse(overlayGlow, 0.5, 2.5);
        pulse(blurredMap);
        updateShader();
        changeItem();
        updateThumbGraphic();
    }

    override function update(elapsed:Float) {
        #if debug
        if (FlxG.mouse.justPressed)
            trace("x " + FlxG.mouse.x + " y " + FlxG.mouse.y);
        #end
        //generateParticles();
        if (!disableInput)
            redactedMoment();

        if (controls.BACK && !disableInput)
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

        if ((controls.ACCEPT && denyAccess && !disableInput) || (FlxG.mouse.justPressed && denyAccess && !disableInput && hoveringSomething))
            {
                if (noFuckYou)
                    {
                        FlxG.sound.play(Paths.sound('noFuckYou'));
                        FlxG.camera.shake(0.01, 0.15);
                        noFuckYou = !noFuckYou;
                        new FlxTimer().start(0.9, function(tmr:FlxTimer)
                            {
                                noFuckYou = !noFuckYou;
                            });
                    }
            }

        if ((controls.ACCEPT && !disableInput && !denyAccess) || (FlxG.mouse.justPressed && !disableInput && hoveringSomething && !denyAccess))
            {
                acceptSelection();
            }

        if (mouseUse && !disableInput)
            {
                checkMouseHover();
            }
        
        if (FlxG.mouse.justMoved)
            {
                mouseUse = true;
            }


                if (controls.UI_UP_P && !disableInput)
                    {
                        //disableInput = true;
                        FlxG.sound.play(Paths.sound('scrollMenu'));
                        changeItem(-1);
                    }
                if (controls.UI_DOWN_P && !disableInput)
                    {
                        //disableInput = true;
                        FlxG.sound.play(Paths.sound('scrollMenu'));
                        changeItem(1);
                    }
                if (controls.UI_RIGHT_P && !disableInput)
                    {
                        //disableInput = true;
                        FlxG.sound.play(Paths.sound('scrollMenu'));
                        if (curSelected <= 3)
                            changeItem(4);
                        else
                            {
                                changeSection(1);
                                changeItem(-4);
                            }
                    }
                if (controls.UI_LEFT_P && !disableInput)
                    {
                        //disableInput = true;
                        FlxG.sound.play(Paths.sound('scrollMenu'));
                        if (curSelected > 3)
                            changeItem(-4);
                        else
                            {
                                changeSection(-1);
                                changeItem(4);
                            }
                    }
        super.update(elapsed);
        // var scrollShit:Float = FlxG.height * 0.3 * 0.25 * FlxG.elapsed;
        // checker1.scrollX -= scrollShit * 1.5;
        // checker1.scrollY += scrollShit * 1.5;
        // checker2.scrollX += scrollShit * 1.5;
        // checker2.scrollY += scrollShit * 1.5;
    }

    // Sector's code for particles
    function generateParticles()
        {
            new FlxTimer().start(0.001, function(tmr:FlxTimer) //die
                {
                    var partic = new FlxSprite(0, 1200).loadGraphic(Paths.image('onme_singular_particle'));
                    partic.visible = true;
                    partic.alpha = 1.0;
                    partic.setGraphicSize(Std.int(partic.width * FlxG.random.float(0.015, 0.035)));
                    partic.updateHitbox();
                    partic.antialiasing = ClientPrefs.globalAntialiasing;
                    partic.x = FlxG.random.int(-2500, 2500);
                    partic.y = 1200;
                    partic.velocity.x = -250 + FlxG.random.int(0, 250);
                    partic.velocity.y = 0 - FlxG.random.int(900, 1200);
                    //partShader = new ColorSwap();

                    //partic.shader = partShader.shader;
                    //partShader.hue = FlxG.random.int(0, 256);
                    add(partic);
                    
                    FlxTween.tween(partic, {alpha: 0.0}, 2.5, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween)
                        {
                            partic.destroy();
                        }});
                    
                    if (tmr.loops == 100) // CLEAN YO MEMORY FFS
                        tmr.destroy();
                }, 100);
        }

    var spellingStep:Int = 0; //sillywilly

    function redactedMoment()
        {
            if (FlxG.keys.anyJustPressed([EIGHT,ZERO,ONE,THREE,FIVE]))
                {
                    var correct:Bool = false;
                    switch (spellingStep)
                    {
                        case 0:
					        if (FlxG.keys.justPressed.EIGHT) { correct = true; }
                        case 1:
					        if (FlxG.keys.justPressed.ZERO) { correct = true; }
                        case 2:
					        if (FlxG.keys.justPressed.ZERO) { correct = true; }
                        case 3:
					        if (FlxG.keys.justPressed.EIGHT) { correct = true; }
                        case 4:
					        if (FlxG.keys.justPressed.ONE) { correct = true; }
                        case 5:
                            if (FlxG.keys.justPressed.THREE) { correct = true; }
                        case 6:
                            if (FlxG.keys.justPressed.FIVE)
                                {
                                    FlxG.sound.music.fadeOut(0.3, 0);
                                    new FlxTimer().start(0.3, function(tmr:FlxTimer)
                                        {
                                            FlxG.sound.music.pause();
                                        });
                                        disableInput = true;
                                        FlxG.mouse.visible = false;
                                        FlxG.mouse.enabled = false;
                                        FlxG.sound.play(Paths.sound('enterload'));
                                        var whiteSquare:FlxSprite = new FlxSprite();
                                        whiteSquare.makeGraphic(1300, 750, FlxColor.WHITE);
                                        whiteSquare.screenCenter();
                                        whiteSquare.alpha = 0;
                                        add(whiteSquare);
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
                                                                        StoryVideo.galleryVideo = true;
                                                                        StoryVideo.galleryVideoName = 'redacted';
                                                                        MusicBeatState.switchState(new StoryVideo());
                                                                    }
                                                                });
                                                        });
                                                }
                                            });
                                }
                    }
                    if (correct) { spellingStep++; }
			        else { spellingStep = 0; }
                }
        }

    function repositionSelected()
        {
            thumbSprites.forEach(function(spr:FlxSprite)
                {
                    if (spr.ID == curSelected)
                    {
                        selectedLine.x = spr.x - 15;
                        selectedLine.y = spr.y;

                        blurredMap.x = spr.x - 20;
                        blurredMap.y = spr.y - 20;
                    }
                });
        }

    function updateShader()
        {
            thumbSprites.forEach(function(spr:FlxSprite)
                {
                    if (spr.ID == curSelected)
                        {
                            spr.shader = oldShader.shader;
                        }
                    else
                        {
                            spr.shader = newShader.shader;
                        }
                });
        }

    function acceptSelection()
        {
            FlxG.sound.music.fadeOut(0.3, 0);
            new FlxTimer().start(0.3, function(tmr:FlxTimer)
                {
                    FlxG.sound.music.pause();
                });
                disableInput = true;
                FlxG.mouse.visible = false;
                FlxG.mouse.enabled = false;
                FlxG.sound.play(Paths.sound('enterload'));
                var whiteSquare:FlxSprite = new FlxSprite();
                whiteSquare.makeGraphic(1300, 750, FlxColor.WHITE);
                whiteSquare.screenCenter();
                whiteSquare.alpha = 0;
                add(whiteSquare);
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
                                                StoryVideo.galleryVideo = true;
                                                StoryVideo.galleryVideoName = videoMap.get(thumbList[curSelected + (8*curSection)]);
                                                MusicBeatState.switchState(new StoryVideo());
                                            }
                                        });
                                });
                        }
                    });
        }
    function updateText()
        {
            sectionInfo.loadGraphic(Paths.image(menuDirectory + 'sections/section_' + (curSection+1)));
            if ((curSection+1) == 1)
                {
                    sectionInfo.x = 178;
                    sectionInfo.y = 169;
                }
            else if ((curSection+1) == 2)
                {
                    sectionInfo.x = 204.8;
                    sectionInfo.y = 169.1;
                }
            else if ((curSection+1) == 3)
                {
                    sectionInfo.x = 178;
                    sectionInfo.y = 167.9;
                }
            else if ((curSection+1) == 4)
                {
                    sectionInfo.x = 239.4;
                    sectionInfo.y = 166.8;
                }
        }

    function updateThumbGraphic(direction:Int = 0)
        {
            updateText();
            if (direction != 0)
                {
                    sectionInfo.alpha = 0;
                    sectionInfo.x -= (20*direction);
                    FlxTween.tween(sectionInfo, {x: sectionInfo.x + (20*direction), alpha: 1}, 0.07);
                }
            thumbSprites.forEach(function(spr:FlxSprite)
                {
                    if (direction != 0)
                        disableInput = true;
                    spr.loadGraphic(Paths.image(menuDirectory + 'thumbs/' + thumbList[spr.ID + (8*curSection)]));
                    if (direction != 0)
                        {
                            spr.alpha = 0;
                            spr.x -= (20*direction);
                            FlxTween.tween(spr, {x: spr.x + (20*direction), alpha: 1}, 0.07,
                            {   
                                onComplete: function(twn:FlxTween)
                                    {
                                        disableInput = false;
                                        repositionSelected();
                                    }
                            });
                        }
                    // Unlock Parameters
                    switch (spr.ID)
                    {
                        case 0:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'ballgame':
                                    checkUnlockParam('lightswing_clear', spr);

                                case 'week5':
                                    checkUnlockParam('week5-v_clear', spr);

                                case 'unlockginger':
                                    checkUnlockParam('checkpoint_clear', spr);

                                case 'betamale':
                                    checkUnlockParam('meowmix_clear', spr);
                            }
                        
                        case 1:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'transformation':
                                    checkUnlockParam('checkpoint_clear', spr);

                                case 'week6':
                                    checkUnlockParam('week6-v_clear', spr);

                                case 'doomah':
                                    checkUnlockParam('twomah_clear', spr);

                                case 'awwsad':
                                    checkUnlockParam('zapped_5', spr);
                            }

                        case 2:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'checkpoint':
                                    checkUnlockParam('checkpoint_clear', spr);

                                case 'rematch':
                                    checkUnlockParam('week6-v_clear', spr);

                                case 'hesgood':
                                    checkUnlockParam('zapped_15', spr);
                            }

                        case 3:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'tutorial':
                                    checkUnlockParam('meowmix_clear', spr);

                                case 'ending':
                                    checkUnlockParam('homestretch_clear', spr);

                                case 'artisticaltitude':
                                    checkUnlockParam('checkpoint_clear', spr);

                                case 'eeaa':
                                    checkUnlockParam('tangroove_clear', spr);
                            }

                        case 4:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'week1':
                                    checkUnlockParam('week1-v_clear', spr);

                                case 'twomah':
                                    checkUnlockParam('twomah_clear', spr);

                                case 'gobble':
                                    checkUnlockParam('homestretch_clear', spr);
                            }

                        case 5:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'week2':
                                    checkUnlockParam('week2-v_clear', spr);

                                case 'LMHY':
                                    checkUnlockParam('lmhy_clear', spr);

                                case 'picocomelon':
                                    checkUnlockParam('slightswing_blammed', spr);
                            }

                        case 6:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'week3':
                                    checkUnlockParam('week3-v_clear', spr);

                                case 'slightswing':
                                    checkUnlockParam('slightswing_clear', spr);

                            }

                        case 7:
                            switch (thumbList[spr.ID + (8*curSection)])
                            {
                                case 'week4':
                                    checkUnlockParam('week4-v_clear', spr);

                                case 'rolecall':
                                    checkUnlockParam('rolecall_clear', spr);
                            }
                    }
                });
            if (direction != 0)
                {
                    sectionButtons.forEach(function(spr:FlxSprite)
                        {
                            if (spr.ID == 0)
                                {
                                    spr.loadGraphic(Paths.image(menuDirectory + 'selection_' + (curSection+1)));
                                    spr.alpha = 0;
                                    spr.x -= (20*direction);
                                    FlxTween.tween(spr, {x: spr.x + (20*direction), alpha: 1}, 0.07);
                                }
                            
                            if (spr.ID == 1)
                                {
                                    if (direction < 0)
                                        {
                                            spr.loadGraphic(Paths.image(menuDirectory + 'nexthit'));
                                            new FlxTimer().start(0.07, function (tmr:FlxTimer) {
                                                spr.loadGraphic(Paths.image(menuDirectory + 'next'));
                                            });
                                        }
                                }
        
                            if (spr.ID == 2)
                                {
                                    if (direction > 0)
                                        {
                                            spr.loadGraphic(Paths.image(menuDirectory + 'nexthit'));
                                            new FlxTimer().start(0.07, function (tmr:FlxTimer) {
                                                spr.loadGraphic(Paths.image(menuDirectory + 'next'));
                                            });
                                        }
                                }
        
                        });
                }
        }

    function changeSection(sel:Int = 0)
        {
            curSection += sel;

            if (curSection > 3)
                curSection = 0;
            if (curSection < 0)
                curSection = 3;

            updateThumbGraphic(sel);
        }

    function determineAccess(ach:String)
        {
            if (!Achievements.isAchievementUnlocked(ach))
            {
                denyAccess = true;
            }
            else
                denyAccess = false;
        }

    function changeItem(sel:Int = 0)
        {
            if (sel != 0)
            mouseUse = false;
            curSelected += sel;

            if (curSelected >= thumbSprites.length)
                curSelected = 4;
            if (curSelected < 0)
                curSelected = 3;
            // Unlock Parameters
            switch (curSelected)
            {
                case 0:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'ballgame':
                            determineAccess('lightswing_clear');

                        case 'week5':
                            determineAccess('week5-v_clear');

                        case 'unlockginger':
                            determineAccess('checkpoint_clear');

                        case 'betamale':
                            determineAccess('meowmix_clear');

                        default:
                            denyAccess = false;
                    }
                
                case 1:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'transformation':
                            determineAccess('checkpoint_clear');

                        case 'week6':
                            determineAccess('week6-v_clear');

                        case 'doomah':
                            determineAccess('twomah_clear');

                        case 'awwsad':
                            determineAccess('zapped_5');

                        default:
                            denyAccess = false;
                    }

                case 2:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'checkpoint':
                            determineAccess('checkpoint_clear');

                        case 'rematch':
                            determineAccess('week6-v_clear');

                        case 'hesgood':
                            determineAccess('zapped_15');

                        default:
                            denyAccess = false;
                    }

                case 3:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'tutorial':
                            determineAccess('meowmix_clear');

                        case 'ending':
                            determineAccess('homestretch_clear');

                        case 'artisticaltitude':
                            determineAccess('checkpoint_clear');

                        case 'eeaa':
                            determineAccess('tangroove_clear');

                        default:
                            denyAccess = false;
                    }

                case 4:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'week1':
                            determineAccess('week1-v_clear');

                        case 'twomah':
                            determineAccess('twomah_clear');

                        case 'gobble':
                            determineAccess('homestretch_clear');

                        default:
                            denyAccess = false;
                    }

                case 5:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'week2':
                            determineAccess('week2-v_clear');

                        case 'LMHY':
                            determineAccess('lmhy_clear');

                        case 'picocomelon':
                            determineAccess('slightswing_blammed');

                        default:
                            denyAccess = false;
                    }

                case 6:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'week3':
                            determineAccess('week3-v_clear');

                        case 'slightswing':
                            determineAccess('slightswing_clear');

                        default:
                            denyAccess = false;

                    }

                case 7:
                    switch (thumbList[curSelected + (8*curSection)])
                    {
                        case 'week4':
                            determineAccess('week4-v_clear');

                        case 'rolecall':
                            determineAccess('rolecall_clear');

                        default:
                            denyAccess = false;
                    }
            }
            repositionSelected();
            updateShader();
        }

    function pulse(spr:FlxSprite, alph:Float = 0.5, dur:Float = 1)
        {
            FlxTween.tween(spr, {alpha: alph}, dur,
                {
                ease: FlxEase.quadInOut,
                type: FlxTweenType.PINGPONG
                });
        }

    var hoveringSomething:Bool = false;
    var hoveringButton:Bool = false;

    function checkUnlockParam(ach:String = 'none lmao', spr:FlxSprite)
        {
            if (!Achievements.isAchievementUnlocked(ach))
                {
                    spr.loadGraphic(Paths.image(menuDirectory + 'thumbs/locked'));
                }
        }

    function checkMouseHover()
        {
            thumbSprites.forEach(function(spr:FlxSprite)
                {
                    if (!hoveringSomething && FlxG.mouse.overlaps(spr))
                    {
                        hoveringSomething = true;
                        if (spr.ID != curSelected)
                            FlxG.sound.play(Paths.sound('scrollMenu'));
                        curSelected = spr.ID;
                        //repositionSelected();
                        //updateShader();
                        changeItem();
                    }
                    if (!FlxG.mouse.overlaps(spr) && hoveringSomething && spr.ID == curSelected)
                        hoveringSomething = false;
                });

            sectionButtons.forEach(function(spr:FlxSprite)
                {
                    if (!hoveringSomething && FlxG.mouse.overlaps(spr))
                    {
                        hoveringButton = true;
                        if (spr.ID == 1)
                            {
                                if (FlxG.mouse.justPressed && hoveringButton)
                                    {
                                        FlxG.sound.play(Paths.sound('scrollMenu'));
                                        changeSection(-1);
                                    }
                            }
                        if (spr.ID == 2)
                            {
                                if (FlxG.mouse.justPressed && hoveringButton)
                                    {
                                        FlxG.sound.play(Paths.sound('scrollMenu'));
                                        changeSection(1);
                                    }
                            }

                        repositionSelected();
                        updateShader();
                    }
                    if (!FlxG.mouse.overlaps(spr) && hoveringSomething && spr.ID == curSelected)
                        {
                            hoveringButton = false;
                        }    
                });
        }

    //for to make the character turn
	function charRotation1() {
        for (i in 0...pumpGroup.length) {
		    FlxTween.angle(pumpGroup.members[i], 4, -4, 5, {
		    	ease: FlxEase.sineInOut,
	    		type: FlxTweenType.PINGPONG
		    });
        }
	}	

    //for character sprites to move in
	function charTransitionIn() {
		FlxTween.cancelTweensOf(pumpGroup.members[2]);
		FlxTween.tween(pumpGroup.members[2], {x: 800, y: 0}, 0.1, {
			ease: FlxEase.linear,
			onComplete: function(twn:FlxTween)
			{
                charColorTransitionIn();
				FlxTween.tween(pumpGroup.members[2], {alpha: 1}, 0.1, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(pumpGroup.members[2], {x: 380, y: -50}, 0.8, {
                        ease: FlxEase.cubeOut
						});
					}
				});
			}
		});
	}

    function charTransitionOut() {
		FlxTween.cancelTweensOf(pumpGroup.members[2]);
        FlxTween.tween(pumpGroup.members[2], {x: 1600, y: 0}, 0.74, {
            ease: FlxEase.cubeIn,
            onComplete: function(twn:FlxTween)
            {
                FlxTween.tween(pumpGroup.members[2], {alpha: 0}, 0.1, {
                ease: FlxEase.linear,
                });
            }
        });
    }
	
	//for character colorshadows to move in
	function charColorTransitionIn() {
		FlxTween.cancelTweensOf(pumpGroup.members[1]);
		FlxTween.tween(pumpGroup.members[1], {x: 800, y: 0}, 0.1, {
			ease: FlxEase.linear,
			onComplete: function(twn:FlxTween)
			{
                charBlackTransitionIn();
				FlxTween.tween(pumpGroup.members[1], {alpha: 1}, 0.15, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(pumpGroup.members[1], {x: 390, y: -50}, 0.8, {
						    ease: FlxEase.cubeOut,
						});
					}
				});
			}	
        });
	}

    function charColorTransitionOut() {
        FlxTween.cancelTweensOf(pumpGroup.members[1]);
		FlxTween.tween(pumpGroup.members[1], {x: 1600, y: 0}, 0.75, {
	    	ease: FlxEase.cubeIn,
			onComplete: function(twn:FlxTween)
			{
				FlxTween.tween(pumpGroup.members[1], {alpha: 0}, 0.1, {
				ease: FlxEase.linear,
				});
			}
		});
    }
	
	//for character trueshadows to move in
	function charBlackTransitionIn() {
		FlxTween.cancelTweensOf(pumpGroup.members[0]);
		FlxTween.tween(pumpGroup.members[0], {x: 800, y: 0}, 0.1, {
		    ease: FlxEase.linear,
		    onComplete: function(twn:FlxTween)
	    	{
                charRotation1();
			    FlxTween.tween(pumpGroup.members[0], {alpha: 1}, 0.2, {
		    		ease: FlxEase.linear,
	    			onComplete: function(twn:FlxTween)
				    {
			    		FlxTween.tween(pumpGroup.members[0], {x: 400, y: -50}, 0.8, {
		    			    ease: FlxEase.cubeOut
					    });
				    }
			    });
		    }
	    });
    }

    function charBlackTransitionOut() {
        FlxTween.cancelTweensOf(pumpGroup.members[0]);
		FlxTween.tween(pumpGroup.members[0], {x: 1600, y: 0}, 0.76, {
			ease: FlxEase.cubeIn,
			onComplete: function(twn:FlxTween)
			{
				FlxTween.tween(pumpGroup.members[0], {alpha: 0}, 0.1, {
				ease: FlxEase.linear
				});
			}
		});
    }

    override function beatHit() {
        super.beatHit();
        trace('beat');


        // for (i in 0...pumpGroup.length) {
        //     FlxTween.tween(pumpGroup.members[i].scale, {x: 1.02, y: 1.02}, 0.025, {
        //         ease: FlxEase.linear,
        //         onComplete: function(twn:FlxTween)
        //         {
        //             FlxTween.tween(pumpGroup.members[i].scale, {x: 1, y: 1}, 0.3, {
        //             ease: FlxEase.quadOut
        //             });
        //         }
        //     });		
        // }
    }
}