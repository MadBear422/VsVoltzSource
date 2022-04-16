function onCreate()
	makeLuaSprite('doomah', 'voltz/doomah', -100, 1400)
	scaleObject('doomah', 2.2, 2.2)
	makeLuaSprite('twomah', 'voltz/nutz', -100, 1400)
	scaleObject('twomah', 2.2, 2.2)
	makeLuaSprite('hamood', 'voltz/ha', -100, 1400)
	scaleObject('hamood', 2.2, 2.2)
	makeLuaSprite('dont', 'voltz/lyrics', 400, 1800)
	scaleObject('dont', 1.5, 1.5)
	doTweenAlpha('bitchBye', 'gf', 0, 0.005, 'linear')
end

local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not seenCutscene then --Block the first countdown
		startVideo('Twomah');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onStepHit()
	if curStep == 1010 then
		addLuaSprite('dont', true)
	end
	if curStep == 1018 then
		removeLuaSprite('dont', true)
		addLuaSprite('doomah', true)
		cameraShake("game", 0.04, 0.1)
	end
	if curStep == 1020 then
		removeLuaSprite('doomah', true)
		addLuaSprite('twomah', true)
		cameraShake("game", 0.04, 0.1)
	end
	if curStep == 1022 then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'tallvoltzsynth')
		removeLuaSprite('twomah', true)
		addLuaSprite('hamood', true)
		cameraShake("game", 0.04, 0.1)
	end
	if curStep == 1024 then
		removeLuaSprite('hamood', true)
		setProperty('defaultCamZoom', 0.87)
	end
end