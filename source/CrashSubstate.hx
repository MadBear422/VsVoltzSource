import flixel.FlxSubState;
import flixel.FlxCamera;
import flixel.util.FlxTimer;
import sys.FileSystem;
import flixel.FlxG;

class CrashSubstate extends MusicBeatSubstate
{
    override public function create()
    {
        Main.fpsVar.visible = false;
        FlxG.fullscreen = true;
        FlxG.sound.play(Paths.sound('crash'));
        new FlxTimer().start(5.4, function(tmr:FlxTimer)
        {
            Sys.exit(0);
        });
    }
}