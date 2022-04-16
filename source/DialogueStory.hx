package; // UNFINISHED -zack PLEASE DONT CHANGE ANYTHING :(

// import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flash.media.Sound;
import flixel.addons.text.*;
import openfl.display3D.Context3DProgramType;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxSpriteGroup;
#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxSprite;

using StringTools;
using Math;

class DialogueStory extends FlxSpriteGroup {
    public var isBf:Bool = false;
    public var isP2:Bool = false;
    public var isC:Bool = false;
    public var cPort:FlxSprite;
    public var cbox:FlxSprite;
    public var txtFile:String = "";
    public var diaLines:Array<String> = [];
    public var xBoxbf:Float = 0;
    public var xP2:Float = 0;
    public var pastXp2:Float = 0;
    public var xBF:Float = 0;
    public var xBoxp2:Float = 0;
    public var Callback:Dynamic;
    public var sweatP2:FlxSprite; // I hate everything.
    //EX: bf:excited:hi i cucked your mother 
    // p2:idfk:NOOOOOOOOOOOOOOO. 
    public var portBf:FlxSprite;
    public var portP2:FlxSprite;
    public var mode:String = "";
    public var enterBool:Bool = false;
    public var linesInt:Int = 0;
    public var curLine:Int = 0;
    public var diaText:FlxCustomTypeText; //The text itself.
    public var dia2Text:FlxCustomTypeText;
    public var cdiaText:FlxCustomTypeText;
    public var xDiaBf:Float = 0;
    public var xDiaP2:Float = 0;
    public var muted:Bool = false;
    public var indicTxt:FlxText;
    public var countdown:FlxText;
    public var cntdwnBlack:FlxSprite;
    public var txtGrp:FlxTypedGroup<FlxTypeText>;
    public var boxGrp:FlxSpriteGroup;
    public var bullcrap:Bool = false;
    public var pastXBf:Float = 0;

    //fuck you guy who didnt add the glasses to the dialogue portraitd >:((((((((
    public var p2Char:FlxSprite;
    public var bfChar:FlxSprite;
    
    public var diaSounds:FlxSound;

    public function new(?mode:String = "week1") {   
        super();
        diaSounds = new FlxSound();

        FlxG.sound.playMusic(Paths.music("Quit_Your_Yapping_3","shared"), 0, true);
        if (PlayState.SONG.song.toLowerCase() != "checkpoint" && PlayState.SONG.song.toLowerCase() != "homestretch")
            FlxG.sound.music.fadeIn(1.5, 0, 0.5);

        // init the dialogue.
        this.mode = mode;

        if (FileSystem.exists("assets/data/" + PlayState.SONG.song.toLowerCase() + "/dialogue.txt"))
            txtFile = File.getContent("assets/data/" + PlayState.SONG.song.toLowerCase() + "/dialogue.txt");
        else // warns you incase ya forgot the dialogue text file.
            FlxG.stage.window.alert("DIALOGUE FILE MISSING", "DialogueStory.hx");

        diaLines = txtFile.split("/");
        linesInt = diaLines.length;

        //create the groups for layering
        // txtGrp = new FlxTypedGroup<FlxTypeText>();
        boxGrp = new FlxSpriteGroup();
        //add(txtGrp);

        // Create the box 
        
        var bfbox = new FlxSprite();
        bfbox.frames = Paths.getSparrowAtlas("dialogue/bfTextBox", "shared");
        if (mode == 'week1')
            bfbox.scale.set(0.65,0.65);
        else
            bfbox.scale.set(0.7,0.7);
        bfbox.screenCenter();
        bfbox.y += 100;
        if (mode == "week1")
            bfbox.x += 800; // 700
        else
            bfbox.x -= 550; // 700
        bfbox.antialiasing = ClientPrefs.globalAntialiasing;
        bfbox.animation.addByPrefix("idle", "Boyfriend Text Box", 14, true);
        bfbox.animation.play("idle");
        boxGrp.add(bfbox);
        bfbox.alpha = 0.0001;

        var p2box = new FlxSprite();
        p2box.frames = Paths.getSparrowAtlas("dialogue/voltzTextBox", "shared");
        p2box.scale.set(0.6,0.6);
        p2box.screenCenter();
        p2box.y += 100;
        if (mode == "week1")
            p2box.x -= 800; // 700
        else
            p2box.x += 600; // 700
        p2box.antialiasing = ClientPrefs.globalAntialiasing;
        p2box.animation.addByPrefix("idle", "Voltz Text Box  instance 1", 14, true);
        p2box.animation.play("idle");
        boxGrp.add(p2box);
        p2box.alpha = 0.0001;

        if (PlayState.SONG.song.toLowerCase() == "checkpoint"  || PlayState.SONG.song.toLowerCase() == "heavyswing") {
            // cBox = new FlxSprite();
            cbox = new FlxSprite(70, 370);
    		cbox.frames = Paths.getSparrowAtlas('speech_bubble');
            cbox.y -= 100;
	    	cbox.scrollFactor.set();
    		cbox.antialiasing = ClientPrefs.globalAntialiasing;
		    cbox.animation.addByPrefix('angry', 'AHH speech bubble', 24);
    		cbox.animation.addByPrefix('angryOpen', 'speech bubble loud open', 24, false);
    		cbox.animation.addByPrefix('center-angry', 'AHH Speech Bubble middle', 24);
	    	cbox.animation.addByPrefix('center-angryOpen', 'speech bubble Middle loud open', 24, false);
		    cbox.animation.play('angry', true);
    		// cbox.visible = false;
	    	cbox.setGraphicSize(Std.int(cbox.width * 0.9));
		    cbox.updateHitbox();
            cbox.alpha = 0.0001;
            add(cbox);
        }
        if (PlayState.SONG.song.toLowerCase() == "checkpoint" || PlayState.SONG.song.toLowerCase() == "heavyswing" ) {
            cPort = new FlxSprite();
            if ( PlayState.SONG.song.toLowerCase() == "heavyswing") {
                cPort.loadGraphic(Paths.image("dialogue/stock/unnamed_8","shared"));
                cPort.scale.set(3,3);
                cPort.screenCenter();
                add(cPort);
                cPort.alpha = 0.0001;
            }
        }
        boxGrp.cameras = [PlayState.instance.camOther];
        PlayState.instance.add(boxGrp);

        // then the txt sprite
        if (PlayState.SONG.song.toLowerCase() == "checkpoint" ||PlayState.SONG.song.toLowerCase() == "heavyswing") {
            cdiaText = new FlxCustomTypeText(0,0,750,"",28);
            cdiaText.screenCenter();
            cdiaText.y += 100;
            cdiaText.font = Paths.font("Microgramma D Extended Bold.otf");
            cdiaText.color = FlxColor.BLACK;
            // cdiaText.sounds = [FlxG.sound.load(Paths.sound('pixelText','week6'), 0.6)];
            add(cdiaText);
            cdiaText.alpha = 0.0001;
        }
        diaText = new FlxCustomTypeText(0,0,750,"",28);
        diaText.screenCenter();
        if (mode == "week1")
            diaText.x -= 800; // 700
        else
            diaText.x -= 520; // 700
        diaText.y += 40;
        //diaText.autoSize = false;
        //diaText.alignment = LEFT;
        // diaText.
        diaText.font = Paths.font("Microgramma D Extended Bold.otf");
        
        diaText.color = FlxColor.BLACK;
        diaText.sounds = [FlxG.sound.load(Paths.sound('pixelText','week6'), 0.6)];
        add(diaText);
        diaText.alpha = 0.0001;

        dia2Text = new FlxCustomTypeText(0,0,750,"",28);
        dia2Text.screenCenter();
        if (mode == "week1")
            dia2Text.x += 800; // 700
        else
            dia2Text.x += 580;
        dia2Text.y += 40;
        dia2Text.font = Paths.font("Microgramma D Extended Bold.otf");
        dia2Text.color = FlxColor.WHITE;
        // diaText.sounds = [FlxG.sound.load(Paths.sound('pixelText','week6'), 0.6)];
        add(dia2Text);
        dia2Text.alpha = 0.0001;

        // then the portraits.

        if (PlayState.SONG.song.toLowerCase() == "homestretch") {
            p2Char = new FlxSprite();
            p2Char.frames = Paths.getSparrowAtlas("characters/PlayableVolt");
            p2Char.scale.set(1.1,1.1);
            p2Char.animation.addByPrefix("fuckyou","Voltz Playable Idle0",24,false);
            p2Char.screenCenter();
            p2Char.x += 180;
            p2Char.y += 80;
            add(p2Char);
            p2Char.alpha = 0.0001;
            p2Char.flipX = true;

            bfChar = new FlxSprite();
            bfChar.frames = Paths.getSparrowAtlas("characters/BoyFriendHOMESTRETCH");
            bfChar.scale.set(1.2,1.2);
            bfChar.animation.addByPrefix("fuckyou", "BF idle dance0",24,false);
            bfChar.screenCenter();
            bfChar.x -= 650;
            bfChar.y += 100;
            add(bfChar);
            bfChar.alpha = 0.0001;
            bfChar.flipX = true;
        }
        
        portBf = new FlxSprite();
        portBf.frames = Paths.getSparrowAtlas("dialogue/voltzBFPortraits", "shared");
        portBf.scale.set(1.2,1.2);
        portBf.screenCenter();
        if (mode == "week1")
            portBf.x += 600; // 200
        else
            portBf.x -= 650;
        portBf.y += 120;
        portBf.antialiasing = ClientPrefs.globalAntialiasing;
        portBf.animation.addByPrefix("idle", "BF port 10", 24, false);
        portBf.animation.addByPrefix("ehh", "BF port 20", 24, false);
        portBf.animation.addByPrefix("excited", "BF port 30", 24, false);
        portBf.animation.addByPrefix("mybad", "BF port 40", 24, false);
        portBf.animation.addByPrefix("._.", "BF port 50", 24, false);
        portBf.animation.addByPrefix("ehh2", "BF port 60", 24, false);
        portBf.animation.addByPrefix("confused", "BF port 70", 24, false);
        portBf.animation.addByPrefix("troll", "BF port 80", 24, false);
        portBf.animation.addByPrefix("ew", "BF port ew", 24, false); //this isnt ew???
        portBf.animation.addByPrefix("sigh", "BF port sigh", 24, false);
        portBf.animation.addByPrefix("smug1", "BF smug 10", 24, false);
        portBf.animation.addByPrefix("smug2", "BF smug 20", 24, false);
        portBf.animation.play("idle", true);
        add(portBf);
        portBf.alpha = 0.0001; //avoids lag spikes when bf appears.

        portP2 = new FlxSprite(); // 13 animations
        portP2.frames = Paths.getSparrowAtlas("dialogue/voltzPorts", "shared");
        //if (mode == "week2")
            portP2.scale.set(1.1,1.1);
        portP2.screenCenter();
        if (mode == "week1")
            portP2.x -= 480; // 200
        else
            portP2.x += 600;
        
        portP2.y += 100;
        portP2.antialiasing = ClientPrefs.globalAntialiasing; // FLIPPED IS NOT FLIPPED AND NOT FLIPPED IS FLIPPED, FUCK WHOEVER MADE THE FLA SYMBOLS. /j
        portP2.animation.addByPrefix("ehh","Voltz port 1 flipped0",24,false);
        portP2.animation.addByPrefix("seriously?","voltz port 2 flipped0",24,false);
        portP2.animation.addByPrefix("facepalm","Voltz port 3 flipped0",24,false);
        portP2.animation.addByPrefix("what","Voltz port 4 flipped0",24,false); // +200
        portP2.animation.addByPrefix("shrug","Voltz port 5 flipped0",24,false);
        portP2.animation.addByPrefix("yeah","Voltz port 6 flipped0",24,false); // +250
        portP2.animation.addByPrefix("ohyeah?","voltz port 7 flipped0",24,false);
        portP2.animation.addByPrefix("fingersnap","Voltz port 8 flipped0",24,false); // +200
        portP2.animation.addByPrefix("mybad-flipped","Voltz port nine0",24,false); // +200
        portP2.animation.addByPrefix("pointback","Voltz port 10 flipped0",24,false); // +200
        portP2.animation.addByPrefix("shock","Voltz port 11 flipped0",24,false); // +200
        portP2.animation.addByPrefix("legit?","Voltz port 12 flipped0",24,false); // +200
        portP2.animation.addByPrefix("thumbsup","Voltz port 13 flipped0",24,false); // +200

        portP2.animation.addByPrefix("ehh-flipped","Voltz port one0",24,false);
        portP2.animation.addByPrefix("seriously?-flipped","voltz port two0",24,false);
        portP2.animation.addByPrefix("facepalm-flipped","Voltz port 30",24,false);
        portP2.animation.addByPrefix("what-flipped","Voltz port 40",24,false); // +200
        portP2.animation.addByPrefix("shrug-flipped","Voltz port 50",24,false);
        portP2.animation.addByPrefix("yeah-flipped","Voltz port 60",24,false); // +250
        portP2.animation.addByPrefix("ohyeah?-flipped","voltz port 70",24,false);
        portP2.animation.addByPrefix("fingersnap-flipped","Voltz port 80",24,false); // +200
        portP2.animation.addByPrefix("mybad","Voltz port 9 flipped0",24,false); // +200
        portP2.animation.addByPrefix("pointback-flipped","Voltz port 100",24,false); // +200
        portP2.animation.addByPrefix("shock-flipped","Voltz port 110",24,false); // +200
        portP2.animation.addByPrefix("legit?-flipped","Voltz port 120",24,false); // +200
        portP2.animation.addByPrefix("thumbsup-flipped","Voltz port 130",24,false); // +200
        add(portP2);
        portP2.alpha = 0.0001;

        sweatP2 = new FlxSprite();
        sweatP2.frames = Paths.getSparrowAtlas("dialogue/voltz_sweat","shared");
        sweatP2.screenCenter();
        sweatP2.x -= 480; // 200
        sweatP2.y += 100;
        sweatP2.animation.addByPrefix("mybad", "Voltz port 9 flipped0",24,false);
        add(sweatP2);
        sweatP2.alpha = 0.0001;

        //the indication text.
        indicTxt = new FlxText(0,0,0,"",24);
        indicTxt.setFormat(Paths.font("microgramma.otf"),24,FlxColor.WHITE,null,OUTLINE,FlxColor.BLACK);
        indicTxt.text = "HOLD SHIFT TO SKIP. | PRESS M TO MUTE VOICELINES.\n";
        add(indicTxt);
        indicTxt.alpha = 0.0001;
        new FlxTimer().start(1.25, function (tmr:FlxTimer) {
            FlxTween.tween(indicTxt, {alpha: 1}, 1, {ease: FlxEase.smoothStepIn});
            tmr.destroy();
        });

        //the countdown shit
        cntdwnBlack = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        cntdwnBlack.alpha = 0.0001;
        add(cntdwnBlack);

        //its text
        countdown = new FlxText(0,0,0,"3",42);
        countdown.setFormat(Paths.font("microgramma.otf"),42,FlxColor.WHITE,null,OUTLINE,FlxColor.BLACK);
        countdown.screenCenter();
        add(countdown);
        countdown.alpha = 0.0001;

        // trace(Std.int(FlxG.width * 0.5));
        // trace(Std.int(FlxG.width * 0.6));

        xP2 = portP2.x;
        xBF = portBf.x;
        xBoxbf = bfbox.x;
        xBoxp2 = p2box.x;
        pastXp2 = portP2.x;
        xDiaBf = diaText.x;
        xDiaP2 = dia2Text.x;
        pastXBf = portBf.x;

        if (mode == "week2") {
            portBf.flipX = true;
            portP2.flipX = true;
        }

        startDialogue();
    }

    public var triggeredSkip:Bool = false;

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (bullcrap)
            indicTxt.alpha = 0;

        boxGrp.y = this.y;
        boxGrp.x = this.x;
        boxGrp.alpha = this.alpha;

        // if (diaLines != []) {
        //     if (diaLines[0].charAt(diaText.curLeng) == " " && diaLines[0].charAt(diaText.curLeng + 1) == " ") {
        //         diaText.delay = 0.01;
        //         diaText.sounds = [];
        //         trace(diaText.curLeng);
        //     } else {
        //         if (diaText.delay != 0.04) {
        //             diaText.delay = 0.04;
        //             diaText.sounds = [FlxG.sound.load(Paths.sound('pixelText','week6'), 0.6)];
        //             trace(diaText.curLeng);
        //         }
        //     }
        // }

        if (FlxG.keys.justPressed.ENTER) {
            if (enterBool)  {
                diaLines = [];
                nextDialogue();
			    FlxG.sound.play(Paths.sound('clickText','shared'), 0.7);
            } else {
                dia2Text.skip();
                diaText.skip();
                if (PlayState.SONG.song.toLowerCase() == "checkpoint")
                    cdiaText.skip();
            }
        }
        if (FlxG.keys.justPressed.M) {
            muted = !muted;
			FlxG.sound.play(Paths.sound('boo','shared'), 0.7);
            if (muted)
                indicTxt.text = "HOLD SHIFT TO SKIP. | PRESS M TO UNMUTE VOICELINES.\n";
            else
                indicTxt.text = "HOLD SHIFT TO SKIP. | PRESS M TO MUTE VOICELINES.\n";
        }
        if (FlxG.keys.pressed.SHIFT) {
            if (!triggeredSkip)
                openSkip();
        }

    }

    public function openSkip() {
        var loopies:Int = 0;
        triggeredSkip = true;
        FlxTween.tween(cntdwnBlack, {alpha: 0.45}, 0.25, {ease: FlxEase.cubeInOut});
        FlxTween.tween(countdown, {alpha: 0.75}, 0.25, {ease: FlxEase.cubeInOut});
        new FlxTimer().start(0, function (tmr:FlxTimer) {
            if (FlxG.keys.pressed.SHIFT) {
                tmr.reset(1);
                loopies++;
                var shit = loopies - 1;
                countdown.text = Std.string(shit - 3).replace("-","");
                if (loopies == 4) {
                    killYourself();
                }
            } else {
                countdown.text = "3";
                loopies = 0;
                triggeredSkip = false;
                FlxTween.tween(cntdwnBlack, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeInOut});
                FlxTween.tween(countdown, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeInOut});
            }
        });
    }

    public var bfLines:Array<String> = [];
    public var p2Lines:Array<String> = [];
    public var cLines:Array<String> = [];

    public function startDialogue() {
        
        //more organized for my liking.
        for (i in 0...diaLines.length) {
            if (diaLines[i].toLowerCase().contains("bf:"))
                bfLines.push(diaLines[i] + ":" + i + ":");
            if (diaLines[i].toLowerCase().contains("p2:"))
                p2Lines.push(diaLines[i] + ":" + i + ":");
            if (diaLines[i].toLowerCase().contains("crowd:"))
                cLines.push(diaLines[i] + ":" + i + ":");
        }

        //since we've done that. diaLines is USELESS, so we are gonna reuse it for nextDialogue();
        diaLines = [];

        //do the first line and its port
        for (i in 0...bfLines.length) {
            if (bfLines[i].contains(":" + curLine + ":")) {
                var formattedLines = bfLines[i].split(":");
                diaLines.push(formattedLines[2]);
                getCurPort("bf");
                isBf = true;
            }
        }

        for (i in 0...p2Lines.length) {
            if (p2Lines[i].contains(":" + curLine + ":")) {
                var formattedLines = p2Lines[i].split(":");
                diaLines.push(formattedLines[2]);
                diaLines.push(p2Lines[i]);
                getCurPort("p2");
                isP2 = true;
            }
        }

        for (i in 0...cLines.length) {
            if (cLines[i].contains(":" + curLine + ":")) {
                var formattedLines = cLines[i].split(":");
                diaLines.push(formattedLines[2]);
                diaLines.push(cLines[i]);
                getCurPort("crowd");
                isC = true;
            }
        }
        var uhhh = curLine + 1;
        var delay:Float = 0;

        if (isBf || isC || isP2) {
            delay = 0.2;
        }

        new FlxTimer().start(delay, function (tmr:FlxTimer) {
            if (!muted) {
                diaSounds.loadEmbedded(Paths.sound("dialogue/" + PlayState.SONG.song + "/" + uhhh, "shared"), false, true).play(true);
                // FlxG.sound.play(Paths.sound("dialogue/" + PlayState.SONG.song + "/" + uhhh, "shared"), 0.8, false, null, true);
            }
            tmr.destroy();
        });
        // uhhh traces
        // trace(diaLines.toString());
        // trace(p2Lines.toString());
        // trace(bfLines.toString());
        // trace(txtFile);
        
        enterBool = false;
        diaText.resetText(diaLines[0]);
        diaText.start(0.04, true);
        diaText.completeCallback = function() {
			new FlxTimer().start(0.26, function (tmr:FlxTimer) {
                enterBool = true;
            });
            // diaLines = [];
            var thingyLines:Array<String> = [];

            for (i in 0...bfLines.length) {
                if (bfLines[i].contains(":" + curLine + ":")) {
                    var formattedLines = bfLines[i].split(":");
                    thingyLines.push(formattedLines[1]);
                    if (thingyLines[0].contains("-loop")) {
                        var animationLine:Array<String> = thingyLines[0].split("-");
                        portBf.animation.play(animationLine[0], true);
                    }
                }
            }
    
            for (i in 0...p2Lines.length) {
                if (p2Lines[i].contains(":" + curLine + ":")) {
                    var formattedLines = p2Lines[i].split(":");
                    thingyLines.push(formattedLines[1]);
                    if (thingyLines[0].contains("-loop")) {
                        var animationLine:Array<String> = thingyLines[0].split("-");
                        portP2.animation.play(animationLine[0], true);
                    }
                }
            } 
		};
        dia2Text.resetText(diaLines[0]);
        dia2Text.start(0.04, true);
    }

    public var delayed:Bool = false;

    public function nextDialogue() {
        // new FlxTimer().start(1, function (tmr:FlxTimer) {
            // FlxG.sound.pause();
            // FlxG.sound.music.resume();
        // });
		// FlxG.sound.play(Paths.sound('clickText','week6'), 0.7);	
        if (diaSounds.playing)
            diaSounds.stop();

        curLine++;

        for (i in 0...bfLines.length) {
            if (bfLines[i].contains(":" + curLine + ":")) {
                var formattedLines = bfLines[i].split(":");
                diaLines.push(formattedLines[2]);
                getCurPort("bf");
                isBf = true;
            }
        }

        for (i in 0...p2Lines.length) {
            if (p2Lines[i].contains(":" + curLine + ":")) {
                var formattedLines = p2Lines[i].split(":");
                diaLines.push(formattedLines[2]);
                getCurPort("p2");
                // isP2 = true;
            }
        }

        for (i in 0...cLines.length) {
            if (cLines[i].contains(":" + curLine + ":")) {
                var formattedLines = cLines[i].split(":");
                diaLines.push(formattedLines[2]);
                diaLines.push(cLines[i]);
                getCurPort("crowd");
                // isC = true;
            }
        }
        

        enterBool = false;
        if (curLine != linesInt) {
            var uhhh = curLine + 1;
            var delay:Float = 0;

            if (delayed) {
                delay = 0.2;
                delayed = false;
            }

            new FlxTimer().start(delay, function (tmr:FlxTimer) {
                if (!muted)
                    diaSounds.loadEmbedded(Paths.sound("dialogue/" + PlayState.SONG.song + "/" + uhhh, "shared"), false, true).play(true);
                tmr.destroy();
            });
            diaText.resetText(diaLines[0]);
            diaText.start(0.04, true);
            diaText.completeCallback = function() {
                new FlxTimer().start(0.26, function (tmr:FlxTimer) {
                    enterBool = true;
                });
                // enterBool = true;
                // diaLines = [];
                var thingyLines:Array<String> = [];
    
                for (i in 0...bfLines.length) {
                    if (bfLines[i].contains(":" + curLine + ":")) {
                        var formattedLines = bfLines[i].split(":");
                        thingyLines.push(formattedLines[1]);
                        if (thingyLines[0].contains("-loop")) {
                            var animationLine:Array<String> = thingyLines[0].split("-");
                            portBf.animation.play(animationLine[0], true);
                        }
                    }
                }
        
                for (i in 0...p2Lines.length) {
                    if (p2Lines[i].contains(":" + curLine + ":")) {
                        var formattedLines = p2Lines[i].split(":");
                        thingyLines.push(formattedLines[1]);
                        if (thingyLines[0].contains("-loop")) {
                            var animationLine:Array<String> = thingyLines[0].split("-");
                            portP2.animation.play(animationLine[0], true);
                        }
                    }
                } 
            };
            dia2Text.resetText(diaLines[0]);
            dia2Text.start(0.04, true);
            if (PlayState.SONG.song.toLowerCase() == "checkpoint") {
                cdiaText.resetText(diaLines[0]);
                cdiaText.start(0.04, true);
            }
        } else {
            // FlxG.sound.music.fadeOut(0.7, 0);
            killYourself();
        }
    }

    public var isPlaying:Bool = false;

    public function killYourself() {
        // bfbox.destroy();
        // p2box.destroy();
        // portBf.destroy();
        // portP2.destroy();
        // diaText.destroy();
        // FlxG.sound.destroy();
        // FlxG.sound.pause();
        diaSounds.stop();
        
        FlxG.sound.music.resume();
        FlxG.sound.music.fadeOut(0.7, 0);
        FlxTween.tween(indicTxt, {alpha: 0}, 0.25, {ease: FlxEase.cubeInOut, onComplete: function (twn:FlxTween){
            bullcrap = true;
            indicTxt.alpha = 0;
            twn.destroy();
        }});

        
        // trace(PlayState.SONG.song.toLowerCase());

        if (Callback != null) {
            if (PlayState.SONG.song.toLowerCase() == "checkpoint") {
                if (!isPlaying) {
                    isPlaying = true;
                    Callback(true);
                    new FlxTimer().start(2.66, function (tmr:FlxTimer){
                        for (i in 0...boxGrp.length) {
                            boxGrp.members[i].destroy();// kills the boxes to free space ig.
                        }
                        PlayState.instance.remove(boxGrp);
                        //Paths.clearUnusedMemory();
                    });
                }
            } else {
                new FlxTimer().start(0.26, function (tmr:FlxTimer) {
                    Callback(false);
                });
                new FlxTimer().start(1.16, function (tmr:FlxTimer){
                    for (i in 0...boxGrp.length) {
                        boxGrp.members[i].destroy();// kills the boxes to free space ig.
                    }
                    PlayState.instance.remove(boxGrp);
                    if (PlayState.SONG.song.toLowerCase() != "homestretch")
                        Paths.clearUnusedMemory();
                });
            }
        }

        // destroy();
        // PlayState.endStoryDia();
    }

    public function getCurPort(char:String) {
        var splittedLines:Array<String> = [];
        switch (char) {
            case "bf":
                isC = false;
                isP2 = false;

                for (i in 0...bfLines.length) {
                    if (bfLines[i].contains(":" + curLine + ":")) {
                        var formattedLines = bfLines[i].split(":");
                        splittedLines.push(formattedLines[1]);
                        splittedLines.push(formattedLines[3]);
                        splittedLines.push(formattedLines[2]);
                        // getCurPort("bf");
                    }
                }
                setOffset(splittedLines[0]);

                if (boxGrp.members[0].alpha != 1) {
                    switch (mode) {
                        case "week1":
                            FlxTween.tween(portBf, {alpha: 1, x: xBF - 200}, 0.25, {ease:  FlxEase.cubeIn});

                            //if (splittedLines[0] == " I  don't  know  how  long  we're  gonna  be  stuck  here  but  we  might  as  well  have  some  fun. ")
                            FlxTween.tween(diaText, {alpha: 1, x: xDiaBf + 700}, 0.2, {ease:  FlxEase.cubeIn});
                            //else
                                //FlxTween.tween(diaText, {alpha: 1, x: xDiaBf + 700}, 0.2, {ease:  FlxEase.cubeIn});

                            FlxTween.tween(boxGrp.members[0], {alpha: 1, x: xBoxbf - 900}, 0.25, {ease:  FlxEase.cubeIn});
                            if (boxGrp.members[1].alpha == 1) {
                                FlxTween.tween(boxGrp.members[1], {alpha: 0.0001, x: xBoxp2 - 900}, 0.25, {ease:  FlxEase.cubeOut});
                                FlxTween.tween(portP2, {alpha: 0.0001, x: xP2 - 100}, 0.25, {ease:  FlxEase.cubeOut});
                                FlxTween.tween(sweatP2, {alpha: 0.0001, x: xP2 - 100}, 0.25, {ease:  FlxEase.cubeOut});
                                FlxTween.tween(dia2Text, {alpha: 0.0001, x: xDiaP2 + 700}, 0.2, {ease:  FlxEase.cubeOut});
                            }
                            if (cbox != null) {
                                if (cbox.alpha == 1) {
                                    remove(cPort);
                                    FlxTween.tween(cbox, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn, onComplete: function (twn:FlxTween) {
                                        remove(cdiaText);
                                        remove(cbox);
                                    }});
                                    FlxTween.tween(cdiaText, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn});
                                }
                            }
                        case "week2":
                            if (splittedLines[0] != "fuckyou")
                                FlxTween.tween(portBf, {alpha: 1, x: xBF + 200}, 0.25, {ease:  FlxEase.cubeIn});
                            else
                                FlxTween.tween(bfChar, {alpha: 1, x: xBF + 200}, 0.25, {ease:  FlxEase.cubeIn});

                            //if (splittedLines[0] == " I  don't  know  how  long  we're  gonna  be  stuck  here  but  we  might  as  well  have  some  fun. ")
                            FlxTween.tween(diaText, {alpha: 1, x: xDiaBf + 700}, 0.2, {ease:  FlxEase.cubeIn});
                            //else
                                //FlxTween.tween(diaText, {alpha: 1, x: xDiaBf + 700}, 0.2, {ease:  FlxEase.cubeIn});

                            FlxTween.tween(boxGrp.members[0], {alpha: 1, x: xBoxbf + 700}, 0.25, {ease:  FlxEase.cubeIn});
                            if (boxGrp.members[1].alpha == 1) {
                                FlxTween.tween(boxGrp.members[1], {alpha: 0.0001, x: xBoxp2 + 700}, 0.25, {ease:  FlxEase.cubeOut});
                                FlxTween.tween(portP2, {alpha: 0.0001, x: xP2 + 100}, 0.25, {ease:  FlxEase.cubeOut});
                                if (p2Char != null)
                                    FlxTween.tween(p2Char, {alpha: 0.0001, x: xP2 + 100}, 0.25, {ease:  FlxEase.cubeOut});
                                FlxTween.tween(dia2Text, {alpha: 0.0001, x: xDiaP2 + 700}, 0.2, {ease:  FlxEase.cubeOut});
                            }
                            if (cbox != null) {
                                if (cbox.alpha == 1) {
                                    remove(cPort);
                                    FlxTween.tween(cbox, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn, onComplete: function (twn:FlxTween) {
                                        remove(cdiaText);
                                        remove(cbox);
                                    }});
                                    FlxTween.tween(cdiaText, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn});
                                }
                            }       
                    }
                } else {
                    if (mode == "week1")
                        portBf.x = xBF - 200;
                    else
                        portBf.x = xBF + 200;

                    if (splittedLines[2] == " I  don't  know  how  long  we're  gonna  be  stuck  here  but  we  might  as  well  have  some  fun. ") {
                        diaText.x -= 40;
                    } else {
                        diaText.x = xDiaBf + 700;
                    }
                }

                diaText.width = Std.parseInt(splittedLines[1]);
                var delay:Float = 0;
                if (!isBf) {
                    delay = 0.2;
                    delayed = true;
                    isBf = true;
                }
                new FlxTimer().start(delay, function(tmr:FlxTimer) {
                    if (splittedLines[0] != "fuckyou")
                        portBf.animation.play(splittedLines[0], true);
                    else 
                        bfChar.animation.play("fuckyou", true);
                });
                //trace(splittedLines.toString());
                //portBf.alpha = 1;
                //portP2.alpha = 0.0001;
            case "p2":
                isBf = false;
                isC = false;
                for (i in 0...p2Lines.length) {
                    if (p2Lines[i].contains(":" + curLine + ":")) {
                        var formattedLines = p2Lines[i].split(":");
                        splittedLines.push(formattedLines[1]);
                        splittedLines.push(formattedLines[3]);
                        // getCurPort("bf");
                    }
                }
                dia2Text.width = Std.parseInt(splittedLines[1]);
                setOffset(splittedLines[0]);

                if (boxGrp.members[1].alpha != 1) {
                    switch (mode) {
                        case "week1":
                            FlxTween.tween(dia2Text, {alpha: 1, x: xDiaP2 - 700}, 0.2, {ease: FlxEase.cubeIn});
                            if (splittedLines[0] == "mybad")
                                FlxTween.tween(sweatP2, {alpha: 1, x: xP2 + 100}, 0.25, {ease:  FlxEase.cubeIn});
                            else
                                FlxTween.tween(portP2, {alpha: 1, x: xP2 + 100}, 0.25, {ease: FlxEase.cubeIn});
                            FlxTween.tween(boxGrp.members[1], {alpha: 1, x: xBoxp2 + 900}, 0.25, {ease: FlxEase.cubeIn});
                            if (portBf.alpha == 1) {
                                FlxTween.tween(diaText, {alpha: 0.0001, x: xDiaBf - 700}, 0.1, {ease: FlxEase.circOut});
                                FlxTween.tween(boxGrp.members[0], {alpha: 0.0001, x: xBoxbf + 900}, 0.25, {ease:  FlxEase.cubeOut});
                                FlxTween.tween(portBf, {alpha: 0.0001, x: xBF + 200}, 0.25, {ease:  FlxEase.cubeOut});

                            }
                            if (cbox != null) {
                                if (cbox.alpha == 1) {
                                    remove(cPort);
                                    FlxTween.tween(cbox, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn, onComplete: function (twn:FlxTween) {
                                    remove(cdiaText);
                                    remove(cbox);
                                }});
                                FlxTween.tween(cdiaText, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn});
                                }
                            }
                        case "week2":
                            FlxTween.tween(dia2Text, {alpha: 1, x: xDiaP2 - 700}, 0.2, {ease: FlxEase.cubeIn});
                            if (splittedLines[0] != "fuckyou")
                                FlxTween.tween(portP2, {alpha: 1, x: xP2 - 100}, 0.25, {ease: FlxEase.cubeIn});
                            else {
                                FlxTween.tween(p2Char, {alpha: 1, x: xP2 - 100}, 0.25, {ease: FlxEase.cubeIn});
                                PlayState.instance.camGame.flash(FlxColor.WHITE, 0.65, null, true);
                                PlayState.instance.camOther.shake(0.06, 0.25, null, true);
                                PlayState.instance.remove(PlayState.instance.storyBlk);
                            }
                            FlxTween.tween(boxGrp.members[1], {alpha: 1, x: xBoxp2 - 700}, 0.25, {ease: FlxEase.cubeIn});
                            if (boxGrp.members[0].alpha == 1) {
                                FlxTween.tween(diaText, {alpha: 0.0001, x: xDiaBf - 700}, 0.1, {ease: FlxEase.circOut});
                                FlxTween.tween(boxGrp.members[0], {alpha: 0.0001, x: xBoxbf - 700}, 0.25, {ease:  FlxEase.cubeOut});
                                FlxTween.tween(portBf, {alpha: 0.0001, x: xBF - 200}, 0.25, {ease:  FlxEase.cubeOut});
                                if (bfChar != null)
                                    FlxTween.tween(bfChar, {alpha: 0.0001, x: xBF - 200}, 0.25, {ease:  FlxEase.cubeOut});
                            }
                            if (cbox != null) {
                                if (cbox.alpha == 1) {
                                    remove(cPort);
                                    FlxTween.tween(cbox, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn, onComplete: function (twn:FlxTween) {
                                    remove(cdiaText);
                                    remove(cbox);
                                }});
                                FlxTween.tween(cdiaText, {alpha: 0.0001}, 0.25, {ease: FlxEase.cubeIn});
                                }
                            }
                    }
                } else {
                    if (mode == "week1")
                        portP2.x = xP2 + 100;
                    else
                        portP2.x = xP2 - 100;

                    if (splittedLines[0] == "fuckyou") {
                        p2Char.x = xP2 + 100;
                        portP2.alpha = 0.0001;
                        p2Char.alpha = 1;
                    }
                    if (splittedLines[0] == "mybad") {
                        sweatP2.alpha = 1;
                        sweatP2.x = xP2 + 100;
                        portP2.alpha = 0.0001;
                    } else {
                        portP2.alpha = 1;
                        sweatP2.alpha = 0.0001;
                    }
                }

                var delay:Float = 0.0;
                if (!isP2) {
                    delayed = true;
                    delay = 0.2;
                    isP2 = true;
                }
                new FlxTimer().start(delay, function(tmr:FlxTimer) {
                    if (splittedLines[0] != "fuckyou")
                        portP2.animation.play(splittedLines[0], true);
                    else
                        p2Char.animation.play(splittedLines[0], true);
                });

                // portP2.animation.play(splittedLines[0], true);
            case "crowd":
                isP2 = false;
                isBf = false;
                for (i in 0...cLines.length) {
                    if (cLines[i].contains(":" + curLine + ":")) {
                        var formattedLines = cLines[i].split(":");
                        splittedLines.push(formattedLines[1]);
                        trace(formattedLines[1]);
                        splittedLines.push(formattedLines[3]);
                        // getCurPort("bf");
                    }
                }
                cdiaText.width = Std.parseInt(splittedLines[1]);

                if (splittedLines[0] !=  "unnamed_8")
                    PlayState.instance.camOther.shake(0.05, 0.2, null, true);
                else
                    new FlxTimer().start(0.1, function (tmr:FlxTimer) {
                        PlayState.instance.camOther.shake(0.05, 0.2, null, true);
                    });

                setOffset(splittedLines[0]);
                if (splittedLines[0] != "unnamed_8") {
                    remove(cPort);
                    remove(cbox);
                    remove(cdiaText);
                    cPort.loadGraphic(Paths.image("dialogue/stock/" + splittedLines[0], "shared"));
                    setOffset(splittedLines[0]);
                    cPort.screenCenter();
                
                    add(cPort);
                    add(cbox);
                    add(cdiaText);
                } 
                if (splittedLines[0] != "unnamed_8") {
                    FlxTween.tween(cbox, {alpha: 1}, 0.25, {ease: FlxEase.cubeIn});
                    FlxTween.tween(cdiaText, {alpha: 1}, 0.25, {ease: FlxEase.cubeIn});
                } else {
                    // cbox.alpha = 0;
                    // remove(cPort);
                    cPort.alpha = 0;
                    // cdiaText.alpha = 0;
                    remove(cdiaText);
                    remove(cbox);
                    
                    FlxTween.tween(cPort, {alpha: 1}, 0.25, {ease: FlxEase.cubeIn});
                    dia2Text.width = Std.parseInt(splittedLines[1]);
                    if (mode == "week2")
                        FlxTween.tween(boxGrp.members[1], {alpha: 1, x: xBoxp2 - 700}, 0.25, {ease: FlxEase.cubeIn});
                    else
                        FlxTween.tween(boxGrp.members[1], {alpha: 1, x: xBoxp2 + 900}, 0.25, {ease: FlxEase.cubeIn});

                    FlxTween.tween(dia2Text, {alpha: 1,x: xDiaBf + 700}, 0.1, {ease:  FlxEase.cubeIn});
                    FlxG.sound.music.stop();
                }

                if (portBf.alpha == 1) {
                    FlxTween.tween(diaText, {alpha: 0.0001, x: xDiaBf - 700}, 0.1, {ease: FlxEase.circOut});
                    if (mode == "week1")
                        FlxTween.tween(boxGrp.members[0], {alpha: 0.0001, x: xBoxbf + 900}, 0.25, {ease:  FlxEase.cubeOut});
                    else
                        FlxTween.tween(boxGrp.members[0], {alpha: 0.0001, x: xBoxbf - 700}, 0.25, {ease:  FlxEase.cubeOut});
                    if (mode == "week1")
                        FlxTween.tween(portBf, {alpha: 0.0001, x: xBF + 200}, 0.25, {ease:  FlxEase.cubeOut});
                    else
                        FlxTween.tween(portBf, {alpha: 0.0001, x: xBF - 200}, 0.25, {ease:  FlxEase.cubeOut});
                }
                if (portP2.alpha == 1) {
                    if (splittedLines[0] != "unnamed_8") {
                        if (mode == "week2")
                            FlxTween.tween(boxGrp.members[1], {alpha: 0.0001, x: xBoxp2 + 700}, 0.25, {ease:  FlxEase.cubeOut});
                        else
                            FlxTween.tween(boxGrp.members[1], {alpha: 0.0001, x: xBoxp2 - 900}, 0.25, {ease:  FlxEase.cubeOut});

                        if (mode == "week1")
                            FlxTween.tween(portP2, {alpha: 0.0001, x: xP2 - 100}, 0.25, {ease:  FlxEase.cubeOut});
                        else
                            FlxTween.tween(portP2, {alpha: 0.0001, x: xP2 + 100}, 0.25, {ease:  FlxEase.cubeOut});

                        FlxTween.tween(dia2Text, {alpha: 0.0001, x: xDiaP2 + 700}, 0.1, {ease:  FlxEase.cubeOut});
                    } else {
                        if (mode == "week1")
                            FlxTween.tween(portP2, {alpha: 0.0001, x: xP2 - 100}, 0.25, {ease:  FlxEase.cubeOut});
                        else
                            FlxTween.tween(portP2, {alpha: 0.0001, x: xP2 + 100}, 0.25, {ease:  FlxEase.cubeOut});
                    }
                }
        }
    }

    public function setOffset(anim:String) {
        //var shit = pastXp2;
        xP2 = pastXp2;
        xBF = pastXBf;
        switch (anim) {
            case "excited":
                xBF += 50;
            case "ehh-flipped" | "facepalm-flipped" | "shrug-flipped":
                //shit -= 50;
                //if (xP2 > shit)
                xP2 -= 150;
            case "ehh" | "facepalm" | "shrug":
                //shit -= 50;
                //if (xP2 > shit)
                xP2 -= 100;
            case "ohyeah?" | "pointback" | "thumbsup-flipped":
                xP2 -= 50;
            case "ohyeah?-flipped" | "yeah-flipped":
                xP2 -= 70;
            //case "what" | "mybad" | "fingersnap" | "pointback" | "shock" | "legit?" | "thumbsup" | "seriously?" | "yeah":
                //shit += 100;
                //if (xP2 < shit)
                //xP2 += 50;
            case "an-angry-mob":
                cPort.scale.set(1.5,1.5);
            case "karen":
                cPort.scale.set(1.8,1);
            case "unnamed_7":
                cPort.scale.set(2,2);
            case "unnamed_8":
                cPort.scale.set(3,3);
            default:
                xP2 = pastXp2;
                xBF = pastXBf;
                if (PlayState.SONG.song.toLowerCase() == "checkpoint") {
                    cPort.scale.set(1,1);
                }
        }
    }
}

@:sound("assets/shared/sounds/boo.ogg")
class TypeSound extends Sound {}

/**
 * This is loosely based on the TypeText class by Noel Berry, who wrote it for his Ludum Dare 22 game - Abandoned
 * http://www.ludumdare.com/compo/ludum-dare-22/?action=preview&uid=1527
 * @author Noel Berry
 */
class FlxCustomTypeText extends FlxText
{
	/**
	 * The delay between each character, in seconds.
	 */
	public var delay:Float = 0.05;

	/**
	 * The delay between each character erasure, in seconds.
	 */
	public var eraseDelay:Float = 0.02;

	/**
	 * Set to true to show a blinking cursor at the end of the text.
	 */
	public var showCursor:Bool = false;

	/**
	 * The character to blink at the end of the text.
	 */
	public var cursorCharacter:String = "|";

	/**
	 * The speed at which the cursor should blink, if shown at all.
	 */
	public var cursorBlinkSpeed:Float = 0.5;

	/**
	 * Text to add at the beginning, without animating.
	 */
	public var prefix:String = "";

	/**
	 * Whether or not to erase this message when it is complete.
	 */
	public var autoErase:Bool = false;

	/**
	 * How long to pause after finishing the text before erasing it. Only used if autoErase is true.
	 */
	public var waitTime:Float = 1.0;

	/**
	 * Whether or not to animate the text. Set to false by start() and erase().
	 */
	public var paused:Bool = false;

	/**
	 * The sounds that are played when letters are added; optional.
	 */
	public var sounds:Array<FlxSound>;

	/**
	 * Whether or not to use the default typing sound.
	 */
	public var useDefaultSound:Bool = false;

	/**
	 * Whether typing sound effects should always be played in their entirety, or if it's ok to restart them on new letters.
	 * For longer typing sounds, setting this to `true` usually makes more sense.
	 * @since 2.4.0
	 */
	public var finishSounds = false;

	/**
	 * An array of keys (e.g. `[FlxKey.SPACE, FlxKey.L]`) that will advance the text.
	 */
	public var skipKeys:Array<FlxKey> = [];

	/**
	 * This function is called when the message is done typing.
	 */
	public var completeCallback:Void->Void;

	/**
	 * This is the shit stupid fuck
	 */
     public var curLeng:Int = 0;

	/**
	 * This function is called when the message is done erasing, if that is enabled.
	 */
	public var eraseCallback:Void->Void;

	/**
	 * The text that will ultimately be displayed.
	 */
	var _finalText:String = "";

	/**
	 * This is incremented every frame by elapsed, and when greater than delay, adds the next letter.
	 */
	var _timer:Float = 0.0;

	/**
	 * A timer that is used while waiting between typing and erasing.
	 */
	var _waitTimer:Float = 0.0;

	/**
	 * Internal tracker for current string length, not counting the prefix.
	 */
	var _length:Int = 0;

	/**
	 * Whether or not to type the text. Set to true by start() and false by pause().
	 */
	var _typing:Bool = false;

	/**
	 * Whether or not to erase the text. Set to true by erase() and false by pause().
	 */
	var _erasing:Bool = false;

	/**
	 * Whether or not we're waiting between the type and erase phases.
	 */
	var _waiting:Bool = false;

	/**
	 * Internal tracker for cursor blink time.
	 */
	var _cursorTimer:Float = 0.0;

	/**
	 * Whether or not to add a "natural" uneven rhythm to the typing speed.
	 */
	var _typingVariation:Bool = false;

	/**
	 * How much to vary typing speed, as a percent. So, at 0.5, each letter will be "typed" up to 50% sooner or later than the delay variable is set.
	 */
	var _typeVarPercent:Float = 0.5;

	/**
	 * Helper string to reduce garbage generation.
	 */
	static var helperString:String = "";

	/**
	 * Internal reference to the default sound object.
	 */
	var _sound:FlxSound;

	/**
	 * Create a FlxTypeText object, which is very similar to FlxText except that the text is initially hidden and can be
	 * animated one character at a time by calling start().
	 *
	 * @param	X				The X position for this object.
	 * @param	Y				The Y position for this object.
	 * @param	Width			The width of this object. Text wraps automatically.
	 * @param	Text			The text that will ultimately be displayed.
	 * @param	Size			The size of the text.
	 * @param	EmbeddedFont	Whether this text field uses embedded fonts or not.
	 */
	public function new(X:Float, Y:Float, Width:Int, Text:String, Size:Int = 8, EmbeddedFont:Bool = true)
	{
		super(X, Y, Width, "", Size, EmbeddedFont);
		_finalText = Text;
	}

	/**
	 * Start the text animation.
	 *
	 * @param   Delay          Optionally, set the delay between characters. Can also be set separately.
	 * @param   ForceRestart   Whether or not to start this animation over if currently animating; false by default.
	 * @param   AutoErase      Whether or not to begin the erase animation when the typing animation is complete.
	 *                         Can also be set separately.
	 * @param   SkipKeys       An array of keys as string values (e.g. `[FlxKey.SPACE, FlxKey.L]`) that will advance the text.
	 *                         Can also be set separately.
	 * @param   Callback       An optional callback function, to be called when the typing animation is complete.
	 */
	public function start(?Delay:Float, ForceRestart:Bool = false, AutoErase:Bool = false, ?SkipKeys:Array<FlxKey>, ?Callback:Void->Void):Void
	{
		if (Delay != null)
		{
			delay = Delay;
		}

		_typing = true;
		_erasing = false;
		paused = false;
		_waiting = false;

		if (ForceRestart)
		{
			text = "";
			_length = 0;
		}

		autoErase = AutoErase;

		if (SkipKeys != null)
		{
			skipKeys = SkipKeys;
		}

		completeCallback = Callback;

		insertBreakLines();

		if (useDefaultSound)
		{
			loadDefaultSound();
		}
	}

	override public function applyMarkup(input:String, rules:Array<FlxTextFormatMarkerPair>):FlxText
	{
		super.applyMarkup(input, rules);
		resetText(text); // Stops applyMarkup from misaligning the colored section of text.
		return this;
	}

	/**
	 * Internal function that replace last space in a line for a line break.
	 * To prevent a word start typing in a line and jump to next.
	 */
	function insertBreakLines()
	{
		var saveText = text;

		var last = _finalText.length;
		var n0:Int = 0;
		var n1:Int = 0;

		while (true)
		{
			last = _finalText.substr(0, last).lastIndexOf(" ");

			if (last <= 0)
				break;

			text = prefix + _finalText;
			n0 = textField.numLines;

            // curLeng++;

			var nextText = _finalText.substr(0, last) + "\n" + _finalText.substr(last + 1, _finalText.length);

			text = prefix + nextText;
			n1 = textField.numLines;

			if (n0 == n1)
			{
                // curLeng = 0;
				_finalText = nextText;
			}
		}

		text = saveText;
	}

	/**
	 * Begin an animated erase of this text.
	 *
	 * @param	Delay			Optionally, set the delay between characters. Can also be set separately.
	 * @param	ForceRestart	Whether or not to start this animation over if currently animating; false by default.
	 * @param	SkipKeys		An array of keys as string values (e.g. `[FlxKey.SPACE, FlxKey.L]`) that will advance the text. Can also be set separately.
	 * @param	Callback		An optional callback function, to be called when the erasing animation is complete.
	 * @param	Params			Optional parameters to pass to the callback function.
	 */
	public function erase(?Delay:Float, ForceRestart:Bool = false, ?SkipKeys:Array<FlxKey>, ?Callback:Void->Void):Void
	{
		_erasing = true;
		_typing = false;
		paused = false;
		_waiting = false;

		if (Delay != null)
		{
			eraseDelay = Delay;
		}

		if (ForceRestart)
		{
			_length = _finalText.length;
			text = _finalText;
		}

		if (SkipKeys != null)
		{
			skipKeys = SkipKeys;
		}

		eraseCallback = Callback;

		if (useDefaultSound)
		{
			loadDefaultSound();
		}
	}

	/**
	 * Reset the text with a new text string. Automatically cancels typing, and erasing.
	 *
	 * @param	Text	The text that will ultimately be displayed.
	 */
	public function resetText(Text:String):Void
	{
		text = "";
		_finalText = Text;
		_typing = false;
		_erasing = false;
		paused = false;
		_waiting = false;
		_length = 0;
	}

	/**
	 * If called with On set to true, a random variation will be added to the rate of typing.
	 * Especially with sound enabled, this can give a more "natural" feel to the typing.
	 * Much more noticable with longer text delays.
	 *
	 * @param	Amount		How much variation to add, as a percentage of delay (0.5 = 50% is the maximum amount that will be added or subtracted from the delay variable). Only valid if >0 and <1.
	 * @param	On			Whether or not to add the random variation. True by default.
	 */
	public function setTypingVariation(Amount:Float = 0.5, On:Bool = true):Void
	{
		_typingVariation = On;
		_typeVarPercent = FlxMath.bound(Amount, 0, 1);
	}

	/**
	 * Internal function that is called when typing is complete.
	 */
	function onComplete():Void
	{
		_timer = 0;
		_typing = false;

		if (useDefaultSound)
		{
			_sound.stop();
		}
		else if (sounds != null)
		{
			for (sound in sounds)
			{
				sound.stop();
			}
		}

		if (completeCallback != null)
		{
			completeCallback();
		}

		if (autoErase && waitTime <= 0)
		{
			_erasing = true;
		}
		else if (autoErase)
		{
			_waitTimer = waitTime;
			_waiting = true;
		}
	}

	function onErased():Void
	{
		_timer = 0;
		_erasing = false;

		if (eraseCallback != null)
		{
			eraseCallback();
		}
	}

	override public function update(elapsed:Float):Void
	{
		// If the skip key was pressed, complete the animation.
		#if FLX_KEYBOARD
		if (skipKeys != null && skipKeys.length > 0 && FlxG.keys.anyJustPressed(skipKeys))
		{
			skip();
		}
		#end

		if (_waiting && !paused)
		{
			_waitTimer -= elapsed;

			if (_waitTimer <= 0)
			{
				_waiting = false;
				_erasing = true;
			}
		}

		// So long as we should be animating, increment the timer by time elapsed.
		if (!_waiting && !paused)
		{
			if (_length < _finalText.length && _typing)
			{
				_timer += elapsed;
			}

			if (_length > 0 && _erasing)
			{
				_timer += elapsed;
			}
		}

		// If the timer value is higher than the rate at which we should be changing letters, increase or decrease desired string length.

		if (_typing || _erasing)
		{
			if (_typing && _timer >= delay)
			{
				_length += Std.int(_timer / delay);
				if (_length > _finalText.length)
					_length = _finalText.length;
			}

			if (_erasing && _timer >= eraseDelay)
			{
				_length -= Std.int(_timer / eraseDelay);
				if (_length < 0)
					_length = 0;
			}

			if ((_typing && _timer >= delay) || (_erasing && _timer >= eraseDelay))
			{
				if (_typingVariation)
				{
					if (_typing)
					{
						_timer = FlxG.random.float(-delay * _typeVarPercent / 2, delay * _typeVarPercent / 2);
					}
					else
					{
						_timer = FlxG.random.float(-eraseDelay * _typeVarPercent / 2, eraseDelay * _typeVarPercent / 2);
					}
				}
				else
				{
					_timer %= delay;
				}

				if (sounds != null && !useDefaultSound)
				{
					if (!finishSounds)
					{
						for (sound in sounds)
						{
							sound.stop();
						}
					}

					FlxG.random.getObject(sounds).play(!finishSounds);
				}
				else if (useDefaultSound)
				{
					_sound.play(!finishSounds);
				}
			}
		}

		// Update the helper string with what could potentially be the new text.
		helperString = prefix + _finalText.substr(0, _length);

		// Append the cursor if needed.
		if (showCursor)
		{
			_cursorTimer += elapsed;

			// Prevent word wrapping because of cursor
			var isBreakLine = (prefix + _finalText).charAt(helperString.length) == "\n";

			if (_cursorTimer > cursorBlinkSpeed / 2 && !isBreakLine)
			{
				helperString += cursorCharacter.charAt(0);
			}

			if (_cursorTimer > cursorBlinkSpeed)
			{
				_cursorTimer = 0;
			}
		}

		// If the text changed, update it.
		if (helperString != text)
		{
			text = helperString;

			// If we're done typing, call the onComplete() function
			if (_length >= _finalText.length && _typing && !_waiting && !_erasing)
			{
				onComplete();
			}

			// If we're done erasing, call the onErased() function
			if (_length == 0 && _erasing && !_typing && !_waiting)
			{
				onErased();
			}
		}

		super.update(elapsed);
	}

	/**
	 * Immediately finishes the animation. Called if any of the skipKeys is pressed.
	 * Handy for custom skipping behaviour (for example with different inputs like mouse or gamepad).
	 */
	public function skip():Void
	{
		if (_erasing || _waiting)
		{
			_length = 0;
			_waiting = false;
		}
		else if (_typing)
		{
			_length = _finalText.length;
		}
        // curLeng = 0;
	}

	function loadDefaultSound():Void
	{
		#if FLX_SOUND_SYSTEM
		_sound = FlxG.sound.load(new TypeSound());
		#else
		_sound = new FlxSound();
		_sound.loadEmbedded(new TypeSound());
		#end
	}
}
