function onCreate()
	makeLuaSprite('bar1', nil, 0, -100)
	makeLuaSprite('bar2', nil, 0, 720)
	makeGraphic('bar1', screenWidth, 100, '000000')
	makeGraphic('bar2', screenWidth, 100, '000000')
	setObjectCamera('bar1', 'hud')
	setObjectCamera('bar2', 'hud')
	addLuaSprite('bar1', false)
	addLuaSprite('bar2', false)
		
	setProperty('bar1.y', 620)
	setProperty('bar2.y', -15)

	setProperty('balloon.x', 260)
	
	addCharacterToList('voltz')
	addCharacterToList('bf-voltz')

	runTimer('startDelay', 0.53)
	
	setProperty('white.visible', false)
	setProperty('bar1.visible', false)
	setProperty('bar2.visible', false)
	setProperty('crowdLeft.y', 610)
	setProperty('crowdRight.y', 610)
end

function onStepHit()
	if curStep == 1086 then
		setProperty('bar1.visible', false)
		setProperty('bar2.visible', false)
		if flashingLights then
		cameraFlash('hud', 'FFFFFF', 0.15)
		end
		clearEffects('camHUD')
		clearEffects('camGame')
		triggerEvent("Add Camera Zoom")
	end
end

function onEvent(name, v1, v2)
	if name == 'off' then
		doTweenY('b1', 'bar1', 1500, 2, 'quadIn')
		doTweenY('b2', 'bar2', -500, 2, 'quadIn')
		doTweenY('cr', 'crowdRight', 265, 1.4, 'quadOut')
		doTweenY('cl', 'crowdLeft', 240, 1.4, 'quadOut')
	elseif name == 'makeEffs' then
		setProperty('bar1.y', 620)
		setProperty('bar2.y', -15)
		setProperty('bar1.visible', true)
		setProperty('bar2.visible', true)
	elseif name == 'clearEffs' then
		setProperty('bar1.visible', false)
		setProperty('bar2.visible', false)
	end
end

function onSongStart()
	triggerEvent('Change Character', '1', 'voltz')
	triggerEvent('Change Character', '0', 'bf-voltz')
	if flashingLights then
	cameraFlash('hud', 'FFFFFF', 0.15)
	end
	addGrayscaleEffect('camGame')
	addGrayscaleEffect('camHUD')
	setProperty('bar1.visible', true)
	setProperty('bar2.visible', true)
	triggerEvent("Camera Follow Pos", "662.5", "345")
	doTweenX('bal', 'balloon', 960, 150, 'linear')
end

function onTimerCompleted(tag)
	if tag == 'startDelay' then
		-- triggerEvent('Play Animation', 'hey', 'dad')
		-- triggerEvent('Play Animation', 'hey', 'bf')
	end
end