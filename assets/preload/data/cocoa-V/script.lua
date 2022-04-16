function onSongStart()
	if not isStoryMode then
		setProperty('fakeN0.offset.y', 20)
		setProperty('fakeN0.offset.x', 36.5)
		setProperty('fakeN2.offset.y', 41.5)
	else
		setProperty('fakeN0.offset.y', 20)
		setProperty('fakeN0.offset.x', 36.5)
		setProperty('fakeN2.offset.y', 45)
	end
end

