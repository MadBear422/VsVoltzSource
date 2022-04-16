package;

import openfl.system.System;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class UnfinishedNote extends MusicBeatState // doing this cause I'm super cool /j
{
    var gmovrtxt:FlxText;
    var continuetxt:FlxText;
    var quittxt:FlxText;
    var curSelected:Bool = true;
	var camOther:FlxCamera;
	var hasLoaded:Bool = false;
    var loadingtxt:FlxText;
    var loadingbg:FlxSprite;
    public static var info:Array<String> = ['This isn\'t finished you dumbfuck','Go Back','Crash the fucking game'];
    override function create()
        {
            camOther = new FlxCamera();
            FlxG.cameras.add(camOther);

            gmovrtxt = new FlxText(0, 240, FlxG.width, info[0], 60);
            gmovrtxt.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            gmovrtxt.scrollFactor.set();
            gmovrtxt.borderSize = 2.25;
            gmovrtxt.screenCenter(X);
            add(gmovrtxt);

            continuetxt = new FlxText(0, gmovrtxt.y + gmovrtxt.height+18, FlxG.width, info[1], 60);
            continuetxt.setFormat(Paths.font("vcr.ttf"), 36, 0xFF0030cc, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            continuetxt.scrollFactor.set();
            continuetxt.borderSize = gmovrtxt.borderSize-1;
            continuetxt.screenCenter(X);
            add(continuetxt);

            quittxt = new FlxText(0, continuetxt.y + continuetxt.height+18, FlxG.width, info[2], 60);
            quittxt.setFormat(Paths.font("vcr.ttf"), 36, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            quittxt.scrollFactor.set();
            quittxt.borderSize = continuetxt.borderSize;
            quittxt.screenCenter(X);
            add(quittxt);

            super.create();
        }

    override function update(elapsed)
        {
            if (controls.UI_UP_P || controls.UI_DOWN_P)
                {
                    curSelected = !curSelected;
                    continuetxt.color = FlxColor.WHITE;
                    quittxt.color = FlxColor.WHITE;
                    if (curSelected)
                        continuetxt.color = 0xFF0030cc;
                    else
                        quittxt.color = 0xFF0030cc;
                }
            if (controls.ACCEPT)
                {
                    info = ['This isn\'t finished you dumbfuck','Go Back','Crash the fucking game'];
                    FlxG.sound.music.stop();
					CustomFadeTransition.nextCamera = camOther;
                    if (curSelected)
                        {
                            loadState(info[1]);
                        }
                    else
                        {
                            loadState(info[2]);
                        }
                }
            super.update(elapsed);
        }
        function loadState(lestate:String)
            {
                switch (lestate)
                {
                    case 'Go Back':
						MusicBeatState.switchState(new MainMenuState());
                    default:
                        System.exit(0);
                }
            }
        public static function cancelMusicFadeTween() {
            if(FlxG.sound.music.fadeTween != null) {
                FlxG.sound.music.fadeTween.cancel();
            }
            FlxG.sound.music.fadeTween = null;
        }
}