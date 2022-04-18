local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not seenCutscene then --Block the first countdown
		startVideo('Movies/Rolecall', true);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onCreate()
	makeAnimatedLuaSprite('lightIn', 'lightCominIn', -408, Y)
	addAnimationByPrefix('lightIn', 'LC', 'light come in', 24, false)
	addAnimationByIndices('lightIn', 'F', 'light come in', '7, 3, 2, 0', 24)
	precacheImage('lightIn')
	scaleObject('lightIn', 2.4, 1.5)
	setProperty('lightIn.alpha', 0.25)

	makeLuaSprite('falling-shit', 'cheap-ass', -288, -1227)
	scaleObject('falling-shit', 1.7, 1.7)
	precacheImage('falling-shit')
	setBlendMode('falling-shit', 'add')
end

function onStepHit()
	if curStep == 511 then
		doTweenAlpha('voidFade', 'void', 0.75, 0.4, 'sineIn')
		objectPlayAnimation('lightIn', 'LC', false)
		addLuaSprite('lightIn', true)
		addLuaSprite('falling-shit', false)
		doTweenY('fallingShitFalls', 'falling-shit', 600, 30)
	end
	if curStep == 735 then
		doTweenAlpha('fallingShitDies', 'falling-shit', 0, 2.9)
	end
	if curStep == 764 then
		doTweenAlpha('voidFade', 'void', 0, 0.35, 'bounceOut')
		doTweenAlpha('lightsOn', 'lightIn', 0, 0.35, 'bounceIn')
	end
	if curStep == 767 then
		doTweenY('fallingShitFalls', 'falling-shit', -938, 3)		
	end

	if curStep == 1279 then
		if flashingLights == true then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		doTweenAlpha('voidFade', 'void', 0.75, 0.4, 'sineIn')
		objectPlayAnimation('lightIn', 'LC', false)
		doTweenAlpha('lightsOn', 'lightIn', 0.25, 0.1, 'quadIn')
		doTweenAlpha('fallingShitLives', 'falling-shit', 1, 0.1)
		doTweenY('fallingShitFalls', 'falling-shit', 600, 30)
	end
	if curStep == 1503 then
		doTweenAlpha('fallingShitDies', 'falling-shit', 0, 2.9)
	end
	if curStep == 1535 then
		doTweenAlpha('voidFade', 'void', 0, 0.35, 'bounceOut')
		doTweenAlpha('lightsOn', 'lightIn', 0, 0.35, 'bounceIn')
	end
	if curStep == 1535 then
		removeLuaSprite('falling-shit', true)	
	end

	if curStep == 1729 then
		if flashingLights == true then
			cameraFlash('game', 'FFFFFF', 0.15)
		end
		doTweenAlpha('voidFade', 'void', 1, 0.15, 'sineIn')
	end
	if curStep == 1759 then
		doTweenAlpha('hudFade', 'camHUD', 0, 1.41, 'linear')
		doTweenAlpha('bfFade', 'boyfriend', 0, 2.82, 'linear')
		doTweenAlpha('voltzFade', 'dad', 0, 2.82, 'linear')
	end
end