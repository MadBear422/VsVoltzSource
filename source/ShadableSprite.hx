package;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;
import flixel.FlxG;

class ShadableSprite extends FlxSprite
{
	public static var colorSwap:ColorSwap = null;
    public var name:String = '';
    public var link:String = '';
    public var isThird:Bool = false;
    public function new(x:Float,y:Float, ?SimpleGraphic:FlxGraphicAsset)
        {
            colorSwap = new ColorSwap();
            shader = colorSwap.shader;

		    useFramePixels = FlxG.renderBlit;
		    if (SimpleGraphic != null)
		    	loadGraphic(SimpleGraphic);

            super(x,y);
        }

    override function update(elapsed:Float)
        {
            super.update(elapsed);
        }

    public function setDesat(desatNum:Float,brightNum:Int) //-1 for gray scale
        {
			var newShader:ColorSwap = new ColorSwap();
			newShader.saturation = desatNum;
			newShader.brightness = brightNum/100;
            shader = newShader.shader;
        }
}