function onCreate()
	makeLuaSprite('bar1', nil, 0, -100)
	makeLuaSprite('bar2', nil, 0, 720)
	makeGraphic('bar1', screenWidth, 100, '000000')
	makeGraphic('bar2', screenWidth, 100, '000000')
	setObjectCamera('bar1', 'hud')
	setObjectCamera('bar2', 'hud')
	addLuaSprite('bar1', false)
	addLuaSprite('bar2', false)
	
	addCharacterToList('bf-opponent')
	addCharacterToList('voltzPlayable')
	addCharacterToList('SANS')
	runTimer('bfStartDelay', 0.85)
	runTimer('voltzStartDelay', 1.9)

	makeLuaSprite('sepiaFilter', 'sepia', 0, 0)
	scaleObject('sepiaFilter', 1.5, 1.5)
	setObjectCamera('sepiaFilter', 'other')
	precacheImage('sepiaFilter')
	setBlendMode('sepiaFilter', 'overlay')

	makeLuaSprite('vig', 'vig_filter', 0, 0)
	scaleObject('vig', 1.5, 1.5)
	setObjectCamera('vig', 'other')
	setBlendMode('vig', 'overlay')
	precacheImage('vig')

	setProperty('crowdTopLeft.alpha', 0)
	setProperty('crowdTopRight.alpha', 0)
	setProperty('crowdBottomLeft.alpha', 0)
	setProperty('crowdBottomRight.alpha', 0)
	setProperty('crowdTopLeftHand.alpha', 0)
end

function onStartCountdown()
	characterPlayAnim('dad', 'idle')
	setProperty('camFollow.y', getProperty('camFollow.y') + 30)
end

function onCountdownTick(t) -- done, copy this.
	if t == 1 then
		if isStoryMode then
			setProperty('fakeN0.offset.y', 21)
			setProperty('fakeN0.offset.x', 36.5)
			setProperty('fakeN2.offset.y', 45)
		else
			setProperty('fakeN0.offset.x', 36.5)
			setProperty('fakeN2.offset.y', 35)
		end
	end
end

local greyscale = false
function onSongStart()
	triggerEvent('Change Character', '0', 'voltzPlayable')
	triggerEvent('Change Character', '1', 'bf-opponent')
	addGreyscaleEffect('game')
	addGreyscaleEffect('hud')
	addLuaSprite('sepiaFilter', true)
	addLuaSprite('vig', true)
	setProperty('sepiaFilter.alpha', 0.7)
	if flashingLights then
	cameraFlash('other', 'FFFFFF', 0.25)
	end
	addVCREffect('game', 0.1, false, false, false)
	cameraSetTarget('boyfriend')
	doTweenZoom('eZoom', 'camGame', 1, 0.1, 'quadIn')
	setProperty('defaultCamZoom', 1)
	setProperty('bar1.y', -15)
	setProperty('bar2.y', 620)
	greyscale = true
	setProperty('camFollow.y', getProperty('camFollow.y') + 30)
end

function onMoveCamera(focus)
	setProperty('camFollow.y', getProperty('camFollow.y') + 30)
end

function onStepHit()
	if curStep == 120 then
		triggerEvent('Camera Follow Pos', '770', '500')
		setProperty('defaultCamZoom', 0.6)
		doTweenY('b1', 'bar1', -100, 1, 'quadInOut')
		doTweenY('b2', 'bar2', 720, 1, 'quadInOut')
	end
	if curStep == 128 then
		setProperty('sepiaFilter.alpha', 0)
		setProperty('vig.alpha', 0)
		if flashingLights then
		cameraFlash('other', 'FFFFFF', 0.25)
		end
		clearEffects('game')
		clearEffects('hud')
		setProperty('crowdTopLeft.alpha', 1)
		setProperty('crowdTopRight.alpha', 1)
		setProperty('crowdBottomLeft.alpha', 1)
		setProperty('crowdBottomRight.alpha', 1)
		setProperty('crowdTopLeftHand.alpha', 1)
	end
	if curStep == 159 then
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 384 then
		addGreyscaleEffect('game')
		addGreyscaleEffect('hud')
		setProperty('vig.alpha', 1)
		setProperty('sepiaFilter.alpha', 0.7)
		if flashingLights then
		cameraFlash('other', 'FFFFFF', 0.25)
		end
		addVCREffect('game', 0.1, false, false, false)
		doTweenZoom('eZoom', 'camGame', 1, 0.1, 'quadIn')
		setProperty('defaultCamZoom', 1)
		setProperty('bar1.y', -15)
		setProperty('bar2.y', 620)
		greyscale = true
	end
	if curStep == 496 then
		triggerEvent('Change Character', '0', 'SANS')
		triggerEvent('Camera Follow Pos', '1156.5', '376')
		setProperty('cameraSpeed', 5)
		doTweenZoom('eZoom', 'camGame', 2.3, stepCrochet / 1000 * 16, 'quadIn')
		setProperty('sepiaFilter.alpha', 0)
		setProperty('vig.alpha', 0)
		clearEffects('game')
		clearEffects('hud')
		setProperty('bar1.visible', false) -- these bars are infuriatingly bad at changing positions
		setProperty('bar2.visible', false)
		greyscale = false
	end
	if curStep == 512 then
		setProperty('cameraSpeed', 1)
		triggerEvent('Change Character', '0', 'voltzPlayable')
		triggerEvent('Camera Follow Pos', '1156.5', '586')
		addGreyscaleEffect('game')
		addGreyscaleEffect('hud')
		setProperty('sepiaFilter.alpha', 0.7)
		setProperty('vig.alpha', 1)
		addVCREffect('game', 0.1, false, false, false)
		setProperty('bar1.visible', true)
		setProperty('bar2.visible', true)		
		greyscale = true
	end
	if curStep == 576 then
		triggerEvent('Camera Follow Pos', '361.5', '586')
	end
	if curStep == 640 then
		triggerEvent('Camera Follow Pos', '1056.5', '476')
		setProperty('sepiaFilter.alpha', 0)
		setProperty('vig.alpha', 0)
		if flashingLights then
		cameraFlash('other', 'FFFFFF', 0.25)
		end
		clearEffects('game')
		clearEffects('hud')
		setProperty('bar1.y', -100)
		setProperty('bar2.y', 720)
		setProperty('defaultCamZoom', 0.6)
		greyscale = false
	end
	if curStep == 767 then
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 768 then
		doTweenY('b1', 'bar1', -15, 1, 'quadOut')
		doTweenY('b2', 'bar2', 620, 1, 'quadOut')
		doTweenColor('sk', 'sky', 'A0A0A0', 3, 'linear')
		doTweenColor('st0', 'standTop', 'A0A0A0', 3, 'linear')
		doTweenColor('st1', 'standBottom', 'A0A0A0', 3, 'linear')
		doTweenColor('br', 'bird', 'A0A0A0', 3, 'linear')
		doTweenColor('scr', 'screen', 'A0A0A0', 3, 'linear')
		doTweenColor('am', 'main', 'A0A0A0', 3, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', 'A0A0A0', 3, 'linear')
		doTweenColor('cr1', 'crowdTopRight', 'A0A0A0', 3, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', 'A0A0A0', 3, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', 'A0A0A0', 3, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', 'A0A0A0', 3, 'linear')
	end
	if curStep == 896 then
		addGreyscaleEffect('game')
		addGreyscaleEffect('hud')
		setProperty('vig.alpha', 1)
		setProperty('sepiaFilter.alpha', 0.7)
		if flashingLights then
		cameraFlash('other', 'FFFFFF', 0.25)
		end
		addVCREffect('game', 0.1, false, false, false)
		doTweenZoom('eZoom', 'camGame', 1, 0.1, 'quadIn')
		setProperty('defaultCamZoom', 1)
		setProperty('bar1.y', -15)
		setProperty('bar2.y', 620)
		doTweenColor('sk', 'sky', 'FFFFFF', 3, 'linear')
		doTweenColor('st0', 'standTop', 'FFFFFF', 3, 'linear')
		doTweenColor('st1', 'standBottom', 'FFFFFF', 3, 'linear')
		doTweenColor('br', 'bird', 'FFFFFF', 3, 'linear')
		doTweenColor('scr', 'screen', 'FFFFFF', 3, 'linear')
		doTweenColor('am', 'main', 'FFFFFF', 3, 'linear')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 3, 'linear')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 3, 'linear')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 3, 'linear')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 3, 'linear')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 3, 'linear')
		greyscale = true
	end
	if curStep == 1152 then
		setProperty('sepiaFilter.alpha', 0)
		setProperty('vig.alpha', 0)
		if flashingLights then
		cameraFlash('other', 'FFFFFF', 0.25)
		end
		clearEffects('game')
		clearEffects('hud')
		setProperty('defaultCamZoom', 0.6)
		greyscale = false
		doTweenColor('sk', 'sky', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('st0', 'standTop', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('st1', 'standBottom', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('br', 'bird', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('scr', 'screen', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('am', 'main', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('cr0', 'crowdTopLeft', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('cr1', 'crowdTopRight', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('cr2', 'crowdBottomLeft', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('cr3', 'crowdBottomRight', 'A0A0A0', 0.01, 'quadInOut')
		doTweenColor('cr4', 'crowdTopLeftHand', 'A0A0A0', 0.01, 'quadInOut')
	end
	if curStep == 1280 then
		triggerEvent('Camera Follow Pos', '696', '406')
		doTweenY('b1', 'bar1', -100, 0.75, 'quadOut')
		doTweenY('b2', 'bar2', 720, 0.75, 'quadOut')
		doTweenColor('sk', 'sky', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('st0', 'standTop', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('st1', 'standBottom', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('br', 'bird', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('scr', 'screen', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('am', 'main', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 0.5, 'quadOut')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 0.5, 'quadOut')
	end
end

function onTimerCompleted(tag)
	if tag == 'bfStartDelay' then
		triggerEvent('Play Animation', 'swap', 'dad')
	end
	if tag == 'voltzStartDelay' then
		triggerEvent('Play Animation', 'spin', 'bf')
	end
end

function onGameOver()
	if greyscale then
		clearEffects('game')
		addGreyscaleEffect('game')
	end
	return Function_Continue;
end