function onCreate()
	addCharacterToList('voltzFresh1')
	addCharacterToList('voltzFresh2')
	addCharacterToList('fizzVoltz')
end

function onStepHit()
	if curStep == 196 then
		triggerEvent('Change Character', '0', 'voltzFresh1')
		triggerEvent('Play Animation', 'idle', 'bf')
	end
	if curStep == 220 then
		doTweenAlpha('aaa', 'camHUD', 0, 0.95, 'linear')
	end

	if curStep == 256 then
		doTweenAlpha('aaa', 'camHUD', 1, 0.5, 'linear')
		triggerEvent('Change Character', '0', 'fizzVoltz')
		triggerEvent('Play Animation', 'singUP-alt', 'bf')
	end
	if curStep == 257 then
		triggerEvent('Change Character', '0', 'voltzPlayable')
	end
	if curStep == 455 then
		triggerEvent('Change Character', '0', 'voltzFresh2')
		triggerEvent('Play Animation', 'idle', 'bf')
	end
	if curStep == 476 then
		doTweenAlpha('aaa', 'camHUD', 0, 0.95, 'linear')
	end
	if curStep == 512 then
		doTweenAlpha('aaa', 'camHUD', 1, 0.5, 'linear')
	end
	if curStep == 518 then
		triggerEvent('Change Character', '0', 'voltzPlayable')
	end
end

function onSongStart()
	if isStoryMode then
		setProperty('fakeN2.offset.y', 45)
		debugPrint(getProperty('fakeN0.offset.y'))
	end
end
