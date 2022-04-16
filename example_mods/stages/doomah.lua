function onCreate()
	makeLuaSprite('general', 'voltz/general', -140, 600)
	scaleObject('general', 1, 1)
	addLuaSprite('general', false)
	doTweenY('rrr', 'camGame', 1000, 0.001, 'linear')
	doTweenAlpha('voltzDC', 'boyfriendGroup', 0, 0.1, 'linear')
	doTweenAlpha('tossDC', 'dadGroup', 0, 0.1, 'linear')
	precacheSound('connect')

	setPropertyFromClass('GameOverSubstate', 'characterName', 'tallvoltzmic')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'twomah-retry')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'twomah-death')
end

function onStepHit()
	if curStep == 48 then
		doTweenY('rxr', 'camGame', 0, 4, 'circOut')
	end
	if curStep == 64 then
		doTweenAlpha('voltzRC', 'boyfriendGroup', 1, 0.1, 'elasticOut')
		doTweenAlpha('tossRC', 'dad', 1, 0.1, 'bounceIn')
		playSound('connect', 0.8)
	end
end