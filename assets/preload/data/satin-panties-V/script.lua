function onCreate()
	runTimer('startDelay', 0.1)
	cameraSetTarget('boyfriend')
end

function onSongStart()
	triggerEvent("Camera Follow Pos", "479.5", "306.5")
	runTimer('c', 0.1, 1)
	if isStoryMode then
		setProperty('fakeN0.offset.y', 20.5)
		setProperty('fakeN0.offset.x', 36.5)
		setProperty('fakeN2.offset.y', 45)
	end
end

function onTimerCompleted(tag)
	if tag == 'startDelay' then
		triggerEvent('Play Animation', 'hat', 'bf')
	elseif tag == 'c' then
		triggerEvent("Camera Follow Pos", "", "")
	end
end