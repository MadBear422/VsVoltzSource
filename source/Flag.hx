package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.FlxCamera;

class Flag extends FlxSprite
{
	public var spins:Bool;
	var var1:Float;
	var var2:Float;
	var var3:Float;
	public override function new(x:Float, y:Float)
	{
		super(x, y);
        if (spins)
		{
			var1 = FlxG.random.int(-1200,1200); //speed
			var2 = FlxG.random.int(-1,1); //acceleration
		}
    }
	override function update(elapsed:Float)
	{
        if (spins)
		{
			angle += var1;
			var1 += var2;
		}
		if (FlxG.random.int(0,200) == 0)
		{
			FlxTween.tween(this, {x: FlxG.random.int(0,1280), y: FlxG.random.int(0,720)}, 1, {ease: FlxEase.quadInOut});
		}
		super.update(elapsed);
    }
}