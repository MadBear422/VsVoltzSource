package;

import flixel.util.FlxAxes;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class BGSprite extends FlxSprite
{
	public var idleAnim:String;
	public function new(image:String, x:Float = 0, y:Float = 0, ?scrollX:Float = 1, ?scrollY:Float = 1, ?animArray:Array<String> = null, ?loop:Bool = false, ?args:Map<String, Dynamic> = null) {
		super(x, y);

		var extras:Map<String, Dynamic> = ["fps" => 24, "loop" => loop, "scale" => 1.0, "scrollX" => scrollX, "scrollY" => scrollY, "playAnim?" => true];

		if (args != null) {
			for (key in args.keys()) {
				if (extras[key] != null)
					extras[key] = args[key];
			}
		}

		if (animArray != null) {
			frames = Paths.getSparrowAtlas(image);
			for (i in 0...animArray.length) {
				var anim:String = animArray[i];
				animation.addByPrefix(anim, anim, extras["fps"], extras["loop"]);
				if(idleAnim == null) {
					idleAnim = anim;
					if (extras["playAnim?"]) 
						animation.play(anim);
				}
			}
		} else {
			if(image != null) {
				loadGraphic(Paths.image(image));
			}
			active = false;
		}
		scrollFactor.set(extras["scrollX"], extras["scrollY"]);
		setGraphicSize(Math.round(width * extras["scale"]));
		updateHitbox();
		antialiasing = ClientPrefs.globalAntialiasing;

		GPUTools.uploadToGpu(this);
	}

	public function dance(?forceplay:Bool = false) {
		if(idleAnim != null) {
			animation.play(idleAnim, forceplay);
		}
	}

	public function changeIdle(anim:String) {
		if (animation.getByName(anim) != null) {
			idleAnim = anim;
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0) {
		animation.play(AnimName, Force, Reversed, Frame);
	}
}