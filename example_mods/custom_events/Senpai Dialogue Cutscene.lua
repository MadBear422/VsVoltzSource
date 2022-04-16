-- CODE BY SHADOW MARIO, DO NOT FORGET TO CREDIT
-- MAYBE ASK FOR HIS PERMISSION BEFORE YOU USE THIS (I DID)
allowStart = false;
dialogueShit = {};
dialogueIsDad = {};
dialogueIsHmmm = {};
dialogueIsOno = {};
dialogueIsUm = {};
dialogueIsUgh = {};
dialogueIsPowerHungry = {};
dialogueIsWorried = {};
dialogueIsTango = {};
dialogueIsDadReal = {};
dialogueIsDadHmmm = {};
dialogueIsDadAha = {};
dialogueIsDadHuh = {};
dialogueIsRub = {};
dialogueIsMute = {};
function onStartCountdown()
	if not allowStart and isStoryMode and not seenCutscene then
		doReturn = false;
		for i = 0, getProperty('eventNotes.length') do
			if getPropertyFromGroup('eventNotes', i, 1) == 'Senpai Dialogue Cutscene' then
				dialogueType = getPropertyFromGroup('eventNotes', i, 2);
				type = getPropertyFromGroup('eventNotes', i, 3);
				startSenpaiCutscene(dialogueType, type);
				doReturn = true;
				break;
			end
		end
	
		if doReturn then
			setProperty('boyfriend.stunned', true);
			setProperty('inCutscene', true);
			return Function_Stop;
		end
	end
	return Function_Continue;
end

dialogueLineName = ''
dialogueLineType = ''
dialogueSound = 'pixelText';
dialogueSoundClick = 'clickText';

curDialogue = 0;

dialogueOpened = false;
dialogueStarted = false;
dialogueEnded = false;
dialogueGone = false;
targetText = 'blah blah coolswag';
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'start senpai dialogue' then
		allowStart = true;
		addLuaSprite('bgFade', true);
		makeAnimatedLuaSprite('portraitLeft', 'weeb/senpaiPortrait', -20, 40);
		pixelThingie('portraitLeft', 5.4, true);
		addAnimationByPrefix('portraitLeft', 'enter', 'Senpai Portrait Enter', 24, false);
		setProperty('portraitLeft.visible', false);
		
		makeAnimatedLuaSprite('portraitLeft2', 'weeb/SenpaiRub', 140, 110);
		pixelThingie('portraitLeft2', 5.4, true);
		addAnimationByPrefix('portraitLeft2', 'enter', 'Senpai Portrait Enter', 24, false);
		setProperty('portraitLeft2.visible', false);
		
		makeAnimatedLuaSprite('portraitLeft3', 'weeb/SenpaiReal', 150, 130);
		pixelThingie('portraitLeft3', 5.4, true);
		addAnimationByPrefix('portraitLeft3', 'enter', 'Senpai Portrait Enter', 24, false);
		setProperty('portraitLeft3.visible', false);
		
		makeAnimatedLuaSprite('portraitLeft4', 'weeb/SenpaiHmmmm', 150, 105);
		pixelThingie('portraitLeft4', 5.4, true);
		addAnimationByPrefix('portraitLeft4', 'enter', 'Senpai Portrait Enter', 24, false);
		setProperty('portraitLeft4.visible', false);
		
		makeAnimatedLuaSprite('portraitLeft5', 'weeb/SenpaiAha', 150, 105);
		pixelThingie('portraitLeft5', 5.4, true);
		addAnimationByPrefix('portraitLeft5', 'enter', 'Senpai Portrait Enter', 24, false);
		setProperty('portraitLeft5.visible', false);
		
		makeAnimatedLuaSprite('portraitLeft6', 'weeb/SenpaiHuh', 150, 105);
		pixelThingie('portraitLeft6', 5.4, true);
		addAnimationByPrefix('portraitLeft6', 'enter', 'Senpai Portrait Enter', 24, false);
		setProperty('portraitLeft6.visible', false);
		
		setProperty('camOther._fxFadeAlpha', 0);
		removeLuaSprite('senpaiEvil');
		removeLuaSprite('senpaiBlack');
		setProperty('camHUD.visible', true);

		makeAnimatedLuaSprite('portraitRight', 'weeb/VoltzHmmmm', 650, 120);
		pixelThingie('portraitRight', 5.4, true);
		addAnimationByPrefix('portraitRight', 'enter', 'Voltz portrait enter', 24, false);
		setProperty('portraitRight.visible', false);
		
		makeAnimatedLuaSprite('portraitRight2', 'weeb/VoltzUm', 650, 120);
		pixelThingie('portraitRight2', 5.4, true);
		addAnimationByPrefix('portraitRight2', 'enter', 'Voltz portrait enter', 24, false);
		setProperty('portraitRight2.visible', false);
		
		makeAnimatedLuaSprite('portraitRight3', 'weeb/VoltzOno', 650, 120);
		pixelThingie('portraitRight3', 5.4, true);
		addAnimationByPrefix('portraitRight3', 'enter', 'Voltz portrait enter', 24, false);
		setProperty('portraitRight3.visible', false);
		
		makeAnimatedLuaSprite('portraitRight4', 'weeb/VoltzUgh', 650, 120);
		pixelThingie('portraitRight4', 5.4, true);
		addAnimationByPrefix('portraitRight4', 'enter', 'Voltz portrait enter', 24, false);
		setProperty('portraitRight4.visible', false);
		
		makeAnimatedLuaSprite('portraitRight5', 'weeb/VoltzPowerHungry', 650, 120);
		pixelThingie('portraitRight5', 5.4, true);
		addAnimationByPrefix('portraitRight5', 'enter', 'Voltz portrait enter', 24, false);
		setProperty('portraitRight5.visible', false);
		
		makeAnimatedLuaSprite('portraitRight6', 'weeb/VoltzWorried', 650, 140);
		pixelThingie('portraitRight6', 5.4, true);
		addAnimationByPrefix('portraitRight6', 'enter', 'Voltz portrait enter', 24, false);
		setProperty('portraitRight6.visible', false);
		
		makeAnimatedLuaSprite('portraitRight7', 'weeb/VoltzTango', 650, 140);
		pixelThingie('portraitRight7', 5.4, true);
		addAnimationByPrefix('portraitRight7', 'enter', 'Voltz portrait enter', 24, false);
		setProperty('portraitRight7.visible', false);
		
		if dialogueLineType == 'thorns' then
			spiritImage = 'weeb/spiritFaceForward';
			makeLuaSprite('spiritUgly', spiritImage, 320, 170);
			pixelThingie('spiritUgly', 6, false);
		end

		if dialogueLineType == 'thorns' then
			boxImage = 'weeb/pixelUI/dialogueBox-evil';
			
			makeAnimatedLuaSprite('dialogueBox', boxImage, -20, 45);
			addAnimationByPrefix('dialogueBox', 'normalOpen', 'Spirit Textbox spawn', 24, false);
			addAnimationByIndices('dialogueBox', 'normal', 'Spirit Textbox spawn instance 1', '11', 24);
		elseif dialogueLineType == 'roses' then
			boxImage = 'weeb/pixelUI/dialogueBox-senpaiMad';

			makeAnimatedLuaSprite('dialogueBox', 'weeb/pixelUI/dialogueBox-senpaiMad', -20, 45);
			addAnimationByPrefix('dialogueBox', 'normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
			addAnimationByIndices('dialogueBox', 'normal', 'SENPAI ANGRY IMPACT SPEECH instance 1', '4', 24);
			addAnimationByPrefix('dialogueBox', 'noPortrait', 'SENPAI ANGRY NS', 24, false);
		else
			makeAnimatedLuaSprite('dialogueBox', 'weeb/pixelUI/dialogueBox-pixel', -20, 45);
			addAnimationByPrefix('dialogueBox', 'normalOpen', 'Text Box Appear', 24, false);
			addAnimationByIndices('dialogueBox', 'normal', 'Text Box Appear instance 1', '4', 24);
		end
		pixelThingie('dialogueBox', 5.4, true);
		
		screenCenter('dialogueBox', 'x');
		screenCenter('portraitLeft', 'x');
		
		handImage = 'weeb/pixelUI/hand_textbox';

		makeLuaSprite('handSelect', handImage, 1042, 590);
		pixelThingie('handSelect', 5.4, true);
		setProperty('handSelect.visible', false);

		makeLuaText('dropText', '', screenWidth * 0.6, 242, 502);
		setTextFont('dropText', 'pixel.otf');
		setTextColor('dropText', 'D89494');
		setTextBorder('dropText', 0, 0);
		setTextSize('dropText', 32);
		setTextAlignment('dropText', 'left');
		addLuaText('dropText');

		makeLuaText('swagDialogue', '', screenWidth * 0.6, 240, 500);
		setTextFont('swagDialogue', 'pixel.otf');
		setTextColor('swagDialogue', '3F2021');
		setTextBorder('swagDialogue', 0, 0);
		setTextSize('swagDialogue', 32);
		setTextAlignment('swagDialogue', 'left');
		addLuaText('swagDialogue');
		
		if dialogueLineType == 'thorns' then
			setTextColor('dropText', '000000');
			setTextColor('swagDialogue', 'FFFFFF');
		end

	elseif tag == 'remove black' then
		setProperty('senpaiBlack.alpha', getProperty('senpaiBlack.alpha') - 0.15);
	elseif tag == 'increase bg fade' then
		newAlpha = getProperty('bgFade.alpha') + (1 / 5) * 0.7;
		if newAlpha > 0.7 then
			newAlpha = 0.7;
		end
		setProperty('bgFade.alpha', newAlpha);
	elseif tag == 'add dialogue letter' then
		setTextString('swagDialogue', string.sub(targetText, 0, (loops - loopsLeft)));
		playSound(dialogueSound, 0.8);

		if loopsLeft == 0 then
			--debugPrint('Text finished!')
			setProperty('handSelect.visible', true);
			dialogueEnded = true;
		end
	elseif tag == 'end dialogue thing' then
		newAlpha = loopsLeft / 5;
		cancelTimer('increase bg fade');
		setProperty('bgFade.alpha', newAlpha * 0.7);
		setProperty('dialogueBox.alpha', newAlpha);
		setProperty('swagDialogue.alpha', newAlpha);
		setProperty('dropText.alpha', newAlpha);
		setProperty('handSelect.alpha', newAlpha);
	elseif tag == 'start countdown thing' then
		allowStart = true;
		removeLuaSprite('bgFade');
		removeLuaSprite('dialogueBox');
		removeLuaSprite('dialogueBox2');
		removeLuaSprite('handSelect');
		removeLuaText('swagDialogue');
		removeLuaText('dropText');
		setProperty('inCutscene', false);
		setProperty('boyfriend.stunned', false);
		startCountdown();
		dialogueGone = true;

		removeLuaSprite('spiritUgly');
	elseif tag == 'make senpai visible' then
		setProperty('senpaiEvil.alpha', getProperty('senpaiEvil.alpha') + 0.15);
		if loopsLeft == 0 then
			playSound('Senpai_Dies');
			objectPlayAnimation('senpaiEvil', 'die');
			runTimer('start flash', 3.2);
		end
	elseif tag == 'start flash' then
		cameraFade('other', 'FFFFFF', 1.6, true);
	end
end

isEnding = false;
function onUpdate(elapsed)
	if dialogueGone then
		return;
	end

	if getProperty('dialogueBox.animation.curAnim.name') == 'normalOpen' and getProperty('dialogueBox.animation.curAnim.finished') then
		objectPlayAnimation('dialogueBox', 'normal');
		dialogueOpened = true;
	end
	
	if dialogueOpened and not (dialogueStarted) then
		startDialogueThing();
		objectPlayAnimation('portraitLeft', 'enter', true);
		dialogueStarted = true;
	end

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') == true then
		if dialogueEnded then
			curDialogue = curDialogue + 1;
			if curDialogue > table.maxn(dialogueShit) then
				if not isEnding then
					removeLuaSprite('portraitLeft');
					removeLuaSprite('portraitLeft2');
					removeLuaSprite('portraitLeft3');
					removeLuaSprite('portraitLeft4');
					removeLuaSprite('portraitLeft5');
					removeLuaSprite('portraitRight');
					removeLuaSprite('portraitRight2');
					removeLuaSprite('portraitRight3');
					removeLuaSprite('portraitRight4');
					removeLuaSprite('portraitRight5');
					removeLuaSprite('portraitRight6');
					removeLuaSprite('portraitRight7');
					runTimer('end dialogue thing', 0.2, 5);
					runTimer('start countdown thing', 1.5);
					soundFadeOut(nil, 1.5);
					isEnding = true;
					playSound(dialogueSoundClick, 0.8);
				end
			else
				startDialogueThing();
				playSound(dialogueSoundClick, 0.8);
			end
		elseif dialogueStarted then
			cancelTimer('add dialogue letter');
			onTimerCompleted('add dialogue letter', string.len(targetText), 0);
			playSound(dialogueSoundClick, 0.8);
		end
	end
	setTextString('dropText', getTextString('swagDialogue'));
end

function startDialogueThing()
	reloadDialogue();
	runTimer('add dialogue letter', 0.04, string.len(targetText));
end

function reloadDialogue()
	curCharacterIsDad = dialogueIsDad[curDialogue];
	curCharacterIsRub = dialogueIsRub[curDialogue];
	curCharacterIsUm = dialogueIsUm[curDialogue];
	curCharacterIsUgh = dialogueIsUgh[curDialogue];
	curCharacterIsPowerHungry = dialogueIsPowerHungry[curDialogue];
	curCharacterIsWorried = dialogueIsWorried[curDialogue];
	curCharacterIsTango = dialogueIsTango[curDialogue];
	curCharacterIsOno = dialogueIsOno[curDialogue];
	curCharacterIsHmmm = dialogueIsHmmm[curDialogue];
	curCharacterIsDadHmmm = dialogueIsDadHmmm[curDialogue];
	curCharacterIsDadAha = dialogueIsDadAha[curDialogue];
	curCharacterIsDadHuh = dialogueIsDadHuh[curDialogue];
	curCharacterIsDadReal = dialogueIsDadReal[curDialogue];
	curCharacterIsMute = dialogueIsMute[curDialogue];
	targetText = dialogueShit[curDialogue];

	setTextString('dropText', '');
	setTextString('swagDialogue', '');
	setProperty('handSelect.visible', false);
	dialogueEnded = false;
	
	if curCharacterIsMute then
		setSoundVolume('', 0)
	end
	
	if curCharacterIsDad then
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		if getProperty('portraitLeft.visible') == false then
			if dialogueLineType == 'senpai' then
				setProperty('portraitLeft.visible', true);
			end
			objectPlayAnimation('portraitLeft', 'enter');
		end
	elseif curCharacterIsRub then
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		if getProperty('portraitLeft2.visible') == false then
			setProperty('portraitLeft2.visible', true);
		end
		objectPlayAnimation('portraitLeft2', 'enter', true);
	elseif curCharacterIsDadReal then
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		if getProperty('portraitLeft3.visible') == false then
			setProperty('portraitLeft3.visible', true);
		end
		objectPlayAnimation('portraitLeft3', 'enter');
	elseif curCharacterIsDadHmmm then
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		if dialogueLineType == 'roses' then
		objectPlayAnimation('dialogueBox', 'noPortrait');
		setProperty('dialogueBox.y', 40)
		end
		if getProperty('portraitLeft4.visible') == false then
			setProperty('portraitLeft4.visible', true);
		end
		objectPlayAnimation('portraitLeft4', 'enter');
	elseif curCharacterIsDadAha then
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		setProperty('portraitRight5.visible', false);
		if dialogueLineType == 'roses' then
		objectPlayAnimation('dialogueBox', 'noPortrait');
		setProperty('dialogueBox.y', 40)
		end
		if getProperty('portraitLeft5.visible') == false then
			setProperty('portraitLeft5.visible', true);
		end
		objectPlayAnimation('portraitLeft5', 'enter');
	elseif curCharacterIsDadHuh then
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitLeft5.visible', false);
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		setProperty('portraitRight5.visible', false);
		if dialogueLineType == 'roses' then
		objectPlayAnimation('dialogueBox', 'noPortrait');
		setProperty('dialogueBox.y', 40)
		end
		if getProperty('portraitLeft6.visible') == false then
			setProperty('portraitLeft6.visible', true);
		end
		objectPlayAnimation('portraitLeft6', 'enter');
	elseif curCharacterIsHmmm then
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		if getProperty('portraitRight.visible') == false then
			setProperty('portraitRight.visible', true);
		end
		objectPlayAnimation('portraitRight', 'enter');
	elseif curCharacterIsOno then
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight.visible', false);
		if getProperty('portraitRight3.visible') == false then
			setProperty('portraitRight3.visible', true);
		end
		objectPlayAnimation('portraitRight3', 'enter');
	elseif curCharacterIsUm then
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		if getProperty('portraitRight2.visible') == false then
			setProperty('portraitRight2.visible', true);
		end
		objectPlayAnimation('portraitRight2', 'enter');
	elseif curCharacterIsUgh then
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitLeft5.visible', false);
		setProperty('portraitLeft6.visible', false);
		if getProperty('portraitRight4.visible') == false then
			setProperty('portraitRight4.visible', true);
		end
		objectPlayAnimation('portraitRight4', 'enter');
	elseif curCharacterIsPowerHungry then
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		setProperty('portraitRight5.visible', false);
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitLeft5.visible', false);
		setProperty('portraitLeft6.visible', false);
		if getProperty('portraitRight5.visible') == false then
			setProperty('portraitRight5.visible', true);
		end
		objectPlayAnimation('portraitRight5', 'enter');
	elseif curCharacterIsWorried then
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		setProperty('portraitRight5.visible', false);
		setProperty('portraitRight7.visible', false);
		setProperty('portraitLeft.visible', false);
		setProperty('spiritUgly.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitLeft5.visible', false);
		setProperty('portraitLeft6.visible', false);
		if getProperty('portraitRight6.visible') == false then
			setProperty('portraitRight6.visible', true);
		end
		objectPlayAnimation('portraitRight6', 'enter');
	elseif curCharacterIsTango then
		setProperty('portraitRight.visible', false);
		setProperty('portraitRight2.visible', false);
		setProperty('portraitRight3.visible', false);
		setProperty('portraitRight4.visible', false);
		setProperty('portraitRight5.visible', false);
		setProperty('portraitRight6.visible', false);
		setProperty('portraitLeft.visible', false);
		setProperty('portraitLeft2.visible', false);
		setProperty('portraitLeft3.visible', false);
		setProperty('portraitLeft4.visible', false);
		setProperty('portraitLeft5.visible', false);
		setProperty('portraitLeft6.visible', false);
		if getProperty('portraitRight7.visible') == false then
			setProperty('portraitRight7.visible', true);
		end
		objectPlayAnimation('portraitRight7', 'enter');
	end
end

function startSenpaiCutscene(dialogueType, type)
	makeLuaSprite('bgFade', nil, -200, -200);
	makeGraphic('bgFade', screenWidth * 1.3, screenHeight * 1.3, 'B3DFD8');
	setProperty('bgFade.alpha', 0);
	setScrollFactor('bgFade', 0, 0);
	setObjectCamera('bgFade', 'hud');
	runTimer('increase bg fade', 0.83, 5);
	
	
		
	if type == 'senpai' then
		makeLuaSprite('senpaiBlack', nil, -100, -100);
		makeGraphic('senpaiBlack', screenWidth * 2, screenHeight * 2, '000000');
		setScrollFactor('senpaiBlack', 0, 0);
		addLuaSprite('senpaiBlack', true);
		runTimer('remove black', 0.3, 7);
	elseif type == 'thorns' then
		makeLuaSprite('senpaiBlack', nil, -100, -100);
		makeGraphic('senpaiBlack', screenWidth * 2, screenHeight * 2, 'FF1B31');
		setScrollFactor('senpaiBlack', 0, 0);
		addLuaSprite('senpaiBlack', true);

		assetName = 'weeb/senpaiCrazy';

		makeAnimatedLuaSprite('senpaiEvil', assetName, 0, 0);
		addAnimationByIndices('senpaiEvil', 'idle', 'Senpai Pre Explosion instance 1', '0', 24);
		addAnimationByPrefix('senpaiEvil', 'die', 'Senpai Pre Explosion', 24, false);
		scaleObject('senpaiEvil', 6, 6);
		setScrollFactor('senpaiEvil', 0, 0);
		screenCenter('senpaiEvil')
		setProperty('senpaiEvil.x', getProperty('senpaiEvil.x') + 300);
		setProperty('senpaiEvil.antialiasing', false);
		setProperty('senpaiEvil.alpha', 0);
		addLuaSprite('senpaiEvil', true);

		setProperty('camHUD.visible', false);
		runTimer('make senpai visible', 0.3, 7);
	end
	
	dialogueLineName = dialogueType;
	dialogueLineType = type;
	if dialogueType == 'senpai' then
		dialogueShit[0] = 'Jesus, what on earth happened?';
		dialogueIsRub[0] = true;
		dialogueShit[1] = 'Now how do I hide a body..?';
		dialogueIsHmmm[1] = true;
		dialogueShit[2] = ' ';
		dialogueIsOno[2] = true;
		dialogueShit[3] = ' ';
		dialogueIsDadReal[3] = true;
		dialogueShit[4] = 'Uh, are you oka-';
		dialogueIsUm[4] = true;
		dialogueShit[5] = 'Who the fuck are you';
		dialogueIsDad[5] = true;
		dialogueIsMute[5] = true;
	elseif dialogueType == 'roses' then
		dialogueShit[0] = 'Not bad for an ugly worm.';
		dialogueIsDad[0] = true;
		dialogueShit[1] = 'But this time I\'l-';
		dialogueIsDad[1] = true;
		dialogueShit[2] = 'Hang on, I know you from somewhere.';
		dialogueIsDadHmmm[2] = true;
		dialogueShit[3] = 'Oh for the love of god.';
		dialogueIsUgh[3] = true;
		dialogueShit[4] = 'I KNOW!';
		dialogueIsDadAha[4] = true;
		dialogueShit[5] = 'You\'re that redhead from week three, aren\'t you?';
		dialogueIsDadHuh[5] = true;
		dialogueShit[6] = 'Wasn\'t I supposed to bury you?';
		dialogueIsPowerHungry[6] = true;
	elseif dialogueType == 'thorns' then
		dialogueShit[0] = 'Direct contact with real humans, after being trapped in here for so long.';
		dialogueIsDad[0] = true;
		dialogueShit[1] = 'and HER of all people.';
		dialogueIsDad[1] = true;
		dialogueShit[2] = 'I\'ll make her father pay for what he\'s done to me and all the others...';
		dialogueIsDad[2] = true;
		dialogueShit[3] = 'I\'ll beat you and make you take my place.';
		dialogueIsDad[3] = true;
		dialogueShit[4] = 'You don\'t mind your bodies being borrowed right? It\'s only fair...';
		dialogueShit[5] = '...';
		dialogueIsWorried[5] = true;
		dialogueShit[6] = 'I need to stop drinking these.';
		dialogueIsTango[6] = true;
	end

	timerTime = 2; --stupid name
	if type == 'thorns' then
		timerTime = 9.2;
	end
	runTimer('start senpai dialogue', timerTime);
end

function pixelThingie(tag, scale, doUpdateHitbox)
	if doUpdateHitbox then
		scaleObject(tag, scale, scale);
	else
		setProperty(tag..'.scale.x', scale);
		setProperty(tag..'.scale.y', scale);
	end
	setScrollFactor(tag, 0, 0);
	setObjectCamera(tag, 'hud');
	setProperty(tag..'.antialiasing', false);
	addLuaSprite(tag, true);
end