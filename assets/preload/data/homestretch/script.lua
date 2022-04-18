--local theVig = false
local cantpause = false
local hasCachedMidMid = false
local hasCachedMid = false


function onCreate()
	addCharacterToList('VoltzHomestretchHyped')
	addCharacterToList('godVoltz')
	addCharacterToList('godVoltzKi')
	addCharacterToList('voltzLosesHisShit')
	addCharacterToList('bf-homestretchShock', "dad")
	addCharacterToList('bf-homestretchHyped', "dad")
	addCharacterToList('bf-homestretchFinal', "dad")
	addCharacterToList('godVoltz-noglow')
	addCharacterToList('bf-homestretchFinal-noglow')
	addCharacterToList('gf-cat-glow', "girlfriend")
	addCharacterToList('bf-opponentGlasses', "dad")
	addCharacterToList('bf-opponentGlassesTangrooveAlt', "dad")
	addCharacterToList('bf-opponentGlassesFizzAlt', "dad")
	addCharacterToList('VoltzPlayableGlasses')
	addCharacterToList('VoltzPlayableGlassesTangrooveAlt')
	addCharacterToList('VoltzPlayableGlassesFizzAlt')

	makeLuaSprite('txt', 'placeholder', 0, 0)
	setObjectCamera('txt', 'hud')

	Y = -200

	makeAnimatedLuaSprite('lightIn', 'lightCominIn', 850, Y)
	makeAnimatedLuaSprite('lightInB', 'lightCominIn', -270, Y)
	addAnimationByPrefix('lightIn', 'LC', 'light come in', 24, false)
	addAnimationByIndices('lightIn', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByIndices('lightInB', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByPrefix('lightInB', 'LC', 'light come in', 24, false)
	scaleObject('lightIn', 1, 1.3)
	scaleObject('lightInB', 1, 1.3)
	setBlendMode('lightIn', 'add')
	setBlendMode('lightInB', 'add')
	setProperty('lightIn.alpha', 0.55)
	setProperty('lightInB.alpha', 0.55)

	makeLuaSprite('gr', 'Gradiento', 0, 0)
	setObjectCamera('gr', 'hud')
	addLuaSprite('gr', true)
	doTweenColor('gr0', 'gr', 'FF0000', 4, 'linear')
	setProperty('gr.visible', false)

	setProperty('glow', true)

	makeLuaSprite('bar1', nil, 0, -100)
	makeLuaSprite('bar2', nil, 0, 720)
	makeGraphic('bar1', screenWidth, 100, '000000')
	makeGraphic('bar2', screenWidth, 100, '000000')
	setObjectCamera('bar1', 'hud')
	setObjectCamera('bar2', 'hud')
	addLuaSprite('bar1', false)
	addLuaSprite('bar2', false)

	makeLuaSprite('vignette', 'vig_filter', 0, 0)
	setObjectCamera('vignette', 'hud')
	setBlendMode('vignette', 'overlay')
	setProperty('vignette.alpha', 0)

	makeLuaSprite('sepiaFilter', 'sepia', 0, 0)
	scaleObject('sepiaFilter', 1.5, 1.5)
	setObjectCamera('sepiaFilter', 'other')
	setBlendMode('sepiaFilter', 'overlay')
	setProperty('sepiaFilter.alpha', 0.7)

	makeAnimatedLuaSprite('fireworks0', 'fireworks', -250, -700)
	makeAnimatedLuaSprite('fireworks1', 'fireworks', 500, -600)
	makeAnimatedLuaSprite('fireworks2', 'fireworks', -800, -400)
	makeAnimatedLuaSprite('fireworks3', 'fireworks', -800, -400)
	makeAnimatedLuaSprite('fireworks4', 'fireworks', -800, -400)
	makeAnimatedLuaSprite('fireworks5', 'fireworks', -800, -400)
	makeAnimatedLuaSprite('fireworks6', 'fireworks', -800, -400)
	makeAnimatedLuaSprite('fireworks7', 'fireworks', -800, -400)
	doTweenColor('F1', 'fireworks1', '56FF00', 1, 'linear') -- green
	doTweenColor('F2', 'fireworks2', '006DFF', 1, 'linear') -- blue
	doTweenColor('F3', 'fireworks3', '861F6B', 1, 'linear') -- purple
	doTweenColor('F4', 'fireworks4', '00FFEC', 1, 'linear') -- cyan
	doTweenColor('F5', 'fireworks5', 'F200FF', 0.1, 'linear') -- pink
	doTweenColor('F6', 'fireworks6', 'FFB400', 0.1, 'linear') -- orange
	doTweenColor('F7', 'fireworks7', '6000FF', 0.1, 'linear') -- red

	for f = 0, 7 do
		addAnimationByPrefix('fireworks'..f, 'f', 'FIREWORK YELLOW', 24, false)
		addLuaSprite('fireworks'..f, false)
		setObjectOrder('fireworks'..f, getObjectOrder('sky') + 1)
		setProperty('fireworks'..f..'.visible', false)
	end
	makeAnimatedLuaSprite('lights', 'lights', getProperty('sky.x'), getProperty('sky.y'))
	scaleObject('lights', 4, 4)
	setProperty('lights.alpha', 0.5)
	addAnimationByPrefix('lights', 'Lights', 'lights', 24, true)
	objectPlayAnimation('lights', 'Lights', true)
	setBlendMode('lights', 'add')
	addLuaSprite('lights', false)
	setObjectOrder('lights', getObjectOrder('sky') + 1)
	setProperty('lights.visible', false)

	makeAnimatedLuaSprite('static', 'gym/screens/static', 20, -361)
	scaleObject('static', 1.80, 2)
	addAnimationByPrefix('static', 'moop', 'statics', 24, true)
	addLuaSprite('static', false)
	setObjectOrder('static', getObjectOrder('screen') - 1)
	setProperty('static.visible', false)
	objectPlayAnimation('static', 'moop', true)

	makeLuaSprite('ST', 'stars', getProperty('gfGroup.x') - 1100, Y - 1300)
	scaleObject('ST', 7.5, 7.5)
	addLuaSprite('ST', false)
	setObjectOrder('ST', getObjectOrder('gfGroup') + 1)
	setProperty('ST.visible', false)

	if getProperty('newScriptThing') then
		hasCachedMidMid = true
		hasCachedMid = true
	end

	precacheImage('gym/screens/static')
	--precacheImage('txt')
	--precacheImage('lightIn')
	--precacheImage('lightInB')
	--precacheImage('Gradiento')
	precacheImage('vig_filter')
	--precacheImage('sepiaFilter')
	precacheImage('lights')
	precacheImage('fireworks')
	precacheImage('gym/screens/static')
	precacheImage('stageclear')
	precacheImage('stars')
	precacheImage('blueNotes')
	precacheImage('orangeNotes')
	precacheImage('orangeSplashes')
end

function onCreatePost()
	--makeLuaSprite('vignetteLast', 'vig_filter2', 0, 0)
	--setObjectCamera('vignetteLast', 'hud')
	--setBlendMode('vignetteLast', 'overlay')
	--setProperty('vignetteLast.visible', false)
	--addLuaSprite('vignetteLast', true)
end

function onCountdownTick(t)
	if t == 1 then
		if isStoryMode then
			setProperty('fakeN0.offset.y', 21)
			setProperty('fakeN0.offset.x', 36.5)
			setProperty('fakeN2.offset.y', 45)
			setProperty('fakeNS0.offset.y', 21)
			setProperty('fakeNS0.offset.x', 36.5)
			setProperty('fakeNS2.offset.y', 45)
		else
			setProperty('fakeN0.offset.x', 36.5)
			setProperty('fakeN2.offset.y', 35)
			setProperty('fakeNS0.offset.x', 36.5)
			setProperty('fakeNS2.offset.y', 35)
		end
	end
end

function onSongStart()
	triggerEvent('Camera Follow Pos', '1056.5', '476')
	setProperty('glow', false)
	addLuaSprite('sepiaFilter', true)
	setProperty('sepiaFilter.visible', false)
	for f = 0,7 do
		setProperty('fireworks'..f..'.visible', true)
	end
	cacheMidVideo('mid-mid-homestretch')
	hasCachedMidMid = true;
	runTimer('fuckoff', 0.2, 1)
end

function onTweenCompleted(t)
	if t == 'gr0' then
		doTweenColor('gr1', 'gr', '0085FF', 4, 'linear')
	elseif t == 'gr1' then
		doTweenColor('gr0', 'gr', 'FF0000', 4, 'linear')
	end
end

local activate = false
function onBeatHit()
	if activate then
		local spr = getRandomInt(0, 7)
		math.randomseed(curStep * 4)
		local x = getRandomInt(-1150, 1300)
		local y = getRandomInt(-730, -650)
		local sc = getRandomFloat(0.5, 1)
		objectPlayAnimation('fireworks'..spr, 'f')
		setProperty('fireworks'..spr..'.x', x)
		setProperty('fireworks'..spr..'.y', y)
		setProperty('fireworks'..spr..'.scale.x', sc)
		setProperty('fireworks'..spr..'.scale.y', sc)
		objectPlayAnimation('fireworks'..spr2, 'f')
		setProperty('fireworks'..spr..'.x', x)
		setProperty('fireworks'..spr..'.y', y)
		setProperty('fireworks'..spr..'.scale.x', sc)
		setProperty('fireworks'..spr..'.scale.y', sc)
		objectPlayAnimation('fireworks'..spr, 'f')
		setProperty('fireworks'..spr..'.x', x)
		setProperty('fireworks'..spr..'.y', y)
		setProperty('fireworks'..spr..'.scale.x', sc)
		setProperty('fireworks'..spr..'.scale.y', sc)
	end
	if curBeat == 484 then
		triggerEvent('Camera Follow Pos', '696', '406')
		debugPrint("yo")
	end
end

function goodNoteHit(id, dir, nt, sus)
	setProperty('camZooming', true)
end

function onStepHit()
	if curStep == 0 then
		triggerEvent('Camera Follow Pos', '696', '406')
	end
	if curStep >= 0 and not hasCachedMidMid then
		cacheMidVideo('mid-mid-homestretch')
		hasCachedMidMid = true;
	end
	if curStep == 3 then
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 16 then
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		addLuaSprite('lightIn', true)
		doTweenColor('bf', 'boyfriendGroup', 'BDBDBD', 0.1, 'linear')
		doTweenColor('dad', 'dadGroup', 'BDBDBD', 0.1, 'linear')
		doTweenColor('gf', 'gfGroup', '777777', 0.1, 'linear')
		doTweenColor('st', 'standTop', '777777', 0.1, 'linear')
		doTweenColor('sb', 'standBottom', '777777', 0.1, 'linear')
		doTweenColor('br', 'bird', '777777', 0.1, 'linear')
		doTweenColor('Nsk', 'Nsky', '777777', 0.1, 'linear')
		doTweenColor('sk', 'sky', '777777', 0.1, 'linear')
		doTweenColor('scr', 'screen', '777777', 0.1, 'linear')
		doTweenColor('am', 'main', '777777', 0.1, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', '777777', 0.1, 'linear')
		doTweenColor('cr1', 'crowdTopRight', '777777', 0.1, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', '777777', 0.1, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', '777777', 0.1, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', '777777', 0.1, 'linear')
		doTweenColor('gary', 'gary', '777777', 0.1, 'linear')
		doTweenColor('dan', 'dan', '777777', 0.1, 'linear')
	end
	if curStep == 30 then
		triggerEvent("Camera Follow Pos", "", "")
	end
	if curStep == 80 then
		addLuaSprite('lightInB', true)
		objectPlayAnimation('lightInB', 'LC', false)
		objectPlayAnimation('lightIn', 'F', false)
		doTweenAlpha('lI0', 'lightIn', 0, 0.3, 'linear')
	end
	if curStep == 144 then
		objectPlayAnimation('lightInB', 'F', false)
		objectPlayAnimation('lightIn', 'LC', false)
		doTweenAlpha('lI1', 'lightInB', 0, 0.3, 'linear')
		doTweenAlpha('lI0', 'lightIn', 0.4, 0.01, 'linear')
		addLuaSprite('vignette', true)
		doTweenAlpha('vig', 'vignette', 1, 0.5, 'linear')
	end
	if curStep == 156 then
		objectPlayAnimation('lightInB', 'LC', false)
		doTweenAlpha('lI1', 'lightInB', 0.4, 0.01, 'linear')
	end
	if curStep == 208 then
		objectPlayAnimation('lightIn', 'F', false)
		doTweenAlpha('lI0', 'lightIn', 0, 0.3, 'linear')
	end
	if curStep == 220 then
		objectPlayAnimation('lightIn', 'LC', false)
		doTweenAlpha('lI0', 'lightIn', 0.4, 0.01, 'linear')
	end
	if curStep == 272 then
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		doTweenAlpha('lI0', 'lightIn', 0, 0.1)
		doTweenAlpha('lI1', 'lightInB', 0, 0.1)
		doTweenColor('bf', 'boyfriendGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('dad', 'dadGroup', '777777', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('gf', 'gfGroup', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('st', 'standTop', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('sb', 'standBottom', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('br', 'bird', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('Nsk', 'Nsky', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('sk', 'sky', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('scr', 'screen', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('am', 'main', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('cr1', 'crowdTopRight', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('gary', 'gary', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenColor('dan', 'dan', '000000', stepCrochet / 1000 * 16 * 6.5, 'linear')
		doTweenY('b1', 'bar1', -15, 4, 'quadOut')
		doTweenY('b2', 'bar2', 620, 4, 'quadOut')
	end
	if curStep == 336 then
		cancelTween('dad')
		doTweenColor('dad', 'dadGroup', 'FFFFFF', 0.1, 'linear')
	end
	if curStep == 376 then
		triggerEvent('Camera Follow Pos', '696', '406')
	end
	if curStep == 380 then
		doTweenAlpha('vig', 'vignette', 0, 0.1, 'linear')
		doTweenAlpha('cgcut', 'camGame', 0, 0.2, 'linear')
		doTweenAlpha('tcut', 'timeBar', 0, 0.2, 'linear')
		doTweenAlpha('tBGcut', 'timeBarBG', 0, 0.2, 'linear')
		doTweenAlpha('ttxtcut', 'timeTxt', 0, 0.2, 'linear')
		doTweenAlpha('scoretxtcut', 'scoreTxt', 0, 0.2, 'linear')
		doTweenAlpha('hpcut', 'healthBar', 0, 0.2, 'linear')
		doTweenAlpha('hpBGcut', 'healthBarBG', 0, 0.2, 'linear')
		doTweenAlpha('icon1cut', 'iconP1', 0, 0.2, 'linear')
		doTweenAlpha('icon2cut', 'iconP2', 0, 0.2, 'linear')
		doTweenY('b1', 'bar2', 1500, 0.1, 'quadIn')
		doTweenY('b2', 'bar1', -500, 0.1, 'quadIn')
	end
	if curStep == 383 then
		triggerEvent('Change Character', '0', 'VoltzHomestretchHyped')
		triggerEvent('Change Character', '1', 'bf-homestretchHyped')
		setProperty('unskip', true)
		cantpause = true
	end
	if curStep == 386 then
		setProperty('boyfriend.stunned', false)
		setProperty('inCutscene', false)
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 400 then
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 0.15)
		end
		doTweenAlpha('cgcut', 'camGame', 1, 0.1, 'linear')
		doTweenAlpha('tcut', 'timeBar', 1, 0.1, 'linear')
		doTweenAlpha('tBGcut', 'timeBarBG', 1, 0.1, 'linear')
		doTweenAlpha('ttxtcut', 'timeTxt', 1, 0.1, 'linear')
		doTweenAlpha('scoretxtcut', 'scoreTxt', 1, 0.1, 'linear')
		doTweenAlpha('hpcut', 'healthBar', 1, 0.1, 'linear')
		doTweenAlpha('hpBGcut', 'healthBarBG', 1, 0.1, 'linear')
		doTweenAlpha('icon1cut', 'iconP1', 1, 0.1, 'linear')
		doTweenAlpha('icon2cut', 'iconP2', 1, 0.1, 'linear')
		doTweenColor('bf', 'boyfriendGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('dad', 'dadGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('st', 'standTop', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sb', 'standBottom', 'FFFFFF', 0.1, 'linear')
		doTweenColor('br', 'bird', 'FFFFFF', 0.1, 'linear')
		doTweenColor('Nsk', 'Nsky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('scr', 'screen', 'FFFFFF', 0.1, 'linear')
		doTweenColor('am', 'main', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 0.1, 'linear')
		doTweenColor('gary', 'gary', 'FFFFFF', 0.1, 'linear')
		doTweenColor('dan', 'dan', 'FFFFFF', 0.1, 'linear')
		setProperty('lights.visible', true)
		setProperty('inCutscene', false)
		setProperty('boyfriend.stunned', false)
		setProperty('unskip', false)
		activate = true
		cantpause = false
	end
	if curStep >= 430 and not hasCachedMid then
		cacheMidVideo('mid-homestretch')
		hasCachedMid = true
	end
	if curStep == 640 then
		triggerEvent('Camera Follow Pos', '696', '406')
	end
	if curStep == 653 then
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 656 then
		cameraShake('camGame', 0.05, 0.2)
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 0.15)
		end
		triggerEvent('Change Character', '0', 'VoltzPlayableGlasses')
		triggerEvent('Change Character', '1', 'bf-opponentGlasses')
		setProperty('lights.visible', false)
		addGrayscaleEffect('camGame')
		addGrayscaleEffect('camHUD')
		doTweenY('b1', 'bar1', -15, 0.1, 'quadOut')
		doTweenY('b2', 'bar2', 620, 0.1, 'quadOut')
		activate = false
	end
	if curStep == 720 then
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 0.15)
		end
		cameraShake('camGame', 0.05, 0.2)
		addVCREffect('game', 0.1, false, false, false)
		setProperty('sepiaFilter.visible', true)
		setProperty('theVig', true)
		--theVig = true
	end
	if curStep == 784 then
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		cameraShake('camGame', 0.05, 0.2)
		triggerEvent('Change Character', '0', 'VoltzPlayableGlassesTangrooveAlt')
		triggerEvent('Change Character', '1', 'bf-opponentGlassesTangrooveAlt')
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'LC', false)
		setProperty('lightIn.alpha', 1)
		setProperty('lightInB.alpha', 1)
		triggerEvent('Camera Follow Pos', '696', '406')
		clearEffects('game')
		clearEffects('hud')
		doTweenColor('gf', 'gfGroup', '000000', 0.1, 'linear')
		doTweenColor('st', 'standTop', '000000', 0.1, 'linear')
		doTweenColor('sb', 'standBottom', '000000', 0.1, 'linear')
		doTweenColor('br', 'bird', '000000', 0.1, 'linear')
		doTweenColor('Nsk', 'Nsky', '000000', 0.1, 'linear')
		doTweenColor('sk', 'sky', '000000', 0.1, 'linear')
		doTweenColor('scr', 'screen', '000000', 0.1, 'linear')
		doTweenColor('am', 'main', '000000', 0.1, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', '000000', 0.1, 'linear')
		doTweenColor('cr1', 'crowdTopRight', '000000', 0.1, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', '000000', 0.1, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', '000000', 0.1, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', '000000', 0.1, 'linear')
		doTweenColor('gary', 'gary', '000000', 0.1, 'linear')
		doTweenColor('dan', 'dan', '000000', 0.1, 'linear')
		doTweenAlpha('lI0', 'lightIn', 1, 0.1)
		doTweenAlpha('lI1', 'lightInB', 1, 0.1)
		setProperty('sepiaFilter.visible', false)
		doTweenY('ST', 'ST', 2500, 20, 'linear')
		setProperty('ST.visible', true)
		setProperty('bar1.visible', false)
		setProperty('bar2.visible', false)
		clearEffects('game')
		clearEffects('hud')
	end
	if curStep == 840 then
		setObjectOrder('stars', getObjectOrder('gfGroup') + 1)
	end
	if curStep == 848 then
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		cameraShake('camGame', 0.05, 0.2)
		triggerEvent('Change Character', '0', 'VoltzPlayableGlassesFizzAlt')
		triggerEvent('Change Character', '1', 'bf-opponentGlassesFizzAlt')
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'LC', false)
		setProperty('ST.visible', false)
		setObjectOrder('stars', getObjectOrder('gfGroup') + 1)
		setProperty('stars.visible', true)
		scaleObject('stars', 4.5, 4.5)
		doTweenY('starSlideD', 'stars', -2888, 22.6, 'linear')
		addChromaticAbberationEffect('game', 0.0025)
	end
	if curStep == 912 then
		setProperty('unskip', true)
		cantpause = true
		doTweenAlpha('cfcut', 'camHUD', 0, 1, 'linear')
		for note=0,7 do
			noteTweenAlpha('noteLeave'..note, note, 0, 1, 'linear')
		end
		setProperty('timeBar.visible', false)
		setProperty('timeBarBG.visible', false)
		setProperty('timeTxt.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)
		setProperty('scoreTxt.visible', false)
		clearEffects('hud')
		clearEffects('game')
		setProperty('lightIn.alpha', 0)
		setProperty('lightInB.alpha', 0)
		setProperty('sepiaFilter.visible', false)
		setProperty('stars.visible', false)
		doTweenAlpha('lI0', 'lightIn', 0, 0.1)
		doTweenAlpha('lI1', 'lightInB', 0, 0.1)
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 1100 then
		--unstun player
		setProperty('inCutscene', false)
		setProperty('boyfriend.stunned', false)
	end
	if curStep == 1152 then
		doTweenAlpha('cfcut2', 'camHUD', 1, 1.5, 'linear')
	end
	if curStep == 1160 then
		for note=6,7 do
			noteTweenAlpha('noteEnt'..note, note, 1, 0.1, 'quadInOut')
		end
	end
	if curStep == 1162 then
		for note=4,5 do
			noteTweenAlpha('noteEnt2'..note, note, 1, 0.1, 'quadInOut')
		end
	end
	if curStep == 1164 then
		for note=2,3 do
			noteTweenAlpha('noteLeave3'..note, note, 1, 0.1, 'quadInOut')
		end
	end
	if curStep == 1166 then
		for note=0,1 do
			noteTweenAlpha('noteLeave'..note, note, 1, 0.1, 'quadInOut')
		end
	end
	if curStep == 1146 then
		triggerEvent('Change Character', '0', 'VoltzHomestretchHyped')
		triggerEvent('Change Character', '1', 'bf-homestretchHyped')
		setProperty('lights.visible', true)
		activate = true
		doTweenColor('dad', 'dadGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('st', 'standTop', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sb', 'standBottom', 'FFFFFF', 0.1, 'linear')
		doTweenColor('br', 'bird', 'FFFFFF', 0.1, 'linear')
		doTweenColor('Nsk', 'Nsky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('scr', 'screen', 'FFFFFF', 0.1, 'linear')
		doTweenColor('am', 'main', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 0.1, 'linear')
		doTweenColor('gary', 'gary', 'FFFFFF', 0.1, 'linear')
		doTweenColor('dan', 'dan', 'FFFFFF', 0.1, 'linear')
	end
	if curStep == 1150 then
		--unstun player
		setProperty('inCutscene', false)
		setProperty('boyfriend.stunned', false)
	end
	if curStep == 1168 then
		setProperty('unskip', false)
		cantpause = false
		setProperty('timeBar.visible', true)
		setProperty('timeBarBG.visible', true)
		setProperty('timeTxt.visible', true)
		setProperty('iconP1.visible', true)
		setProperty('iconP2.visible', true)
		setProperty('healthBar.visible', true)
		setProperty('healthBarBG.visible', true)
		setProperty('scoreTxt.visible', true)
		if flashingLights then
			cameraFlash('hud', 'FFFFFF', 0.15)
		end
	end
	if curStep == 1364 then
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 1408 then
		doTweenAlpha('l', 'lights', 0, 0.3, 'linear')
		activate = false
		triggerEvent('Change Character', '0', 'voltzLosesHisShit')
		triggerEvent('Play Animation', '1', 'bf')
		doTweenColor('dad', 'dadGroup', '000000', 0.5, 'linear')
		doTweenColor('gf', 'gfGroup', '000000', 0.5, 'linear')
		doTweenColor('st', 'standTop', '000000', 0.5, 'linear')
		doTweenColor('sb', 'standBottom', '000000', 0.5, 'linear')
		doTweenColor('br', 'bird', '000000', 0.5, 'linear')
		doTweenColor('Nsk', 'Nsky', '000000', 0.5, 'linear')
		doTweenColor('sk', 'sky', '000000', 0.5, 'linear')
		doTweenColor('scr', 'screen', '000000', 0.5, 'linear')
		doTweenColor('am', 'main', '000000', 0.5, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', '000000', 0.5, 'linear')
		doTweenColor('cr1', 'crowdTopRight', '000000', 0.5, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', '000000', 0.5, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', '000000', 0.5, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', '000000', 0.5, 'linear')
		doTweenColor('gary', 'gary', '000000', 0.5, 'linear')
		doTweenColor('dan', 'dan', '000000', 0.5, 'linear')
	end
	if curStep == 1412 then
		triggerEvent('Play Animation', '2', 'bf')
	end
	if curStep == 1416 then
		triggerEvent('Play Animation', '3', 'bf')
	end
	if curStep == 1420 then
		triggerEvent('Play Animation', '4', 'bf')
	end
	if curStep == 1424 then
		triggerEvent('Change Character', '2', 'gf-cat-glow')
		addChromaticAbberationEffect('game', 0.0025)
		setProperty('bird.visible', false)
		setProperty('static.visible', true)
		setProperty('glow', true)
		setProperty('theVig', false)
		--theVig = false
		addLuaSprite('vignette', true)
		doTweenAlpha('l', 'lights', 0.5, 0.1, 'linear')
		doTweenAlpha('vig', 'vignette', 1, 0.1, 'linear')
		doTweenColor('dad', 'dadGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('st', 'standTop', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sb', 'standBottom', 'FFFFFF', 0.1, 'linear')
		doTweenColor('br', 'bird', 'FFFFFF', 0.1, 'linear')
		doTweenColor('Nsk', 'Nsky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('scr', 'screen', 'FFFFFF', 0.1, 'linear')
		doTweenColor('am', 'main', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 0.1, 'linear')
		doTweenColor('gary', 'gary', 'FFFFFF', 0.1, 'linear')
		doTweenColor('dan', 'dan', 'FFFFFF', 0.1, 'linear')
		activate = true
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		cameraShake('camGame', 0.05, 0.2)
		triggerEvent('Change Character', '1', 'bf-homestretchShock')
		triggerEvent('Play Animation', 'shock', 'dad')
		runTimer('shockDelay', 6.6)
	end
	if curStep == 1936 then -- section 121
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		clearEffects('game')
		setProperty('lights.visible', false)
		setProperty('gr.visible', false)
		doTweenAlpha('vig', 'vignette', 0, 0.1, 'linear')
		activate = false
		triggerEvent('Camera Follow Pos', '696', '406')
		triggerEvent('Change Character', '2', 'gf-cat')
		triggerEvent('Change Character', '0', 'godVoltz-noglow')
		triggerEvent('Change Character', '1', 'bf-homestretchFinal-noglow')
	end
	if curStep == 1968 then
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 0.15)
		end
		setProperty('camHUD.visible', false)
		setProperty('camGame.visible', false)
		makeLuaSprite('sc', 'stageclear', 0, 0)
		setObjectCamera('sc', 'other')
		addLuaSprite('sc', true)
		characterPlayAnimation('godVoltzKi', 'idle', false)
	end
	if curStep == 1988 then
		doTweenAlpha('sc', 'sc', 0, stepCrochet / 1000 * 12, 'linear')
	end
end

function onTimerCompleted(name)
	if name == 'shockDelay' then
		triggerEvent('Change Character', '1', 'bf-homestretchFinal')
	end
	if name == 'fuckoff' then
		triggerEvent("Camera Follow Pos", "", "")
	end
end

function onPause()
	if cantpause then
		return Function_Stop
	end
	return Function_Continue
end

function onUpdate(el)
	if (curBeat > 340 and getProperty('newScriptThing')) then
		setProperty('newScriptThing',false)
		hasCachedMidMid = true
		hasCachedMid = true
		triggerEvent('Camera Follow Pos', '', '')
		setProperty('glow', false)
	end
	if getPropertyFromClass('GameOverSubstate', 'characterName') == 'godvoltzButDead' then
		if getProperty('boyfriend.animation.curAnim.name') == 'deathLoop' then
			setSoundVolume('', 0)
		end
	end

	--setProperty("vignetteLast.visible", theVig)
end

function onUpdatePost(el)
	if curStep == 784 then
		for s = 0, 3 do
			setPropertyFromGroup('opponentStrums', s, 'texture', 'blueNotes')
			setPropertyFromGroup('playerStrums', s, 'texture', 'orangeNotes')
		end
	end
	if curStep == 848 then
		for s = 0, 3 do
			setPropertyFromGroup('playerStrums', s, 'texture', 'NOTE_assets')
			setPropertyFromGroup('opponentStrums', s, 'texture', 'NOTE_assets')
		end
	end
end

function onGameOver() -- Fix BF being off center on Death
	setCharacterY('boyfriend', getCharacterY('boyfriend') - 55)
	return Function_Continue;
end