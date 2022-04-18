package;

import haxe.Timer;
import openfl.display.FPS;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
#if cpp
import cpp.vm.Gc;
#end

/**
 * FPS class extension to display memory usage.
 * @author Kirill Poletaev
 * https://keyreal-code.github.io/haxecoder-tutorials/17_displaying_fps_and_memory_usage_using_openfl.html
 */
class CoolerFPS extends TextField
{
	private var times:Array<Float>;
	private var memPeak:Float = 0;

	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000)
	{
		super();

		x = inX;
		y = inY;
		selectable = false;
		defaultTextFormat = new TextFormat("_sans", 12, inCol);
		text = "FPS: ";

		times = [];
		addEventListener(Event.ENTER_FRAME, onEnter);
		width = 150;
		height = 70;

	}

	private function onEnter(_)
	{
		var now = Timer.stamp();
		times.push(now);

		while (times[0] < now - 1)
			times.shift();

		#if debug
		#if cpp
		var mem:Float = Math.round(Gc.memInfo64(Gc.MEM_INFO_USAGE) / 1024 / 1024 * 100)/100;
		#else
		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100)/100;
		#end

		if (mem > memPeak) memPeak = mem;
		#end

		if (visible)
		{
			text = "FPS: " + times.length
			#if debug
			+ "\nMemory: " + mem + " MB\nMemory peak: " + memPeak + " MB" +"\nVersion: 0.1.0 " +
			#if debug "(DEBUG)" #else "(RELEASE)" #end
			#end;
		}
	}
}