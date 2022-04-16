function onCreate()
	addCharacterToList('bf-fizzAlt')
	addCharacterToList('fizzVoltz')
	addCharacterToList('bf-fizzSpotlight')
	addCharacterToList('fizzVoltzSpotlight')

	Y = -200

	makeAnimatedLuaSprite('lightIn', 'lightCominIn', 850, Y)
	makeAnimatedLuaSprite('lightInB', 'lightCominIn', -270, Y)
	addAnimationByPrefix('lightIn', 'LC', 'light come in', 24, false)
	addAnimationByIndices('lightIn', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByIndices('lightInB', 'F', 'light come in', '7, 3, 2, 0', 24)
	addAnimationByPrefix('lightInB', 'LC', 'light come in', 24, false)
	setBlendMode('lightIn', 'add')
	setBlendMode('lightInB', 'add')
	precacheImage('lightIn')
	precacheImage('lightInB')
	precacheImage('stars')

	
	setProperty('lightIn.alpha', 0.55)
	setProperty('lightInB.alpha', 0.55)
	scaleObject('lightIn', 1, 1.3)
	scaleObject('lightInB', 1, 1.3)
	triggerEvent('Camera Follow Pos', '696', '406')
end

function onCountdownTick(t) -- when done, copy this.
	if t == 1 then
		if not isStoryMode then
			setProperty('fakeN2.offset.y', 39.5)
			setProperty('fakeN2.offset.x', 54.5)
			setProperty('fakeN0.offset.x', 36)
			setProperty('fakeN0.offset.y', 19.5)
			setProperty('fakeNS2.offset.y', 39.5)
			setProperty('fakeNS2.offset.x', 54.5)
			setProperty('fakeNS0.offset.x', 36)
			setProperty('fakeNS0.offset.y', 19.5)
		else
			setProperty('fakeN2.offset.y', 44.5)
			setProperty('fakeN2.offset.x', 54.5)
			setProperty('fakeN0.offset.x', 36)
			setProperty('fakeN0.offset.y', 20.5)
			setProperty('fakeNS2.offset.y', 44.5)
			setProperty('fakeNS2.offset.x', 54.5)
			setProperty('fakeNS0.offset.x', 36)
			setProperty('fakeNS0.offset.y', 20.5)
		end
	end
end

function onSongStart()
	setObjectOrder('stars', getObjectOrder('gfGroup') + 1)
	triggerEvent('Camera Follow Pos', '361.5', '472.5')
	setProperty('fakeN2.offset.y', 39.5)
	removeLuaSprite('stars', false)
end

function onStepHit()
	if curStep == 3 then
		triggerEvent('Camera Follow Pos', '', '')
	end
	if curStep == 256 then
		doTweenColor('sk', 'sky', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('st0', 'standTop', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('st1', 'standBottom', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('br', 'bird', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('scr', 'screen', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('am', 'main', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr0', 'crowdTopLeft', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr1', 'crowdTopRight', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr2', 'crowdBottomLeft', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr3', 'crowdBottomRight', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr4', 'crowdTopLeftHand', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('gf', 'gfGroup', '161616', 0.1, 'sineIn')
		doTweenColor('gary', 'gary', '161616', 0.1, 'sineIn')
		doTweenColor('dan', 'dan', '161616', 0.1, 'sineIn')
		if flashingLights then
		cameraFlash('game', 'FFFFFF', 0.123)
		end
	end		
	if curStep == 278 then
		triggerEvent('Change Character', '0', 'fizzVoltz')
		triggerEvent('Play Animation', 'drink', 'bf')
	end
	if curStep == 316 then
		cameraShake('camGame', 0.05, 0.2)
	end
	if curStep == 320 then
		triggerEvent('Change Character', '1', 'bf-fizzSpotlight')
		triggerEvent('Change Character', '0', 'fizzVoltzSpotlight')
		characterPlayAnim('dad', 'shock')
		if flashingLights then
		cameraFlash('camGame', 'FFFFFF', 0.15)
		end
		addLuaSprite('lightIn', true)
		objectPlayAnimation('lightIn', 'LC', false)
		addChromaticAbberationEffect('game', 0.0025)
	end
	if curStep == 352 then
		addLuaSprite('lightInB', true)
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'LC', false)
	end
	if curStep == 354 then
		setProperty('lightIn.visible', false)
	end
	if curStep == 384 then
		objectPlayAnimation('lightIn', 'LC', false)
		setProperty('lightIn.visible', true)
	end
	if curStep == 446 then
		characterPlayAnim('dad', 'singDOWN-alt')		
		characterPlayAnim('bf', 'singDOWN-alt')	
	end
	if curStep == 448 then
		doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('st0', 'standTop', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('st1', 'standBottom', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('br', 'bird', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('scr', 'screen', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('am', 'main', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('bg', 'bgGroup', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('gary', 'gary', 'FFFFFF', 0.1, 'sineIn')  
		doTweenColor('dan', 'dan', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('lean', 'lean', 'FFFFFF', 0.1, 'sineIn')
		triggerEvent('Change Character', '1', 'bf-opponent')
		triggerEvent('Change Character', '0', 'voltzPlayable')
		objectPlayAnimation('lightIn', 'F', false)
		objectPlayAnimation('lightInB', 'F', false)
		setProperty('lightIn.visible', false)
		setProperty('lightInB.visible', false)
		cameraFlash('game', 'FFFFFF', 0.15)
		clearEffects('game')
	end
	if curStep == 576 then
		doTweenColor('sk', 'sky', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('st0', 'standTop', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('st1', 'standBottom', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('br', 'bird', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('scr', 'screen', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('am', 'main', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('cr0', 'crowdTopLeft', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('cr1', 'crowdTopRight', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('cr2', 'crowdBottomLeft', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('cr3', 'crowdBottomRight', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('cr4', 'crowdTopLeftHand', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('bg', 'bgGroup', '7F7F7F', 0.1, 'sineIn')
		doTweenColor('gf', 'gfGroup', 'A0A0A0', 0.1, 'sineIn')
		doTweenColor('gary', 'gary', 'BCBCBC', 0.1, 'sineIn')
		doTweenColor('dan', 'dan', 'BCBCBC', 0.1, 'sineIn')
		doTweenColor('lean', 'lean', 'BCBCBC', 0.1, 'sineIn')
		cameraFlash('game', 'FFFFFF', 0.12)
	end
	if curStep == 704 then
		cameraFlash('game', 'FFFFFF', 0.12)
		doTweenColor('sk', 'sky', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('st0', 'standTop', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('st1', 'standBottom', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('br', 'bird', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('scr', 'screen', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('am', 'main', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('bg', 'bgGroup', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.1, 'sineIn')
		doTweenColor('gary', 'gary', 'FFFFFF', 0.1, 'sineIn')  
		doTweenColor('dan', 'dan', 'FFFFFF', 0.1, 'sineIn')  
	end
	if curStep == 831 then
		doTweenColor('sk', 'sky', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('st0', 'standTop', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('st1', 'standBottom', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('br', 'bird', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('scr', 'screen', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('am', 'main', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr0', 'crowdTopLeft', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr1', 'crowdTopRight', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr2', 'crowdBottomLeft', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr3', 'crowdBottomRight', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('cr4', 'crowdTopLeftHand', '0A0A0A', 0.1, 'sineIn')
		doTweenColor('bg', 'bgGroup', '0A0A0A', 0.1, 'sineIn');
		doTweenColor('gf', 'gfGroup', '161616', 0.1, 'sineIn')
		doTweenColor('gary', 'gary', '161616', 0.1, 'sineIn')
		doTweenColor('dan', 'dan', '161616', 0.1, 'sineIn')

		cameraFlash('camHUD', 'FFFFFF', 0.15)
		doTweenAngle('camTilt', 'camHUD', 0, 0.1, 'elasticOut')
		triggerEvent('Change Character', '1', 'bf-fizzSpotlight')
		triggerEvent('Change Character', '0', 'fizzVoltzSpotlight')
		objectPlayAnimation('lightIn', 'LC', false)
		setProperty('lightIn.visible', true)
		addChromaticAbberationEffect('game', 0.0025)
	end		
	if curStep == 863 then
		objectPlayAnimation('lightInB', 'LC', false)
		objectPlayAnimation('lightIn', 'F', false)
		setProperty('lightInB.visible', true)
	end
	if curStep == 867 then
		setProperty('lightIn.visible', false)
	end
	if curStep == 895 then
		objectPlayAnimation('lightIn', 'LC', false)
		setProperty('lightIn.visible', true)
	end
	if curStep == 960 then
		setProperty('stars.visible', true)
		doTweenX('starSlide', 'stars', -2888, 22.6, 'linear')
		cameraFlash('game', 'FFFFFF', 0.15)
		setProperty('gf.visible', false)
		setProperty('sky.visible', false)
		setProperty('standBottom.visible', false)
		setProperty('standTop.visible', false)
		setProperty('screen.visible', false)
		setProperty('gary.visible', false)
		setProperty('crowdBottomLeft.visible', false)
		setProperty('crowdBottomRight.visible', false)
		setProperty('crowdTopLeft.visible', false)
		setProperty('crowdTopRight.visible', false)
		setProperty('main.visible', false)
		setProperty('dan.visible', false)
		setProperty('bgGroup.visible', false)
		doTweenColor('sk', 'sky', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('st0', 'standTop', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('st1', 'standBottom', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('br', 'bird', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('scr', 'screen', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('am', 'main', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('cr0', 'crowdTopLeft', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('cr1', 'crowdTopRight', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('cr2', 'crowdBottomLeft', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('cr3', 'crowdBottomRight', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('cr4', 'crowdTopLeftHand', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('gf', 'gfGroup', 'FFFFFF', 0.5, 'sineIn')
		doTweenColor('gary', 'gary', 'FFFFFF', 0.5, 'sineIn')  
		doTweenColor('dan', 'dan', 'FFFFFF', 0.5, 'sineIn')  
		doTweenColor('lean', 'lean', 'FFFFFF', 0.5, 'sineIn')  
		doTweenColor('bg', 'bgGroup', 'FFFFFF', 0.5, 'sineIn')
	end
	if curStep == 991 then
		objectPlayAnimation('lightIn', 'F', false)
	end
	if curStep == 994 then
		setProperty('lightIn.visible', false)
	end
	if curStep == 1023 then
		objectPlayAnimation('lightIn', 'LC', false)
		setProperty('lightIn.visible', true)
	end
	if curStep == 1088 then
		triggerEvent('Change Character', '0', 'fizzVoltz')
		triggerEvent('Change Character', '1', 'bf-fizzAlt')
		setProperty('gr.visible', false)
		cameraFlash('camGame', 'FFFFFF', 0.75)
		setProperty('gf.visible', true)
		setProperty('sky.visible', true)
		setProperty('standBottom.visible', true)
		setProperty('standTop.visible', true)
		setProperty('screen.visible', true)
		setProperty('gary.visible', true)
		setProperty('crowdBottomLeft.visible', true)
		setProperty('crowdBottomRight.visible', true)
		setProperty('crowdTopLeft.visible', true)
		setProperty('crowdTopRight.visible', true)
		setProperty('main.visible', true)
		setProperty('dan.visible', true)
		setProperty('bgGroup.visible', true)
		removeLuaSprite('lightIn', true)
		removeLuaSprite('lightInB', true)
		setProperty('stars.visible', false)
		clearEffects('game')

	end
	if curStep == 1216 then
		triggerEvent('Camera Follow Pos', '696', '406')
	end
end