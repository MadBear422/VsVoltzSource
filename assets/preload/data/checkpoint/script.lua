local playedVideo = false;
function onStartCountdown()
	if not playedVideo and not seenCutscene then -- Block the first countdown and play video cutscene
		--setProperty('unskip', true)
		--cantpause = true
		--startVideo('week1S')
		--playedVideo = true
		--return Function_Stop;
	end
	return Function_Continue;
end

function onCreate()
	makeLuaSprite('bar1', nil, 0, -100)
	makeLuaSprite('bar2', nil, 0, 720)
	makeGraphic('bar1', screenWidth, 100, '000000')
	makeGraphic('bar2', screenWidth, 100, '000000')
	setObjectCamera('bar1', 'hud')
	setObjectCamera('bar2', 'hud')
	addLuaSprite('bar1', false)
	addLuaSprite('bar2', false)
	addCharacterToList('checkpointBF')
	addCharacterToList('voltzPissed')
	
	setProperty('balloon.x', 260)
	precacheImage('VNUM1')
	precacheImage('Vnum2')
	precacheImage('Vnum3')
	precacheImage('buzz')
	precacheImage('VGO')
	precacheImage('Lights')
	precacheImage('lightCominIn')
	precacheImage('fireworks')
	
	makeLuaSprite('vignette', 'vig_filter', 0, 0)
	setObjectCamera('vignette', 'hud')
	setBlendMode('vignette', 'overlay')
	
	makeLuaSprite('WF', 'Whitefade', 0, 0)
	setObjectCamera('WF', 'hud')
	addLuaSprite('WF', true)
	setProperty('WF.alpha', 0)
	
	makeLuaSprite('gr', 'Gradiento', 0, 0)
	setObjectCamera('gr', 'hud')
	addLuaSprite('gr', true)
	doTweenColor('gr0', 'gr', 'FF0000', 4, 'linear')
	setProperty('gr.visible', false)
	
	makeLuaSprite('cool', 'lIGHTLEAKED_SPECS', -150, -150)
	setBlendMode('cool', 'overlay')
	scaleObject('cool', 8, 8)
	setProperty('cool.alpha', 0.5)
	
	makeAnimatedLuaSprite('lightIn', 'lightCominIn', -95, -100)
	makeAnimatedLuaSprite('lightInB', 'lightCominIn', 715, -100)
	addAnimationByPrefix('lightIn', 'LC', 'light come in', 24, false)
	addAnimationByIndices('lightIn', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByIndices('lightInB', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByPrefix('lightInB', 'LC', 'light come in', 24, false)
	setBlendMode('lightIn', 'add')
	setBlendMode('lightInB', 'add')
	setProperty('lightIn.alpha', 0.4)
	setProperty('lightInB.alpha', 0.4)
	
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
		setObjectOrder('fireworks'..f, getObjectOrder('crowdLeft') - 1)
		setProperty('fireworks'..f..'.visible', false)
	end
	makeAnimatedLuaSprite('lights', 'lights', -75, -100)
	scaleObject('lights', 2, 2)
	setProperty('lights.alpha', 0.5)
	addAnimationByPrefix('lights', 'Lights', 'lights', 24, true)
	objectPlayAnimation('lights', 'Lights', true)
	setBlendMode('lights', 'add')
	doTweenAlpha('lI', 'lightInB', 0, 0.4, 'linear')
end

function onDialogue()
	cacheVideo('week1End')
end

function onTweenCompleted(t)
	if t == 'gr0' then
		doTweenColor('gr1', 'gr', '0085FF', 4, 'linear')
	elseif t == 'gr1' then
		doTweenColor('gr0', 'gr', 'FF0000', 4, 'linear')
	end
end

function onSongStart()
	for f = 0,7 do
		setProperty('fireworks'..f..'.visible', true)
	end
	setProperty('lights0.alpha', 0.5)
	setProperty('lights1.x', 1050)
	setProperty('lights1.flipX', true)
	setProperty('lights1.alpha', 0.5)
	setProperty('lights2.alpha', 0)
	setProperty('lights3.alpha', 0)
	doTweenX('bal', 'balloon', 960, 240, 'linear')
	doTweenAlpha('crowdLeave', 'crowdDummy', 0.0, 8, 'linear')
	objectPlayAnimation('crowdDummy', 'crowd guys leaving', false)
	if isStoryMode then
		setProperty('fakeN2.offset.y', 45)
	end
end

local activate = false
local spr = 5
function onBeatHit()
	if curBeat == 4 then
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
	end
	if curBeat == 36 then
		if flashingLights then
		cameraFlash('game', 'FFFFFF', 0.15)
		end
	end
	if activate then
		spr = getRandomInt(0, 7)
		math.randomseed(curStep * 4)
		x = getRandomInt(-900, 530)
		y = getRandomInt(-720, -400)
		sc = getRandomFloat(0.5, 1)
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
end

function onEvent(n, v1, v2)
	if n == 'Change Crowd Idle' then
		activate = true
		if flashingLights then
		cameraFlash('other', 'FFFFFF', 0.15)
		end
		setObjectOrder('lights', getObjectOrder('crowdLeft') - 1)
		doTweenColor('bf', 'boyfriendGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('dad', 'dadGroup', 'FFFFFF', 0.1, 'linear')
		doTweenAlpha('game', 'camGame', 1, 0.1, 'linear')
		doTweenAlpha('hud', 'camHUD', 1, 0.1, 'linear')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('bl', 'balloon', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cl', 'cloud', 'FFFFFF', 0.1, 'linear')
		doTweenColor('bg', 'bg', 'FFFFFF', 0.1, 'linear')
		doTweenColor('GL', 'gymLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('GR', 'gymRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('crl', 'crowdLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('crr', 'crowdRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('la', 'land', 'FFFFFF', 0.1, 'linear')
		doTweenY('b1', 'bar2', 1500, 0.1, 'quadIn')
		doTweenY('b2', 'bar1', -500, 0.1, 'quadIn')
		setProperty('vignette.visible', false)
	end
	if n == 'light' then
		if v1 == '1' then
			addLuaSprite('vignette', true)
			setProperty('vignette.visible', true)
			addLuaSprite('lightIn', true)
			addLuaSprite('lightInB', true)
			objectPlayAnimation('lightIn', 'LC', false)
			objectPlayAnimation('lightInB', 'F', false)
			doTweenAlpha('lIA', 'lightIn', 0.4, 0.4, 'linear')
			doTweenAlpha('lIBA', 'lightInB', 0, 0.4, 'linear')
		elseif v1 == '2' then
			objectPlayAnimation('lightIn', 'F', false)
			objectPlayAnimation('lightInB', 'LC', false)
			doTweenAlpha('lIA', 'lightIn', 0, 0.4, 'linear')
			doTweenAlpha('lIBA', 'lightInB', 0.4, 0.4, 'linear')
		elseif v1 == '3' then
			objectPlayAnimation('lightIn', 'F', false)
			objectPlayAnimation('lightInB', 'F', false)
			doTweenAlpha('lIA', 'lightIn', 0, 0.1, 'linear')
			doTweenAlpha('lIBA', 'lightInB', 0, 0.1, 'linear')
		elseif v1 == '4' then
			objectPlayAnimation('lightIn', 'LC', false)
			doTweenAlpha('lIA', 'lightIn', 0.4, 0.4, 'linear')
		end
	end
	if n == 'clearEffs' then
		setProperty('vignette.visible', true)
		setProperty('lights.visible', false)
		activate = false
	end
	if n == 'flash' then
		if v1 == '5' then
			activate = true
			setProperty('lights.visible', true)
			doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'linear')
			doTweenColor('bl', 'balloon', 'FFFFFF', 0.1, 'linear')
			doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'linear')
			doTweenColor('cl', 'cloud', 'FFFFFF', 0.1, 'linear')
			doTweenColor('bg', 'bg', 'FFFFFF', 0.1, 'linear')
			doTweenColor('GL', 'gymLeft', 'FFFFFF', 0.1, 'linear')
			doTweenColor('GR', 'gymRight', 'FFFFFF', 0.1, 'linear')
			doTweenColor('crl', 'crowdLeft', 'FFFFFF', 0.1, 'linear')
			doTweenColor('crr', 'crowdRight', 'FFFFFF', 0.1, 'linear')
			doTweenColor('la', 'land', 'FFFFFF', 0.1, 'linear')
		end
	end
end

local cantpause = false
function onStepHit()
	if curStep == 271 then
		doTweenY('b1', 'bar1', -15, 4, 'quadInOut')
		doTweenY('b2', 'bar2', 620, 4, 'quadInOut')
		doTweenColor('bf', 'boyfriendGroup', '000000', 10, 'linear')
		doTweenColor('gf', 'gfGroup', '000000', 10, 'linear') 
		doTweenColor('bl', 'balloon', '000000', 10, 'linear')
		doTweenColor('sk', 'sky', '000000', 10, 'linear')
		doTweenColor('cl', 'cloud', '000000', 10, 'linear')
		doTweenColor('bg', 'bg', '000000', 10, 'linear')
		doTweenColor('GL', 'gymLeft', '000000', 10, 'linear')
		doTweenColor('GR', 'gymRight', '000000', 10, 'linear')
		doTweenColor('crl', 'crowdLeft', '000000', 10, 'linear')
		doTweenColor('crr', 'crowdRight', '000000', 10, 'linear')
		doTweenColor('la', 'land', '000000', 10, 'linear')
	end
	if curStep == 336 then
		doTweenColor('bf', 'boyfriendGroup', 'FFFFFF', 0.2, 'linear')
	end
	if curStep == 382 then
		doTweenColor('bf', 'boyfriendGroup', '000000', 0.1, 'linear')
		doTweenColor('dad', 'dadGroup', '000000', 0.1, 'linear')
		doTweenAlpha('gam', 'camGame', 0, 0.3, 'linear')
		doTweenAlpha('hud', 'camHUD', 0, 0.3, 'linear')
		doTweenColor('gf', 'gfGroup', '000000', 0.1, 'linear') 
		doTweenColor('bl', 'balloon', '000000', 0.1, 'linear')
		doTweenColor('sk', 'sky', '000000', 0.1, 'linear')
		doTweenColor('cl', 'cloud', '000000', 0.1, 'linear')
		doTweenColor('bg', 'bg', '000000', 0.1, 'linear')
		doTweenColor('GL', 'gymLeft', '000000', 0.1, 'linear')
		doTweenColor('GR', 'gymRight', '000000', 0.1, 'linear')
		doTweenColor('crl', 'crowdLeft', '000000', 0.1, 'linear')
		doTweenColor('crr', 'crowdRight', '000000', 0.1, 'linear')
		doTweenColor('la', 'land', '000000', 0.1, 'linear')
	end
	if curStep == 1040 then
		doTweenColor('bf', 'boyfriendGroup', '3A3A3A', stepCrochet / 1000 * 16 * 5, 'linear')
		doTweenColor('dad', 'dadGroup', 'FFFFFF', 0.1, 'linear')
		setProperty('lightIn.visible', false)
		setProperty('lightInB.visible', false)
		setProperty('vignette.visible', false)
	end
	if curStep == 1104 then
		doTweenColor('bf', 'dadGroup', '000000', stepCrochet / 1000 * 16 * 3.5, 'linear')
		doTweenColor('dad', 'boyfriendGroup', 'FFFFFF', 0.1, 'linear')
	end
	if curStep == 1167 then
		doTweenY('b1', 'bar1', -15, 0.1, 'linear')
		doTweenY('b2', 'bar2', 620, 0.1, 'linear')
	end
	if curStep == 1168 then
		doTweenColor('dad', 'dadGroup', 'FFFFFF', 0.1, 'linear')
	end
	if curStep == 1278 then
		doTweenY('b1', 'bar2', 1500, 6, 'quadIn')
		doTweenY('b2', 'bar1', -500, 6, 'quadIn')
	end
	if curStep == 1393 then
		doTweenAlpha('sl', 'lights', 0, stepCrochet / 1000 * 13, 'linear')
		activate = false
	end
	if curStep == 1407 then
		doTweenColor('dad', 'dadGroup', '000000', 0.5, 'linear') 
		doTweenColor('gf', 'gfGroup', '000000', 0.5, 'linear') 
		doTweenColor('bl', 'balloon', '000000', 0.5, 'linear')
		doTweenColor('sk', 'sky', '000000', 0.5, 'linear')
		doTweenColor('cl', 'cloud', '000000', 0.5, 'linear')
		doTweenColor('bg', 'bg', '000000', 0.5, 'linear')
		doTweenColor('GL', 'gymLeft', '000000', 0.5, 'linear')
		doTweenColor('GR', 'gymRight', '000000', 0.5, 'linear')
		doTweenColor('crl', 'crowdLeft', '000000', 0.5, 'linear')
		doTweenColor('crr', 'crowdRight', '000000', 0.5, 'linear')
		doTweenColor('la', 'land', '000000', 0.5, 'linear')
		triggerEvent('Change Character', '0', 'checkpointBF')
		triggerEvent('Play Animation', 'charge', 'bf')
	end
	if curStep == 1424 then
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		triggerEvent('Change Character', '1', 'voltzPissed')
		setProperty('WF.alpha', 0.3)
		setProperty('gr.visible', true)
		setObjectOrder('cool', getObjectOrder('crowdLeft') + 1)
		activate = true
		setProperty('lights.visible', true)
		setProperty('lights.alpha', 0.5)
		doTweenY('cl1', 'cool', -5960, 70, 'linear')
		doTweenX('cl2', 'cool', -360, 30, 'linear')
		doTweenAlpha('wf0', 'WF', 0.1, 20, 'linear')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'linear')
		doTweenColor('bl', 'balloon', 'FFFFFF', 0.1, 'linear')
		doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'linear')
		doTweenColor('cl', 'cloud', 'FFFFFF', 0.1, 'linear')
		doTweenColor('bg', 'bg', 'FFFFFF', 0.1, 'linear')
		doTweenColor('GL', 'gymLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('GR', 'gymRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('crl', 'crowdLeft', 'FFFFFF', 0.1, 'linear')
		doTweenColor('crr', 'crowdRight', 'FFFFFF', 0.1, 'linear')
		doTweenColor('la', 'land', 'FFFFFF', 0.1, 'linear')
	end
	if curStep == 1491 then
		triggerEvent('Play Animation', 'shock', 'dad')
	end
	if curStep == 1501 then
		triggerEvent('Play Animation', 'shock2', 'dad')
	end
	if curStep == 1520 then
		triggerEvent('Play Animation', 'shock3', 'dad')	
	end
	if curStep == 1664 then
		doTweenAlpha('whiteFade', 'white', 1, 1.75, 'linear')
	end
	if curStep == 1678 then
		setProperty('unskip', true)
		cantpause = true
		cameraFade('hud', '000000', 1.75, true)
	end
end


function onPause()
	if cantpause then
		return Function_Stop
	end
	return Function_Continue
end