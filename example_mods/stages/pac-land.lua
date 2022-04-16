function onCreate()
	getProperty('boyfriend.visible')

	makeLuaSprite('skyMain', 'bitchboy/sky', -900, -240)
	scaleObject('skyMain', 1, 1)
	setScrollFactor('skyMain', 0, 0.1)
	addLuaSprite('skyMain', false)

	makeLuaSprite('hillsBack', 'bitchboy/back_mountains', -300, -500)
	scaleObject('hillsBack', 1.12, 1.12)
	setScrollFactor('hillsBack', 1, 0.6)
	addLuaSprite('hillsBack', false)

	makeLuaSprite('hillsFront', 'bitchboy/front_mountains', -300, -400)
	scaleObject('hillsFront', 1.2, 1.2)
	addLuaSprite('hillsFront', false)

	if lowQuality == false then
		makeAnimatedLuaSprite('DK', 'bitchboy/dk_platform', 700, 100)
		addAnimationByPrefix('DK', 'dkBop', 'DONKYPLATFORM', 24, false)
		scaleObject('DK', 0.6, 0.6)
		addLuaSprite('DK', false)

		makeAnimatedLuaSprite('PacMen', 'bitchboy/pac_platform', 1300, 100)
		addAnimationByPrefix('PacMen', 'pacBop', 'PACPLATFORM', 24, false)
		scaleObject('PacMen', 0.6, 0.6)
		addLuaSprite('PacMen', false)

		runTimer('delay0', 0.5)
	end

	makeLuaSprite('groundMain', 'bitchboy/pac_land_stage', 0, 0)
	scaleObject('groundMain', 1.1, 1.1)
	addLuaSprite('groundMain', false)

	makeLuaSprite('nateEdit', 'bitchboy/clarence', 450, -330)
	scaleObject('nateEdit', 1.4, 1.4)
	precacheImage('nateEdit')

	setPropertyFromClass('GameOverSubstate', 'characterName', 'VoltzButDead')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'voltzGameOver')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'voltzGameOverEnd')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'voltz_death')

	doTweenAlpha('gfGoes', 'gfGroup', 0, 0.1, 'elasticOut')
end

function onBeatHit()
	objectPlayAnimation('DK', 'dkBop', false)
	objectPlayAnimation('PacMen', 'pacBop', false)

end

function onStepHit()

	if curStep == 886 then
		doTweenY('dkUp', 'DK', -400, 1.97, 'circOut')
		doTweenY('pacUp', 'PacMen', -350, 1.97, 'circOut')
	end

	if curStep == 1449 then
		doTweenX('pacRun', 'PacMen', 860, 0.1, 'elasticIn')
	end

	if curStep == 1451 then
		cameraShake('game', 0.1, 0.03)
		doTweenX('Dkbye', 'DK', -700, 0.2, 'bounceOut')
		doTweenY('DKbye2', 'DK', -1000, 0.2, 'bounceOut')
		addLuaSprite('nateEdit', true)
		doTweenAlpha('nateLeaves', 'dadGroup', 0, 0.1, 'elasticIn')
	end
end

function onMoveCamera(focus)
	if focus == 'boyfriend' then
		setProperty('camFollow.y', getProperty('camFollow.y') + 100)
	end
end