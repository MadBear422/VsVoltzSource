function onStartCountdown()
	setProperty('defaultCamZoom', 1.2)
end

function onBeatHit()
	if mustHitSection == true then
		setProperty('defaultCamZoom', 0.9)
	elseif mustHitSection == false then
		setProperty('defaultCamZoom', 1.2)
	end
end

function onSongStart()
	if not isStoryMode then
		setProperty('fakeN0.offset.y', 20.5)
		setProperty('fakeN2.offset.y', 39.5)
	else
		setProperty('fakeN0.offset.y', 20.5)
		setProperty('fakeN2.offset.y', 45)
		setProperty('fakeN0.offset.x', 36)
	end
end

function onUpdatePost(elapsed)
	if getProperty('fakeVoltz.animation.curAnim.finished') and getProperty('fakeVoltz.visible') then
		setProperty('fakeVoltz.visible', false)
		setProperty('boyfriendGroup.visible', true)
		setProperty('boyfriend.visible', true)
		characterPlayAnim('boyfriend', 'idle', false)
	end
end