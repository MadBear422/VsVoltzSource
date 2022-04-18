function onCreate()
	addCharacterToList("bf-spotlight", 'boyfriend')
	addCharacterToList("voltz-spotlight", 'dad')
	Y = -100
	
	makeAnimatedLuaSprite('lightIn', 'lightCominIn', -95, Y)
	makeAnimatedLuaSprite('lightInB', 'lightCominIn', 825, Y)
	addAnimationByPrefix('lightIn', 'LC', 'light come in', 24, false)
	addAnimationByIndices('lightIn', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByIndices('lightInB', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByPrefix('lightInB', 'LC', 'light come in', 24, false)
	setBlendMode('lightIn', 'add')
	setBlendMode('lightInB', 'add')
	
	makeLuaSprite('ST', 'stars', getProperty('lightIn.x') - 50, Y - 2100)
	
	makeLuaSprite('fakeobj', 'combo', 0, 0)
	setProperty('fakeobj.alpha', 1)
	
	scaleObject('ST', 3, 3)
	setProperty('fakeobj.visible', true)
	setProperty('lightIn.alpha', 0.6)
	setProperty('lightInB.alpha', 0.6)
	setProperty('balloon.x', 960)
	precacheImage('lightCominIn')
	precacheImage('blueSplashes')
	precacheImage('blueNotes')
	precacheImage('orangeNotes')
	addLuaSprite('ST', false)
end

function onSongStart()
	doTweenX('bal', 'balloon', 260, 120, 'linear')
end

local F0 = false
local F1 = false
function onUpdatePost()
	for i = 0, getProperty('notes.length') - 1 do
		if not getPropertyFromGroup('notes', i, 'mustPress') then
			setPropertyFromGroup('notes', i, 'visible', getProperty('fakeobj.visible'))
		end
	end
	if F0 and getProperty('lightIn.animation.curAnim.finished') then
		characterPlayAnim('dad', 'idle', true)
		F0 = false
	end
	if F1 and getProperty('lightInB.animation.curAnim.finished') then
		characterPlayAnim('boyfriend', 'idle', true)
		F1 = false
	end
	if curStep == 576 then
		for s = 0, 3 do
			setPropertyFromGroup('playerStrums', s, 'texture', 'blueNotes')
			setPropertyFromGroup('opponentStrums', s, 'texture', 'orangeNotes')
		end
		setProperty('fakeobj.visible', true)
	end
	if curStep == 570 then
		setProperty('fakeobj.visible', false)
	end
	if curStep == 832 then
		for s = 0, 3 do
			setPropertyFromGroup('playerStrums', s, 'texture', 'NOTE_assets')
			setPropertyFromGroup('opponentStrums', s, 'texture', 'NOTE_assets')
		end
	end
	if curStep == 896 then
		removeLuaSprite('LightIn', true)
		removeLuaSprite('LightInB', true)
		removeLuaSprite('ST', true)
	end
end

function onStepHit()
	if curStep == 256 then
		setProperty('defaultCamZoom', 1.1)
	end
	if curStep == 320 then
		setProperty('defaultCamZoom', 0.85)
	end
	--
	if curStep == 576 then
		setProperty('defaultCamZoom', 1.2)
		triggerEvent("Change Character", "dad", "voltz-spotlight")
		triggerEvent("Change Character", "BF", "bf-spotlight")
		setProperty('timeBar.visible', false)
		setProperty('timeBarBG.visible', false)
		setProperty('timeTxt.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)
		setProperty('scoreTxt.visible', false)
		setProperty('iconP2.visible', false)
		setProperty('gfGroup.visible', false)
		setProperty('balloon.visible', false)
		setProperty('sky.visible', false)
		setProperty('cloud.visible', false)
		setProperty('bg.visible', false)
		setProperty('gymLeft.visible', false)
		setProperty('gymRight.visible', false)
		setProperty('crowd.visible', false)
		--setProperty('crowdLeft.visible', false)
		--setProperty('crowdRight.visible', false)
		setProperty('land.visible', false)
		setProperty('fakeobj.visible', true)
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		addLuaSprite('lightIn', true)
		objectPlayAnimation('lightIn', 'LC', false)
	end
	--
	if curStep == 640 then
		addLuaSprite('lightInB', true)
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 704 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		doTweenY('ST', 'ST', 1000, 20, 'linear')
		F1 = true
	end
	if curStep == 706 then -- duet section
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 708 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		F1 = true
	end
	if curStep == 710 then
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 712 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		F1 = true
	end
	if curStep == 714 then
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 716 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		F1 = true
	end
	if curStep == 718 then
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 720 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		F1 = true
	end
	if curStep == 722 then
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 724 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		F1 = true
	end
	if curStep == 726 then
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 728 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		F1 = true
	end
	if curStep == 730 then
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 732 then
		objectPlayAnimation('lightIn', 'LC', false)
		objectPlayAnimation('lightInB', 'F', false)
		F1 = true
	end
	if curStep == 734 then
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
		F0 = true
	end
	if curStep == 736 then
		objectPlayAnimation('lightInB', 'LC', false)
	end
	if curStep == 752 then
		objectPlayAnimation('lightIn', 'LC', false)
	end
	if curStep == 800 then
		objectPlayAnimation('lightInB', 'F', false)
		doTweenAlpha('STA', 'ST', 0, 2, 'linear')
	end
	if curStep == 816 then
		objectPlayAnimation('lightInB', 'LC', false)
	end
	if curStep == 832 then
		doTweenAlpha('hudLeaves', 'camHUD', 0, 0.25, 'quadOut')
		objectPlayAnimation('lightInB', 'F', false)
		objectPlayAnimation('lightIn', 'F', false)
		setProperty('boyfriend.visible', false)
		setProperty('dad.visible', false)
		doTweenAlpha('LI', 'lightIn', 0, 0.3, 'linear')
		doTweenAlpha('LIB', 'lightInB', 0, 0.3, 'linear')
		setProperty('defaultCamZoom', 0.85)
		removeLuaSprite('LightIn', true)
		removeLuaSprite('LightInB', true)
		removeLuaSprite('ST', true)
	end
	if curStep == 896 then
		triggerEvent("Change Character", "dad", "voltz")
		triggerEvent("Change Character", "BF", "bf-voltz")
		doTweenAlpha('hudReturns', 'camHUD', 1, 0.1, 'elasticIn')
		setProperty('boyfriend.visible', true)
		setProperty('dad.visible', true)
		setProperty('timeBar.visible', true)
		setProperty('timeBarBG.visible', true)
		setProperty('timeTxt.visible', true)
		setProperty('iconP1.visible', true)
		setProperty('healthBar.visible', true)
		setProperty('healthBarBG.visible', true)
		setProperty('scoreTxt.visible', true)
		setProperty('iconP2.visible', true)
		setProperty('gfGroup.visible', true)
		setProperty('balloon.visible', true)
		setProperty('sky.visible', true)
		setProperty('cloud.visible', true)
		setProperty('bg.visible', true)
		setProperty('gymLeft.visible', true)
		setProperty('gymRight.visible', true)
		setProperty('crowd.visible', true)
		--setProperty('crowdLeft.visible', true)
		--setProperty('crowdRight.visible', true)
		setProperty('land.visible', true)
		if flashingLights then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		removeLuaSprite('LightIn', true)
		removeLuaSprite('LightInB', true)
		removeLuaSprite('ST', true)
	end
end