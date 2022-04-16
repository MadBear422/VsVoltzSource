import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxG;

class STButton extends FlxSprite
{
    public var toggled:Bool = false;
    public var clickable:Bool = true;
    public var triggerFunction:Bool = false;
    public var activar:Bool = false;
    public var posprite:String = 'micena';
    public var poaltsprite:String = 'mic';
    var firstScale:Float = 1;
    var lebool:Bool = false;
    var fakehitbox:Array<Float> = [];
    var leFunc:Void->Void;
    var leArg:String;
    var leFail:Void->Void = null;
    public var btnFunc = false;
    public function new(x:Float, y:Float,qsprite:String,qaltsprite:String,fbox:Array<Float>,buttonFunction:Void->Void,?mainArg:String = 'none',?failFunction:Void->Void = null)
        {
            posprite = qsprite;
            poaltsprite = qaltsprite;
            //loadGraphic(Paths.image('soundtest/micena'));
            fakehitbox = fbox;
            leFunc = buttonFunction;
            leArg = mainArg;
            if (failFunction != null)
                leFail = failFunction;
            super(x, y);
        }

    override function update(elapsed:Float)
        {
            if (SoundTest.canInput && clickable && FlxG.mouse.justPressed && ((FlxG.mouse.screenX > fakehitbox[0] && FlxG.mouse.screenX < fakehitbox[2]) && (FlxG.mouse.screenY > fakehitbox[1] && FlxG.mouse.screenY < fakehitbox[3])))
                {
                    if (leFail != null && validate(leArg))
                        leFail();
                    else
                        {
                            btnNorm(true);
                            if (SoundTest.songPlaying && !SoundTest.loadingsong)
                            leFunc();
                        }
                }
            if (!lebool)
                {
                    this.loadGraphic(Paths.image('soundtest/${posprite}'));
                    this.setGraphicSize(1280,720);
                    this.updateHitbox();
                    firstScale = this.scale.x;
                    lebool = true;
                }
            if (activar)
                {
                    leFunc();
                }
            if (btnFunc)
                {
                    btnNorm();
                    btnFunc = false;
                }
            if (triggerFunction)
                {
                    if (leFail != null && validate(leArg))
                        leFail();
                    else
                        {
                            btnNorm();
                            if (SoundTest.songPlaying)
                            leFunc();
                        }
                    triggerFunction = false;
                }
            super.update(elapsed);
        }

    function validate(cv:String)
        {
            var isReal:Bool = false;
            switch (cv)
            {
                case 'canChar':
                    isReal = !SoundTest.canChar;
            }
            return isReal;
        }

    function btnNorm(?canDo:Bool = false)
    {
        this.scale.set(firstScale,firstScale);
        FlxTween.tween(this.scale, {/*x: firstScale+0.07,*/ y: firstScale+0.07}, 0.025, {
        ease: FlxEase.linear,
        onComplete: function(twn:FlxTween)
        {
            FlxTween.tween(this.scale, {/*x: firstScale,*/ y: firstScale}, 0.3, {
            ease: FlxEase.quadOut
            });
        }
        });
        if (canDo)
        toggled = !toggled;
        if (toggled)
            this.loadGraphic(Paths.image('soundtest/${poaltsprite}'));
        else
            this.loadGraphic(Paths.image('soundtest/${posprite}'));
    }
}