import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import haxe.Json;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

typedef AchievementFile =
{
	var unlocksAfter:String;
	var icon:String;
	var name:String;
	var description:String;
	var hidden:Bool;
	var customGoal:Bool;
}

class Achievements {
	public static var achievementShits:Array<Dynamic> = [//Name, Description, Achievement save tag, Unlocks after, Hidden achievement
		//Set unlock after to "null" if it doesnt unlock after a week!!
		["Swingin' Start!",				"Beat Lightswing.",									'lightswing_clear',		null,			false],
		["EEEEE AAAAA",					"Beat Tangroove.",									'tangroove_clear',		null,			false],
		["Zapped Out?",					"Beat Checkpoint.",									'checkpoint_clear',		null,			false],
		["Training Time!",				"Beat Meowmix.",									'meowmix_clear',		null,			false],
		["Get Off The Stage!",			"Beat Week 1 with Voltz on Electrified.",			'week1-v_clear',		'week1-V',		false],
		["Scary Songs or Something",	"Beat Week 2 with Voltz on Electrified.",			'week2-v_clear',		'week2-V',		false],
		["The Clone Wars",				"Beat Week 3 with Voltz on Electrified.",			'week3-v_clear',		'week3-V',		false],
		["Average Human Mother",		"Beat Week 4 with Voltz on Electrified.",			'week4-v_clear',		'week4-V',		false],
		["Ello Guvna",					"Beat Week 5 with Voltz on Electrified.",			'week5-v_clear',		'week5-V',		false],
		["Pixel Dreams",				"Beat Week 6 with Voltz on Electrified.",			'week6-v_clear',		'week6-V',		false],
		["Grudge Match",				"Beat Heavyswing.",									'heavyswing_clear',		null,			false],
		["Woah, My Head's Spinning!",	"Beat Fizz.",										'fizz_clear',			null,			false],
		["The Finale",					"Beat Homestretch.",								'homestretch_clear',	null,			false],
		["We're Doin' A Sequel",		"Beat Twomah.",										'twomah_clear',			null,			false],
		["Here Comes Pac-Man!",			"Beat LMHY.",										'lmhy_clear',			null,			false],
		["WHAT THE FUCK",				"Beat Slightswing.",								'slightswing_clear',	null,			false],
		["What A Nice Leader :D",		"Beat Rolecall.",									'rolecall_clear',		null,			false],
		["Thank Fuck!",					"100% The Mod.",									'all_voltz_clear',		null,			false],
		//non-gallery
		["Shocking Events",				"Get Electricuted 5 times!",						'zapped_5',				null,			false],
		["Deep Fried",					"Get Electricuted 15 times in one song!",			'zapped_15',			null,			false],
		["Shut Up",						"Die in Twomah!",									'twomah_die',			null,			false],
		["A POWERFUL FIGURE",			"Find Goku in LMHY!",								'lmhy_goku_click',		null,			false],		//has a hint
		["Fall Of A Titan",				"Die 3 times as GodVoltz!",							'godvoltz_die',			null,			false],
		["THE MEME??!!",				"Type BLAMMED LIGHTS during Slightswing!",			'slightswing_blammed',	null,			false],
		["Groove Music",				"Stay on the Sound Test for 15 minutes!",			'soundtest_afk',		null,			false],
		["Who's This Guy?",				"Access the \"Who's Voltz\" menu!",					'voltz_menu',			null,			false],
		["Gamest In The Land",			"Find Mr. King Dice!",								'story_dice_updown',	null,			false],		//has a hint
		["Gross",						"Find the Secret British Theme!",					'brit_startup',			null,			false],
		["Brown Bricks?",				"Building THE BRITISH ANTHEM in MY FNF MOD",		'brit_startup_minecrap',null,			true],
		["GO TO THE DENTIST!",			"",													'startup',				null,			false],
		//OLD
		["Freaky on a Friday Night",	"Play on a Friday... Night.",						'friday_night_play',	 null,			true],
		["She Calls Me Daddy Too",		"Beat Week 1 on Hard with no Misses.",				'week1_nomiss',			'week1', 		false],
		["No More Tricks",				"Beat Week 2 on Hard with no Misses.",				'week2_nomiss',         'week2', 		false],
		["Call Me The Hitman",			"Beat Week 3 on Hard with no Misses.",				'week3_nomiss',			'week3', 		false],
		["Lady Killer",					"Beat Week 4 on Hard with no Misses.",				'week4_nomiss',			'week4', 		false],
		["Missless Christmas",			"Beat Week 5 on Hard with no Misses.",				'week5_nomiss',			'week5',		false],
		["Highscore!!",					"Beat Week 6 on Hard with no Misses.",				'week6_nomiss',			'week6',		false],
		["You'll Pay For That...",		"Beat Week 7 on Hard with no Misses.",				'week7_nomiss',			'week7',		true],
		["What a Funkin' Disaster!",	"Complete a Song with a rating lower than 20%.",	'ur_bad',				null,			false],
		["Perfectionist",				"Complete a Song with a rating of 100%.",			'ur_good',				null,			false],
		["Roadkill Enthusiast",			"Watch the Henchmen die over 100 times.",			'roadkill_enthusiast',	null,			false],
		["Oversinging Much...?",		"Hold down a note for 10 seconds.",					'oversinging',			null,			false],
		["Hyperactive",					"Finish a Song without going Idle.",				'hype',					null,			false],
		["Just the Two of Us",			"Finish a Song pressing only two keys.",			'two_keys',				null,			false],
		["Toaster Gamer",				"Have you tried to run the game on a toaster?",		'toastie',				null,			false],
		["Debugger",					"Beat the \"Test\" Stage from the Chart Editor.",	'debugger',				null,			true]
	];

	public static var achievementsStuff:Array<Dynamic> = [ 
		//Gets filled when loading achievements
	];

	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();
	public static var loadedAchievements:Map<String, AchievementFile> = new Map<String, AchievementFile>();

	public static var henchmenDeath:Int = 0;
	public static var voltzElectrocutions:Int = 0;
	public static var voltzGodDeaths:Int = 0;
	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name)) {
			return achievementsMap.get(name);
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		achievementsStuff = [];
		achievementsStuff = achievementShits;

		#if MODS_ALLOWED
		//reloadAchievements(); //custom achievements do not work. will add once it doesn't do the duplication bug -bb
		#end

		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
			if(FlxG.save.data.achievementsUnlocked != null) {
				FlxG.log.add("Trying to load stuff");
				var savedStuff:Array<String> = FlxG.save.data.achievementsUnlocked;
				for (i in 0...savedStuff.length) {
					achievementsMap.set(savedStuff[i], true);
				}
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
			if(voltzElectrocutions == 0 && FlxG.save.data.voltzElectrocutions != null) {
				voltzElectrocutions = FlxG.save.data.voltzElectrocutions;
			}
			if(voltzGodDeaths == 0 && FlxG.save.data.voltzGodDeaths != null) {
				voltzGodDeaths = FlxG.save.data.voltzGodDeaths;
			}
		}

		// You might be asking "Why didn't you just fucking load it directly dumbass??"
		// Well, Mr. Smartass, consider that this class was made for Mind Games Mod's demo,
		// i'm obviously going to change the "Psyche" achievement's objective so that you have to complete the entire week
		// with no misses instead of just Psychic once the full release is out. So, for not having the rest of your achievements lost on
		// the full release, we only save the achievements' tag names instead. This also makes me able to rename
		// achievements later as long as the tag names aren't changed of course.

		// Edit: Oh yeah, just thought that this also makes me able to change the achievements orders easier later if i want to.
		// So yeah, if you didn't thought about that i'm smarter than you, i think

		// buffoon

		// EDIT 2: Uhh this is weird, this message was written for MInd Games, so it doesn't apply logically for Psych Engine LOL
	}

	public static function wipeVoltzAchievements() {
		for (i in 0...30) 
			{
				achievementsMap.set(achievementsStuff[i][2],false);
			}
		FlxG.save.data.achievementsMap = achievementsMap;
		voltzElectrocutions = 0;
		FlxG.save.data.voltzElectrocutions = 0;
		voltzGodDeaths = 0;
		FlxG.save.data.voltzGodDeaths = 0;
		FlxG.save.flush();
		loadAchievements();
	}

	public static function reloadAchievements() {	//Achievements in game are hardcoded, no need to make a folder for them
		loadedAchievements.clear();

		#if MODS_ALLOWED //Based on WeekData.hx
		var disabledMods:Array<String> = [];
		var modsListPath:String = 'modsList.txt';
		var directories:Array<String> = [Paths.mods()];
		if(FileSystem.exists(modsListPath))
		{
			var stuff:Array<String> = CoolUtil.coolTextFile(modsListPath);
			for (i in 0...stuff.length)
			{
				var splitName:Array<String> = stuff[i].trim().split('|');
				if(splitName[1] == '0') // Disable mod
				{
					disabledMods.push(splitName[0]);
				}
				else // Sort mod loading order based on modsList.txt file
				{
					var path = haxe.io.Path.join([Paths.mods(), splitName[0]]);
					//trace('trying to push: ' + splitName[0]);
					if (sys.FileSystem.isDirectory(path) && !Paths.ignoreModFolders.contains(splitName[0]) && !disabledMods.contains(splitName[0]) && !directories.contains(path + '/'))
					{
						directories.push(path + '/');
						//trace('pushed Directory: ' + splitName[0]);
					}
				}
			}
		}

		var modsDirectories:Array<String> = Paths.getModDirectories();
		for (folder in modsDirectories)
		{
			var pathThing:String = haxe.io.Path.join([Paths.mods(), folder]) + '/';
			if (!disabledMods.contains(folder) && !directories.contains(pathThing))
			{
				directories.push(pathThing);
				//trace('pushed Directory: ' + folder);
			}
		}

		for (i in 0...directories.length) {
			var directory:String = directories[i] + 'achievements/';

			//trace(directory);
			if (FileSystem.exists(directory)) {

				var listOfAchievements:Array<String> = CoolUtil.coolTextFile(directory + 'achievementList.txt');

				for (achievement in listOfAchievements) {
					var path:String = directory + achievement + '.json';

					if (FileSystem.exists(path) && !loadedAchievements.exists(achievement) && achievement != PlayState.othersCodeName) {
						loadedAchievements.set(achievement, getAchievementInfo(path));
					}

					//trace(path);
				}

				for (file in FileSystem.readDirectory(directory)) {
					var path = haxe.io.Path.join([directory, file]);
					
					var cutName:String = file.substr(0, file.length - 5);
					if (!FileSystem.isDirectory(path) && file.endsWith('.json') && !loadedAchievements.exists(cutName) && cutName != PlayState.othersCodeName) {
						loadedAchievements.set(cutName, getAchievementInfo(path));
					}

					//trace(file);
				}
			}
		}

		for (json in loadedAchievements) {
			//trace(json);
			achievementsStuff.push([json.name, json.description, json.icon, json.unlocksAfter, json.hidden]);
		}
		#end
	}

	private static function getAchievementInfo(path:String):AchievementFile {
		var rawJson:String = null;
		#if MODS_ALLOWED
		if (FileSystem.exists(path)) {
			rawJson = File.getContent(path);
		}
		#else
		if(OpenFlAssets.exists(path)) {
			rawJson = Assets.getText(path);
		}
		#end

		if(rawJson != null && rawJson.length > 0) {
			return cast Json.parse(rawJson);
		}
		return null;
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			var imagePath:FlxGraphic = Paths.image('achievementgrid');
			var isModIcon:Bool = false;

			if (Achievements.loadedAchievements.exists(tag)) {
				isModIcon = true;
				imagePath = Paths.image(Achievements.loadedAchievements.get(tag).icon);
			}

			var index:Int = Achievements.getAchievementIndex(tag);
			if (isModIcon) index = 0;

			trace(imagePath);

			loadGraphic(imagePath, true, 150, 150);
			animation.add('icon', [index], 0, false, false);
			animation.play('icon');
		} else {
			loadGraphic(Paths.image('lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);
		var achieveName:String = Achievements.achievementsStuff[id][0];
		var text:String = Achievements.achievementsStuff[id][1];

		if(Achievements.loadedAchievements.exists(name)) {
			id = 0;
			achieveName = Achievements.loadedAchievements.get(name).name;
			text = Achievements.loadedAchievements.get(name).description;
		}

		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var imagePath = Paths.image('achievementgrid');
		var modsImage = null;
		var isModIcon:Bool = false;

		if (Achievements.loadedAchievements.exists(name)) {
			isModIcon = true;
			modsImage = Paths.image(Achievements.loadedAchievements.get(name).icon);
		}

		var index:Int = Achievements.getAchievementIndex(name);
		if (isModIcon) index = 0;

		trace(imagePath);
		trace(modsImage);

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic((isModIcon ? modsImage : imagePath), true, 150, 150);
		achievementIcon.animation.add('icon', [index], 0, false, false);
		achievementIcon.animation.play('icon');
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, achieveName, 16);
		achievementName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, text, 16);
		achievementText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}